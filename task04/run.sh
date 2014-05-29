#!/bin/bash

echo "== bison -d tcc.y"
bison -d tcc.y
echo "== flex tcc.l"
flex tcc.l
echo "== gcc -o tcc tcc.tab.c lex.yy.c"
gcc -o tcc tcc.tab.c lex.yy.c
echo "== ./tcc < test.tc"
./tcc < test.tc
