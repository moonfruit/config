#!/bin/sh

while read DOC; do
	ln -sfv /usr/share/doc/${DOC}
done < doclist

#ln -sfv ~/Download/Zimbu/docs ./zimbu
