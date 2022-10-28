#!/bin/bash

echo "Public speaking is very easy." >> instr
echo "1 2 6 24 120 720" >> instr
echo "1 b 214" >> instr
echo "9" >> instr
echo "opekmq" >> instr
echo "4 2 6 1 3 5" >> instr

cat instr | tr -d ' ' | tr -d '\n'

echo