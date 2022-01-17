#!/bin/bash

set -eu -o pipefail

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privileges to run this script"

myApps="herbstluftwm dzen2 libx11-dev libxft-dev libxinerama-dev zsh git neovim stow yarn fzf kitty rofi polybar"
aptitude update && aptitude install -y $myApps 

stow herbstluftwm
stow nvim
stow zsh
stow kitty
stow rofi
stow polybar

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

command -v zsh | sudo tee -a /etc/shells
chsh -s $(which zsh) 
