#!/bin/bash

for PLUGIN_NAME in $(ls ./.vim/bundle)
do
  if (test -d "./.vim/bundle/$PLUGIN_NAME")
  then
    cd ./.vim/bundle/$PLUGIN_NAME
    echo "Pulling $PLUGIN_NAME repo for any updates"
    git pull
    cd -
  fi
done
