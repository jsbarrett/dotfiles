#!/bin/bash
git submodule init
git submodule update

ln -s $PWD/.vimrc /home/$USER/.vimrc
ln -s $PWD/.vim /home/$USER/.vim
ln -s $PWD/.tmux.conf /home/$USER/.tmux.conf
ln -s $PWD/.bashrc /home/$USER/.bashrc
ln -s $PWD/.profile /home/$USER/.profile

