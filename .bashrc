#!/bin/bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Environment variables (don't know if this should be on profile, but
# git-bash doesn't read the profile)
export MYREPOS="$HOME/repos/github.com/purplesunk"
export DOTFILES="$MYREPOS/dot"
export SCRIPTS="$DOTFILES/scripts"
export GOPATH="$HOME/.local/go"
export GOBIN="$HOME/.local/bin"

# PATH -- from rwxwob.tv bashrc
pathappend() {
	declare arg
	for arg in "$@"; do
		test -d "$arg" || continue
		PATH=${PATH//":$arg:"/:}
		PATH=${PATH/#"$arg:"/}
		PATH=${PATH/%":$arg"/}
		export PATH="${PATH:+"$PATH:"}$arg"
	done
} && export -f pathappend

pathprepend() {
	for arg in "$@"; do
		test -d "$arg" || continue
		PATH=${PATH//:"$arg:"/:}
		PATH=${PATH/#"$arg:"/}
		PATH=${PATH/%":$arg"/}
		export PATH="$arg${PATH:+":${PATH}"}"
	done
} && export -f pathprepend

pathappend \
    "$SCRIPTS" \
    "$HOME/.local/bin" \
    "$HOME/.local/go/bin" \
    "$HOME/.local/share/racket/8.12/bin"

# CDPATH
export CDPATH=".:$HOME:$MYREPOS"

shopt -s checkwinsize # Check rows and columns before running command
# Check what this do:
# shopt -s expand_aliases
# shopt -s globstar
# shopt -s dotglob
# shopt -s extglob

# History
shopt -s histappend
HISTSIZE=10000
HISTFILESIZE=100000
PROMPT_COMMAND='history -a'

HISTCONTROL=ignoreboth
HISTIGNORE='ls:ll:ls -alh:pwd:clear:history'

# PROMPT, Maybe move this to another file?
# Git branch
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo -n "*"
}
function parse_git_branch {
  git branch --no-color --format=%\(refname:short\) 2> /dev/null | sed -e "s/\(.*\)/ (\1$(parse_git_dirty))/"
}

#PROMPT_DIRTRIM=3
export PS1="\[\033[35m\]\u\[\033[31m\]@\h \[\033[32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \$ "

# ALIASES
alias ls='ls -h --color=auto --group-directories-first'
alias ll='ls -la -h --color=auto --group-directories-first'
# alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
# alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
alias path='printf "${PATH//:/\\n}\n"'
alias cdpath='printf "${CDPATH//:/\\n}\n"'
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias "?"='duck'
alias tmux='tmux -f "$HOME/.config/tmux/tmux.conf"'
alias vim=nvim
alias python=python3


# Import folder aliases
[[ -f "$HOME/.config/aliases" ]] && \
  . "$HOME/.config/aliases"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Vi mode
set -o vi

complete -cf doas
complete -F _command doas

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
