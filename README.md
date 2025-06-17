# Dotfiles and Config

This directory contains the dotfiles and other information to configure my system.

## Requirements

Ensure you have the following installed on your system

### Homebrew

https://brew.sh/

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### nvm

https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
```

### Git

```
brew install git
```

### Stow

```
brew install stow
```

### Starship

https://github.com/starship/starship
```
brew install starship
```

### Zsh Plugins

#### fzf

https://github.com/junegunn/fzf
```
brew install fzf
```

#### zoxide

https://github.com/ajeetdsouza/zoxide
```
brew install zoxide
```

#### eza

https://github.com/eza-community/eza
```
brew install eza
```

#### zsh-autosuggestions

https://github.com/zsh-users/zsh-autosuggestions
```
brew install zsh-autosuggestions
```

#### zsh-syntax-highlighting

https://github.com/zsh-users/zsh-syntax-highlighting
```
brew install zsh-syntax-highlighting
```

### SF Pro Mono Nerd Font Ligaturized

https://github.com/shaunsingh/SFMono-Nerd-Font-Ligaturized
```
brew tap shaunsingh/SFMono-Nerd-Font-Ligaturized
brew install --cask font-sf-mono-nerd-font-ligaturized
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone https://github.com/sam-hamer/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow [insert folder name]
```

## Other Software and GUI Apps

### 1Password

https://www.1password.com/
```
brew install --cask 1password
```

### Raycast

https://www.raycast.com/
```
brew install --cask raycast
```

### Zen

https://zen-browser.app
```
brew install --cask zen
```

### WezTerm

https://github.com/wez/wezterm
```
brew install --cask wezterm
```

### Cursor

https://www.cursor.com
```
brew install --cask cursor
```

### Bartender 5

https://www.macbartender.com/

### Stats

https://github.com/exelban/stats
```
brew install --cask stats
```

### BetterDisplay

https://github.com/waydabber/BetterDisplay
```
brew install --cask betterdisplay
```

### Karabiner Elements

https://karabiner-elements.pqrs.org/
```
brew install --cask karabiner-elements
```

### LinearMouse

https://linearmouse.app/
```
brew install --cask linearmouse
```

### Obsidian

https://obsidian.md/
```
brew install --cask obsidian
```

### TickTick

https://www.ticktick.com/
```
brew install --cask ticktick
```

### Discord

https://discord.com/
```
brew install --cask discord
```

## Browser Extensions and Settings
- uBlock Origin
- TamperMonkey
    - userscript for twitch ads: https://github.com/pixeltris/TwitchAdSolutions?tab=readme-ov-file#scripts
- SponsorBlock
- 1Password

## MacOS Specific Settings

### Desktop & Dock
- Hide Dock
    ```
    defaults write com.apple.dock autohide-delay -float 0.1; defaults write com.apple.dock autohide-time-modifier -float 0.1;killall Dock
    ```
- Disable Hot Corners

