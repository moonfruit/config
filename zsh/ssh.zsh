#!/usr/bin/zsh

[ -z "$PS1" ] && return

SSH_AGENT_FILE="$ZSH/.ssh.zsh"
SSH_AGENT_PID=none

[ -r "$SSH_AGENT_FILE" ] && . "$SSH_AGENT_FILE"

if ! ps -ef | grep "$USER *$SSH_AGENT_PID.*ssh-agent" 2>&1 >/dev/null; then
	ssh-agent | grep -v echo >"$SSH_AGENT_FILE"
	. "$SSH_AGENT_FILE"
	for RSA in `ls -1 $HOME/.ssh/*_rsa`; do
		ssh-add "$RSA"
	done
fi

