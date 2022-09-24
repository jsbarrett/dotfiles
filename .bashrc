#!/usr/bin/env bash

if [ -t 1 ]
then
  ### MORE SENSIBLE BASH
  bind "set completion-ignore-case on"
  bind "set completion-map-case on"
  bind "set show-all-if-ambiguous on"

  bind 'TAB:menu-complete'
fi

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=100000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:x:clear"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

shopt -s autocd
shopt -s dirspell
shopt -s cdspell

# get colors working in bash
export TERM=xterm-256color

# get colors working in tmux
alias tmux="TERM=xterm-256color tmux"
alias x="exit"

export VISUAL="vim"
export EDITOR="$VISUAL"
export GOPATH="$HOME/.golibs"
export BUN_INSTALL="/home/jacob/.bun"
export PATH="$PATH:$HOME/bin:$HOME/.scripts"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/usr/local/go/bin:$GOPATH"
export PATH="$PATH:/usr/local/go/bin:$GOPATH"
export PATH="$PATH:$BUN_INSTALL/bin"
export GOPATH="$GOPATH:$HOME/git-repos/go"
export APTOS_DISABLE_TELEMETRY="true"

alias ls="ls --group-directories-first --color=tty"
alias ll="ls -A"
alias gs="gst"
alias solc="sudo docker run --rm ethereum/solc:0.8.13"

[ -x "$(command -v rg)" ] && export FZF_DEFAULT_COMMAND='rg --files'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"

# echo "$(__git_ps1)"
source ~/.git-prompt.sh
source ~/.git-completion.bash
PROMPT_COMMAND='__git_ps1 "\w" "\\\$ "'

# Record each line as it gets issued
# PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# PS1="\w$(__git_ps1)$ "

export PATH="$PATH:/home/jacob/.foundry/bin"
export PATH="$PATH:/home/jacob/.local/share/solana/install/active_release/bin"
export PATH="$PATH:/home/jacob/.avm/bin"

