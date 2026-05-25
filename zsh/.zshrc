source ~/.zprofile

# ----- OS detection -----
if [[ "$OSTYPE" == darwin* ]]; then
  OS="mac"
elif [[ "$OSTYPE" == linux* ]]; then
  OS="linux"
else
  OS="unknown"
fi

# ----- Homebrew Path (mac only) -----
if [[ "$OS" == "mac" ]]; then
  if [[ -x "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# ----- Load Plugins -----
plugins=(git )

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

# ---- Eza (better ls) ----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# ---- Syntax highlighting -----
if [[ "$OS" == "mac" ]]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
else
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ---- Autosuggestions -----
if [[ "$OS" == "mac" ]]; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
else
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

