#!/bin/sh

u=${1?}
git clone\
 "https://github.com/VundleVim/Vundle.vim.git/home/${u}/.vim/bundle/Vundle.vim"
mkdir -p "/home/${u}/.config"
/bin/cp -rpf config/* ~/.config
/bin/cp -rpf path/* /usr/local/bin
/bin/cp -rpf home/* "/home/${u}"
