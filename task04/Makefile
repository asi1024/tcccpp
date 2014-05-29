#Makefile
all: tcc

tcc: tcc.tab.c lex.yy.c
	gcc -o tcc tcc.tab.c lex.yy.c

tcc.tab.c: tcc.y
	bison -d tcc.y

lex.yy.c: tcc.l
	flex tcc.l

clean:
	rm -f tcc tcc.tab.h tcc.tab.c lex.yy.c
