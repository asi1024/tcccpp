#!/bin/bash

bison -d tcc.y
flex tcc.l
gcc -o tcc tcc.tab.c lex.yy.c
./tcc < test.tc
