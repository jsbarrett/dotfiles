# vim-setup

This is currently my vim, tmux, and bashrc setup.
My preference is to use zsh instead of bash and use an oh-my-zsh theme, but due to not always being able to install zsh I have for now committed to using bash as my default setup.

## Install
You clone this repo and then you just need to cd into it and run the install script:
`./install.sh`
This will first download all of the dependencies from github and then create symlinks in your home directory and then it'll setup bash_it for you. Once it finishes you will need to run: `source ~/.bashrc` for the bash changes to take effect.
