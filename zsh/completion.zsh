#!/usr/bin/zsh

[ -z "$PS1" ] && return

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_list
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

autoload -U compinit
compinit -i
zmodload -i zsh/complist

#自动补全缓存
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zcache
zstyle ':completion:*:cd:*' ignore-parents parent pwd

#自动补全选项
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always

#彩色补全菜单
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#修正大小写
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

#错误校正
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

#补全类型提示分组
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

# use /etc/hosts and known_hosts for hostname completion
[ -r /etc/ssh/ssh_known_hosts ] && _global_ssh_hosts=(${${${${(f)"$(</etc/ssh/ssh_known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r ~/.ssh/known_hosts ] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[ -r /etc/hosts ] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
	"$_global_ssh_hosts[@]"
	"$_ssh_hosts[@]"
	"$_etc_hosts[@]"
	"$HOST"
	localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
		adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
		dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
		hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
		mailman mailnull mldonkey mysql nagios \
		named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
		operator pcap postfix postgres privoxy pulse pvm quagga radvd \
		rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs \
		\
		avahi-autoipd gnats kernoops list rtkit sys whoopsie \
		backup hplip libuuid man proxy saned syslog www-data \
		colord irc lightdm messagebus root speech-dispatcher usbmux \

# cd
user-cd-complete()
{
	if [[ -n $BUFFER ]] ; then
		zle expand-or-complete
	else
		BUFFER="cd "
		zle end-of-line
		zle expand-or-complete
	fi
}
zle -N user-cd-complete
bindkey "\t" user-cd-complete

# sudo
sudo-command-line()
{
	[[ -z $BUFFER ]] && zle up-history
	[[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
	zle end-of-line
}
zle -N sudo-command-line

# go
[[ -f "/usr/local/go/misc/zsh/go" ]] && source /usr/local/go/misc/zsh/go
