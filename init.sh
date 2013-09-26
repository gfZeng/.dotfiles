#!/usr/bin/env bash
files=(.zsh_completion .zshrc .bash_profile .bashrc .emacs .emacs.d .gvimrc .tmux.conf .vim .vimrc .xinitrc)
PWD=$(pwd)
for f in ${files[@]}
do
    rm ~/$f
    echo "~/$f ---> $PWD/$f"
    ln -s $PWD/$f ~/$f
done
