#!/bin/bash

mkdir -p ~/.config/nvim
ln -sf $PWD/bash_profile ~/.bash_profile
ln -sf $PWD/gitconfig ~/.gitconfig
ln -sf $PWD/gitignore ~/.gitignore
ln -sf $PWD/tmux.conf ~/.tmux.conf
ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/vimrc ~/.config/nvim/init.vim
ln -sf $PWD/ctags ~/.ctags
