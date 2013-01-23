#!/usr/bin/zsh

[ -z "$PS1" ] && return

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

autoload -U url-quote-magic
zle -N self-insert url-quote-magic

setopt long_list_jobs

bindkey "^[m" copy-prev-shell-word

bindkey "\e[3~" delete-char
bindkey "\e[1~"  beginning-of-line
bindkey "\e[4~"  end-of-line

setopt interactive_comments

stty erase ^H
