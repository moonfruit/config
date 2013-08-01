#!/usr/bin/zsh

[ -z "$PS1" ] && return

## Command history configuration
HISTFILE=$HOME/.zhistory
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
#setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# directory history
cd() {
    builtin cd "$@"                             # do actual cd
    fc -W                                       # write current history  file
    local HISTDIR="$HOME/.zhistory$PWD"      # use nested folders for history
        if  [ ! -d "$HISTDIR" ] ; then          # create folder if needed
            mkdir -p "$HISTDIR"
        fi
        export HISTFILE="$HISTDIR/zhistory"     # set new history file
    touch $HISTFILE
    local ohistsize=$HISTSIZE
        HISTSIZE=0                              # Discard previous dir's history
        HISTSIZE=$ohistsize                     # Prepare for new dir's history
    fc -R                                       # read from current histfile
}
mkdir -p $HOME/.zhistory$PWD
export HISTFILE="$HOME/.zhistory$PWD/zhistory"

function allhistory { find $HOME/.zhistory -name zhistory -print0 | xargs -0 cat }
function convhistory {
    sort $1 | uniq |
    sed 's/^:\([ 0-9]*\):[0-9]*;\(.*\)/\1::::::\2/' |
    awk -F"::::::" '{ $1=strftime("%Y-%m-%d %T ",$1) "|"; print }' |
    grep -v '^1970-01-01'
}

function histall { convhistory =(allhistory) | sed '/^.\{20\} *cd/i\\' }
function hist { convhistory $HISTFILE }
function h { hist | tail -40 }
function hall { histall | tail -40 }

function top40 { allhistory | awk -F':[ 0-9]*:[0-9]*;' '{ $1="" ; print }' | sed 's/[ 	][ 	]*/ /g' | sed 's/^\([ sudotime]*[^ ]*\).*/\1/' | sed '/^$/d' | sort | uniq -c | sort -nr | head -n 40 }
