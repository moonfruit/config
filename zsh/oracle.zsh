#!/bin/zsh

export ORACLE_BASE="$HOME/download/instantclient_11_2"
export ORACLE_HOME="$ORACLE_BASE"
export ORACLE_SID="oradb"

if [ -z "$PUTTY" ]; then
	export NLS_LANG="SIMPLIFIED CHINESE_CHINA.AL32UTF8"
else
	export NLS_LANG="SIMPLIFIED CHINESE_CHINA.ZHS16GBK"
fi

export PATH="$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/sdk"
export LIBPATH="$LIBPATH:$ORACLE_HOME/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$ORACLE_HOME/lib"

export DBI_TYPE="oracle"

export DBI_APP_USER="app"
export DBI_APP_PASS="app"
export DBI_APP_CONNSTR="$DBI_APP_USER/$DBI_APP_PASS@$ORACLE_SID"

export DBI_USER="orauser"
export DBI_PASS="orauser"
export DBI_CONNSTR="$DBI_USER/$DBI_PASS@$ORACLE_SID"

alias sqlci="sqlplus $DBI_APP_CONNSTR"
alias sqlai="sqlplus $DBI_CONNSTR"
