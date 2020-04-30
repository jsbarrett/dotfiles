#!/usr/bin/env bash

### MORE SENSIBLE BASH
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
# HISTSIZE=500000
# HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

shopt -s autocd
shopt -s dirspell
shopt -s cdspell

bind 'TAB:menu-complete'

# get colors working in bash
export TERM=xterm-256color

# get colors working in tmux
alias tmux="TERM=xterm-256color tmux"

export VISUAL="vim"
export EDITOR="$VISUAL"

alias ls="ls --group-directories-first --color=tty"
alias ll="ls -A"

[ -x "$(command -v rg)" ] && export FZF_DEFAULT_COMMAND='rg --files'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
