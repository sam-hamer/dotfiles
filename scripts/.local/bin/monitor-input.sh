#!/usr/bin/env bash
# mon-input — switch monitor inputs over DDC/CI
#
# Usage:
#   mon-input <monitor> <input>              set an input
#   mon-input <monitor> toggle <in> <in>     flip between two inputs
#   mon-input <monitor> status               show current input
#   mon-input status                         show all monitors
#   mon-input refresh                        rebuild the connector->bus cache
#   mon-input debug                          show how buses were resolved
#   mon-input list                           show known names
#
# Monitors are addressed by DRM connector name. The I2C bus is resolved from
# sysfs when the kernel exposes it, otherwise from a cached `ddcutil detect`.

set -uo pipefail

# --- VCP 0x60 values, verified on Gigabyte M32U ------------------------------
declare -A INPUTS=(
	[dp1]=0x0f
	[usbc]=0x10
	[hdmi1]=0x11
	[hdmi2]=0x12
)

# --- short aliases -> DRM connector ------------------------------------------
declare -A MONITORS=(
	[1]=HDMI-A-1
	[2]=DP-1
)

DDCUTIL=${DDCUTIL:-ddcutil}
SLEEP_MULT=${MON_INPUT_SLEEP:-}
CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/mon-input.map"

warn() { printf 'mon-input: %s\n' "$*" >&2; }
die() {
	warn "$*"
	exit 1
}

ddc() {
	local bus=$1
	shift
	local -a opts=(--bus "$bus" --noverify)
	[[ -n $SLEEP_MULT ]] && opts+=(--sleep-multiplier "$SLEEP_MULT")
	"$DDCUTIL" "${opts[@]}" "$@"
}

# --- connector -> bus --------------------------------------------------------

# Fast path: kernel-provided link. Absent on drivers that don't register the
# connector's I2C adapter (e.g. the nvidia proprietary driver).
bus_from_sysfs() {
	local conn=$1 link dev
	for link in /sys/class/drm/card*-"$conn"/ddc; do
		[[ -e $link ]] || continue
		dev=$(basename "$(readlink -f "$link")") # i2c-N
		printf '%s\n' "${dev#i2c-}"
		return 0
	done
	return 1
}

build_cache() {
	local out
	out=$("$DDCUTIL" detect 2>/dev/null | awk '
		/I2C bus:/       { bus=$NF; sub(/.*i2c-/, "", bus) }
		/DRM_connector:/ { conn=$NF; sub(/^card[0-9]+-/, "", conn)
		                   if (bus != "" && conn ~ /^[A-Za-z]/) { print conn, bus; bus="" } }
	')
	[[ -n $out ]] || return 1
	mkdir -p "$(dirname "$CACHE")"
	printf '%s\n' "$out" >"$CACHE"
}

lookup_cache() { awk -v c="$1" '$1 == c { print $2; exit }' "$CACHE" 2>/dev/null; }

bus_from_cache() {
	local conn=$1 bus
	[[ -s $CACHE ]] || build_cache || return 1
	bus=$(lookup_cache "$conn")
	if [[ -z $bus ]]; then
		build_cache || return 1
		bus=$(lookup_cache "$conn")
	fi
	[[ -n $bus ]] || return 1
	printf '%s\n' "$bus"
}

bus_for() { bus_from_sysfs "$1" || bus_from_cache "$1"; }

connector_of() { printf '%s\n' "${MONITORS[$1]:-$1}"; }

# --- input names -------------------------------------------------------------

resolve_input() {
	local key=${1,,}
	if [[ -n ${INPUTS[$key]:-} ]]; then
		printf '%s\n' "${INPUTS[$key]}"
		return 0
	fi
	[[ $key =~ ^(0x)?[0-9a-f]{1,2}$ ]] ||
		die "unknown input '$1' (known: ${!INPUTS[*]}, or a raw hex value)"
	printf '0x%02x\n' "$((16#${key#0x}))"
}

current_input() {
	local bus=$1 raw
	raw=$("$DDCUTIL" --bus "$bus" --noverify getvcp 60 --terse 2>/dev/null) || return 1
	raw=${raw##* }
	[[ $raw =~ ^x?[0-9a-fA-F]{1,2}$ ]] || return 1
	printf '0x%02x\n' "$((16#${raw#x}))"
}

name_of() {
	local v=$1 k
	for k in "${!INPUTS[@]}"; do
		[[ ${INPUTS[$k]} == "$v" ]] && {
			printf '%s\n' "$k"
			return
		}
	done
	printf '%s\n' "$v"
}

show_status() {
	local conn bus cur
	conn=$(connector_of "$1")
	if ! bus=$(bus_for "$conn"); then
		printf '%-12s %-8s %s\n' "$conn" "-" "no bus (try: mon-input refresh)"
		return 1
	fi
	if cur=$(current_input "$bus"); then
		printf '%-12s bus %-4s %s (%s)\n' "$conn" "$bus" "$(name_of "$cur")" "$cur"
	else
		printf '%-12s bus %-4s no response\n' "$conn" "$bus"
		return 1
	fi
}

# --- dispatch ----------------------------------------------------------------

case "${1:-status}" in
list)
	printf 'monitors:\n'
	for k in "${!MONITORS[@]}"; do printf '  %-6s %s\n' "$k" "${MONITORS[$k]}"; done
	printf 'inputs:\n'
	for k in "${!INPUTS[@]}"; do printf '  %-6s %s\n' "$k" "${INPUTS[$k]}"; done
	exit 0
	;;
refresh)
	rm -f "$CACHE"
	build_cache || die "ddcutil detect returned no usable connector mapping"
	printf 'cached %s:\n' "$CACHE"
	cat "$CACHE"
	exit 0
	;;
debug)
	printf 'sysfs connectors:\n'
	ls -d /sys/class/drm/card*-* 2>/dev/null | sed 's|^|  |'
	printf 'sysfs ddc links:\n'
	find /sys/class/drm -maxdepth 2 -name ddc 2>/dev/null |
		while read -r l; do printf '  %s -> %s\n' "$l" "$(readlink -f "$l")"; done
	printf 'cache (%s):\n' "$CACHE"
	if [[ -s $CACHE ]]; then sed 's|^|  |' "$CACHE"; else printf '  (empty)\n'; fi
	printf 'resolution:\n'
	for k in "${!MONITORS[@]}"; do
		c=$(connector_of "$k")
		printf '  %-4s %-12s sysfs=%s cache=%s\n' \
			"$k" "$c" "$(bus_from_sysfs "$c" || echo -)" "$(bus_from_cache "$c" || echo -)"
	done
	exit 0
	;;
status)
	rc=0
	for k in $(printf '%s\n' "${!MONITORS[@]}" | sort); do
		show_status "$k" || rc=1
	done
	exit $rc
	;;
esac

mon=$1
shift || die "missing input; try: mon-input list"

conn=$(connector_of "$mon")
bus=$(bus_for "$conn") ||
	die "no I2C bus for connector '$conn' (from '$mon'); run: mon-input debug"

case "${1:-}" in
status)
	show_status "$mon"
	;;
toggle)
	a=$(resolve_input "${2:?toggle needs two inputs}") || exit 1
	b=$(resolve_input "${3:?toggle needs two inputs}") || exit 1
	cur=$(current_input "$bus") || die "$conn did not answer getvcp 60"
	[[ $cur == "$a" ]] && target=$b || target=$a
	ddc "$bus" setvcp 60 "$target"
	;;
*)
	target=$(resolve_input "${1:?missing input}") || exit 1
	ddc "$bus" setvcp 60 "$target"
	;;
esac
