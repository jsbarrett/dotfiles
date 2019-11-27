#!/bin/bash

date=$(date '+%Y-%m-%d--%H-%M-%S')

echo "Do you want to clone vim plugins? (y/n)"
read
if [[ $REPLY == 'y' ]]
then
  git clone https://github.com/scrooloose/nerdtree.git .vim/bundle/nerdtree
  git clone https://github.com/ctrlpvim/ctrlp.vim.git .vim/bundle/ctrlp.vim
  git clone https://github.com/mattn/emmet-vim.git .vim/bundle/emmet-vim
  git clone https://github.com/ConradIrwin/vim-bracketed-paste.git .vim/bundle/vim-bracketed-paste
  git clone https://github.com/tpope/vim-commentary.git .vim/bundle/vim-commentary
  git clone https://github.com/sheerun/vim-polyglot.git .vim/bundle/vim-polyglot
  git clone https://github.com/tpope/vim-surround.git .vim/bundle/vim-surround
  git clone https://github.com/bronson/vim-trailing-whitespace.git .vim/bundle/vim-trailing-whitespace
  git clone https://github.com/tpope/vim-repeat.git .vim/bundle/vim-repeat
  git clone https://github.com/airblade/vim-gitgutter.git .vim/bundle/vim-gitgutter
  git clone https://github.com/vim-airline/vim-airline.git .vim/bundle/vim-airline
  git clone https://github.com/edkolev/tmuxline.vim.git .vim/bundle/tmuxline
fi
echo ""
echo "----------"

function check_file () {
  if [[ -f /home/$USER/$1 ]]
  then
    echo ""
    echo "A $1 file already exists... would you like to create a bk and replace it? (y/n)"
    read
    if [[ $REPLY == "y" ]]
    then
      mv /home/$USER/$1 /home/$USER/$1.$date.bk
      ln -s $PWD/$1 /home/$USER/$1
      echo ""
      echo "$1 updated"
      echo ""
      echo "----------"
    else
      echo ""
      echo "$1 not changed"
      echo ""
      echo "----------"
    fi
  else
    echo ""
    echo "$1 updated"
    echo ""
    echo "----------"
    ln -s $PWD/$1 /home/$USER/$1
  fi
}

check_file ".vimrc"
check_file ".tmux.conf"
check_file ".bashrc"
check_file ".profile"

echo ""
echo "DONE"
echo ""

