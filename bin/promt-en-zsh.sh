#!/bin/zsh
PROMPT="%{$fg[blue]%}%T %{$fg[cyan]%}%n%{$fg[blue]%}@%{$fg[cyan]%}%m ${PROMPT}"

# TRAMP EMACS
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

