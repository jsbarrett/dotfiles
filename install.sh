#!/bin/bash

date=$(date '+%Y-%m-%d--%H-%M-%S')

echo "Do you want to clone vim plugins? (y/n)"
read
if [[ $REPLY == 'y' ]]
then
  for PLUGIN in $(cat ./vim-plugins)
  do
    # strip off url part
    PLUGIN_NAME=$(echo "$PLUGIN" | perl -pe 's/https:\/\/github.com\/.*?\///' | sed 's/\.git//')

    # clone if it doesn't already exist
    if (test -d "./.vim/bundle/$PLUGIN_NAME")
    then
      echo "$PLUGIN_NAME exists already"
    else
      git clone $PLUGIN ./.vim/bundle/$PLUGIN_NAME
    fi
  done
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

