## Purpose
This repository is here to make it easier for me to manage all my random config files.

## Clone repo

- Clone the repository: `git clone --recursive https://github.com/MichaelSquires/dotfiles.git .dotfiles`
- If you forgot the `--recursive`, run these commands to pull the submodules
  `git submodule init`
  `git submodule update`

## Linux install

1. Change to directory: `cd .dotfiles`
1. Install with stow: `stow bash config ssh tmux vim`

## Windows install

1. From command prompt with administrator access:
  ```
  mklink _vimrc path\to\dotfiles\vim\.vimrc
  mklink /d vimfiles path\to\dotfiles\vim\.vim
  mklink /d .vim path\to\dofiles\vim\.vim
  mkdir "AppData\Local\Microsoft\Windows Terminal\Fragments"
  mklink /d "AppData\Local\Microsoft\Windows Terminal\Fragments\%USERNAME%" path\to\dotfiles\terminal
  ```

2. Set the following user environment variables:

- `XDG_CONFIG_HOME` -> `%USERPROFILE%\dotfiles\config\.config`
