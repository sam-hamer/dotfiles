# Dotfiles and Config

This directory contains the dotfiles and other information to configure my system.

## Requirements

Ensure you have the following installed on your system

### Homebrew

https://brew.sh/

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

## Other Software

### Raycast

https://www.raycast.com/
```
brew install --cask raycast
```

### WezTerm

https://github.com/wez/wezterm
```
bbrew install --cask wezterm
```

### Visual Studio Code

https://code.visualstudio.com/
```
brew install --cask visual-studio-code
```

### Bartender 5

https://www.macbartender.com/

### Stats

https://github.com/exelban/stats
```
brew install --cask stats
```