#!/bin/bash

bison -d calc.y
flex calc.l
gcc -o calc lex.yy.c calc.tab.c
echo "Input :"
cat sample
echo ""
echo "Output :"
./calc < sample
