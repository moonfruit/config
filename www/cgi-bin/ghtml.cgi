#!/bin/sh
echo "content-type: text/html; charset=GBK"
echo
gzip -S ghtml -d -c "$1"
