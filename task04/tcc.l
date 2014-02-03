%option noyywrap
%{
#include "tcc.tab.h"
int yylval;
%}
digit [0-9]
alphabet [a-zA-z]
keyword int|if|else|while|return
symbol "+"|"-"|"*"|"/"|","|";"|"("|")"|"{"|"}"|"="|"=="|"||"|"&&"|"<"|">"|"<="|">="
%%
{digit}+ {
  yylval = atoi(yytext);
  return Integer;
}
{keyword}|{symbol} {
  return *yytext;
}
{alphabet}({alphabet}|{digit})* {
  return Identifier;
}
[ \t\n]  ;
.  yyerror("Error: invalid character");
%%
