#!/bin/bash
git submodule init
git submodule update

ln -s $PWD/.vimrc /home/$USER/.vimrc
ln -s $PWD/.vim /home/$USER/.vim

