#!/bin/bash

for PLUGIN_NAME in $(ls ./.vim/bundle)
do
  # PLUGIN_NAME=$(echo "$PLUGIN" | perl -pe 's/https:\/\/github.com\/.*?\///' | sed 's/\.git//')
  if (test -d "./.vim/bundle/$PLUGIN_NAME")
  then
    cd ./.vim/bundle/$PLUGIN_NAME
    echo "Pulling $PLUGIN_NAME repo for any updates"
    git pull
    cd -
  fi
done
