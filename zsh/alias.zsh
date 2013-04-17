#!/usr/bin/zsh

[ -z "$PS1" ] && return

# enviroment
[ -x /usr/bin/dircolors ] && eval "$(dircolors)"
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export EDITOR='/usr/bin/vim'
export GREP_OPTIONS='--color=auto'
export ZLSCOLORS="${LS_COLORS}"

# alias
alias so='source'

alias -g ls='ls -Fh --color=auto'

alias ll='ls -l'
alias la='ls -A'
alias l='ll'
alias tree='tree -F'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias df='df -h'
alias du='du -h'

alias less='less -r'

alias sl='sl -e'
alias LS='sl'
alias ls-='sl'

alias c='clear'
alias cls='clear'

alias so='source'

alias diff='colordiff'

#alias tail='tail'

vman()
{
	PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
	       vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
	       -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
	       -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"" man $*
}
alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"

alias dstat='dstat -cdlmnpsy'
