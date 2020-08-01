#!/bin/bash

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
