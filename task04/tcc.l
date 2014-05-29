%option noyywrap
%option yylineno
%{
#include "tcc.tab.h"
int yylval;
%}
digit [0-9]
alphabet [a-zA-z]
keyword int|if|else|while|return
symbol "+"|"-"|"*"|"/"|","|";"|"("|")"|"{"|"}"|"="
%%

{digit}+ {
  yylval = atoi(yytext);
  return Integer;
}

int    return Int;
if     return If;
else   return Else;
while  return While;
return return Return;
"=="   return Equal;
"||"   return OR;
"&&"   return AND;
"<="   return LEQ;
">="   return GEQ;
"!="   return NEQ;

{symbol}  return *yytext;

{alphabet}({alphabet}|{digit})* {
  return Identifier;
}

[ \t\n]  ;
.  yyerror("Error: invalid character");
%%
