#!/bin/bash

date=$(date '+%Y-%m-%d--%H-%M-%S')

echo "Do you want to clone vim plugins? (y/n)"
read
if [[ $REPLY == 'y' ]]
then
  git clone https://github.com/neoclide/coc.nvim.git .vim/bundle/coc.nvim
  # git clone https://github.com/ctrlpvim/ctrlp.vim.git .vim/bundle/ctrlp.vim
  git clone https://github.com/mattn/emmet-vim.git .vim/bundle/emmet-vim
  git clone https://github.com/scrooloose/nerdtree.git .vim/bundle/nerdtree
  # secure shell is included in the repo, no need to clone
  git clone https://github.com/edkolev/tmuxline.vim.git .vim/bundle/tmuxline
  git clone https://github.com/vim-airline/vim-airline.git .vim/bundle/vim-airline
  git clone https://github.com/ConradIrwin/vim-bracketed-paste.git .vim/bundle/vim-bracketed-paste
  git clone https://github.com/tpope/vim-commentary.git .vim/bundle/vim-commentary
  git clone https://github.com/tpope/vim-fugitive.git .vim/bundle/vim-fugitive
  git clone https://github.com/airblade/vim-gitgutter.git .vim/bundle/vim-gitgutter
  git clone https://github.com/sheerun/vim-polyglot.git .vim/bundle/vim-polyglot
  git clone https://github.com/tpope/vim-repeat.git .vim/bundle/vim-repeat
  git clone https://github.com/tpope/vim-surround.git .vim/bundle/vim-surround
  git clone https://github.com/christoomey/vim-tmux-navigator.git .vim/bundle/vim-tmux-navigator
  git clone https://github.com/bronson/vim-trailing-whitespace.git .vim/bundle/vim-trailing-whitespace
fi

echo ""
echo "----------"

echo "Do you want to clone tmux clipboard plugin? (y/n)"
read
if [[ $REPLY == 'y' ]]
then
  git clone https://github.com/tmux-plugins/tmux-yank.git .tmux/tmux-yank
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
check_file ".vim"
check_file ".tmux"

echo "Do you want to install coc.nvim dependencies (tsserver, json, html, css)? (y/n)"
read
if [[ $REPLY == 'y' ]]
then
# Install extensions for coc.nvim
  mkdir -p ~/.config/coc/extensions
  cd ~/.config/coc/extensions
  if [ ! -f package.json ]
  then
    echo '{"dependencies":{}}'> package.json
  fi
# Change extension names to the extensions you need
  npm install coc-tsserver coc-json coc-html coc-css --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
fi

cd ~/.vim/bundle/coc.nvim
./install.sh

echo ""
echo "----------"

echo "Do you want to install fzf? (y/n)"
read
if [[ $REPLY == 'y' ]]
then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

echo ""
echo "----------"

echo ""
echo "DONE"
echo ""

