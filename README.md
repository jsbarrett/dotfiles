# vim-setup

This is currently my vim, tmux, and bashrc setup.

NOTE:
- I'm using zsh (with oh-my-zsh) on a few machines. But it is not consistent. And one of the goals I have for this repo is to be as portable as possible; meaning I want to have as few system dependencies as I can manage. So far the only dependencies needed are:
  1) bash
  2) vim
  3) git
  4) tmux
  5) nodejs
  These are in order of most likely to least likely available on a Linux/GNU system already.
  They are all available on Mac OSX (I use homebrew as my package manager)
  and Windows (I use WSL but you could also use GitBash; you'd just need to add the tmux binary for it manually [https://blog.pjsen.eu/?p=440]).

## Install
You clone this repo and then you just need to cd into it and run the install script:
`./install.sh`
This will first ask if you want to download all of the vim dependencies from github and then create symlinks in your home directory for all of the necessary config files.
The idea is that the config files are where they need to be for vim/tmux/bash to use them, but they live in this repository so if I make a change then I can easily commit the change and push it back to github if I think I want to keep it (or you can do the same if you fork this project).
Once it finishes you will need to run: `source ~/.bashrc` for the bash changes to take effect.

If you have previously been using tmux then you will have to "turn it off and on again":
`killall tmux`
And then you can start it back up: `tmux`

If you get an error for tmux, there's a good chance you just need to comment out two lines and uncomment two lines (8,9,12,13).
It is because I have yet to do tmux version detection in my .tmux.conf. Maybe one of these days I'll get on that.

## Notes
- For me one of the key things I want in my development workflow is to have a seamless experience with my clipboard between my system I'm developing from and the potential server I'm working on. This includes copying/yanking text from vim or tmux and having that instantly available to paste into a web browser or notepad, as well as the reverse ... copying something to my clipboard from a browser or messaging app and then being able to paste directly into vim. This can get a little weird as when working in vim you're constantly sending things to the clipboard, so I make sure to install a clipboard history program on the computer I'm working from (the machine that is running the terminal emulator).
- I recommend installing ripgrep as it will improve the performance of fzf as well as clean up the results list by ignoring everything in your gitignore file while searching. You can find how to install it here (https://github.com/BurntSushi/ripgrep).
- I am using a NERD font (https://www.nerdfonts.com/font-downloads). It comes with powerline symbols as well as a bunch of other icons built into the font which can give your terminal/vim/tmux experience a slightly more graphical feel to it. The font does not need to be installed on the system only on the computer you're using to access it and being used by your terminal emulator. I mention that because I quite often log into another machine via ssh.
- When installing on a fresh instance of raspbian, be sure to download the full vim; `sudo apt-get install vim-gui-common` and `sudo apt-get install vim-runtime` should fix any errors with having the "Small version without GUI" that comes standard on Raspbian. Often I'll install vim-gtk now to get all the clipboard support I need.
- I often will install this setup on any system I have login access to as everything here is solely affecting the user (assuming you have the previously mentioned system dependencies bash/vim/git/tmux/nodejs and optionally ripgrep). I tried getting X11 to work while ssh'ing to a Macbook Pro (so the Mac was acting as the server). And X11 worked but the clipboard support would not (because my copy of vim does not have xterm_clipboard enabled and I have not yet figured out how to get that to work. As a hack, I installed a VM on the Mac (via Vagrant) and then ssh'd to the VM and just made sure that I mounted the folders I needed from the OSX side into the VM. It's kind of a hack but it works and lets me keep my clipboard support over X11.

