# My dotfiles

This directory contains the dotfiles and other information to configure my system.

## Requirements

Ensure you have the following installed on your system

### Git

```
brew install git
```

### Stow

```
brew install stow
```

### Starship

```
brew install starship
```

### SF Pro Mono Nerd Font Ligaturized

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
