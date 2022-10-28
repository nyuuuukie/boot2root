#!/bin/bash

NUMSFILE=seq

cat > src.c << EOF
#include <stdio.h>

int main() {
    for (int a = 1; a <= 6; a++) {
        if (a != 4)
        for (int b = 1; b <= 6; b++) {
            if (b != a && b != 4)
            for (int c = 1; c <= 6; c++) {
                if (c != b && c != a && c != 4)
                for (int d = 1; d <= 6; d++) {
                    if (d != c && d != b && d != a && d != 4)
                    for (int e = 1; e <= 6; e++) {
                        if (e != d && e != c && e != b && e != a && e != 4)
                            printf("%d %d %d %d %d %d\n", 4, a, b, c, d, e);   
                    }
                }
            }   
        }
    }
    return 0;
}
EOF

gcc src.c -o genseq

./genseq > $NUMSFILE

while IFS= read -r line
do
    echo "Public speaking is very easy." > instr
    echo "1 2 6 24 120 720" >> instr
    echo "0 q 777" >> instr
    echo "9" >> instr
    echo "OPU+-Q" >> instr
    echo $line >> instr

    ./bomb instr | grep 'BOOM'

    if [ $? -eq 1 ]; then
        echo "Your line is: $line" 
        exit 1;
    fi

done < $NUMSFILE