# vim-setup

This is currently my vim, tmux, and bashrc setup.

NOTE:
- I find myself currently using VS Code (with a vim emulation plugin) as my primary editor when local development is an option. But when I need to work on the server then I'll come back to this repo for a way to quickly get up and running with better defaults.

## Install
You clone this repo and then you just need to cd into it and run the install script:
`./install.sh`
This will first download all of the dependencies from github and then create symlinks in your home directory and then it'll setup bash_it for you. Once it finishes you will need to run: `source ~/.bashrc` for the bash changes to take effect.

If you have previously been using tmux then you will have to "turn it off and on again":
`killall tmux`
And then you can start it back up: `tmux`

## Notes
- Dependencies managed with git use git submodules. Not sure the best way to install new submodules at this point. I typically just edit the .gitmodules file and then manually git clone them where I need them. Most often they are vim dependencies managed by pathogen and go into the .vim/bundle directory.
- When installing on a fresh instance of raspbian, be sure to download the full vim; `sudo apt-get install vim-gui-common` and `sudo apt-get install vim-runtime` should fix any errors with having the "Small version without GUI" that comes standard on Raspbian.

## TODOS
- Have script check for pre-existing dotfiles and then alert user of them, with option to replace them or to save them as backups.
- Remove bash_it as dependency and simplify bash config
- Create custom vim color syntax theme (or find a new one, maybe port of An Old Hope)
