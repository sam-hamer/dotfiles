# ---- Starship -----
eval "$(starship init zsh)"

# ---- SDKMAN -----
# source "$HOME/.sdkman/bin/sdkman-init.sh"

# ---- Atuin -----
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"


# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
alias cd="z"

# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# ---- Syntax highlighting -----
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# ---- Autosuggestions -----
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh


