# ----- Docker Path -----
export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ----- NVM Path -----
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# ----- SSH Agent -----
export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"