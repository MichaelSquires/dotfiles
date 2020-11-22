## Purpose
This repository is here to make it easier for me to manage all my random config files.

## Linux install

1. Clone the repository: `git clone --recursive https://github.com/MichaelSquires/dotfiles.git .dotfiles`
1. Change to directory: `cd .dotfiles`
1. Install with stow: `stow bash ssh tmux vim`

## Windows install

1. Clone the repository: `git clone --recursive https://github.com/MichaelSquires/dotfiles.git dotfiles`
1. From command prompt with administrator access:
  - mklink _vimrc path\to\dotfiles\vim\.vimrc
  - mklink /d vimfiles path\to\dotfiles\vim\.vim
