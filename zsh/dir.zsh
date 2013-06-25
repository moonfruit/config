#!/usr/bin/zsh

export  DOWNLOAD="$HOME/download"
hash -d DOWNLOAD="$DOWNLOAD"

export  DROPBOX="$HOME/dropbox"
hash -d DROPBOX="$DROPBOX"

export  VM="$HOME/vmshare"
hash -d VM="$VM"

export  WORKSPACE="$HOME/workspace"
hash -d WORKSPACE="$WORKSPACE"

export  CONFIG="$WORKSPACE/config"
hash -d CONFIG="$CONFIG"

export  DEV="$WORKSPACE/app"
hash -d DEV="$DEV"

export  APP="$DEV"
hash -d APP="$APP"

export  VAR="$APP/var"
hash -d VAR="$VAR"

export  VARLOG="$VAR/log"
hash -d LOG="$VARLOG"

export  UFRAME="$APP/prods/uframe"
hash -d UFRAME="$UFRAME"

export  UPLATFORM="$APP/prods/uplatform"
hash -d UPLATFORM="$UPLATFORM"

export  UTELLER="$APP/prods/uteller"
hash -d UTELLER="$UTELLER"

export  CNAPS="$APP/prods/cnaps"
hash -d CNAPS="$CNAPS"

export  NPS="$APP/prods/nps"
hash -d NPS="$NPS"

export  OTHER="$APP/prods/other"
hash -d OTHER="$OTHER"

export  YY="$APP/prods/yy"
hash -d YY="$YY"

dev() {
	cd ~DEV
	if [ -z "$APP_HOME" ]; then
		source env
	fi
}
