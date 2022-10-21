#!/bin/bash

NUMSFILE=seq

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