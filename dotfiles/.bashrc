#
# ~/.bashrc
#

# SSH shit
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in history.
# see bash(1) for more options
HISTCONTROL=ignoreboth

# append to history, don't overwtire.
shopt -s histappend

shopt -s checkwinsize

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Prompt design
PS1='\[\033[01;01m\]$?|\[\033[1;38;5;214m\]\u@\h\[\033[00m\] \w: \$ '


# eval commands
eval "$(thefuck --alias)"
