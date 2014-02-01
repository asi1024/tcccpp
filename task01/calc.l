%option noyywrap
%{
#include "calc.tab.h"
%}
digit [0-9]
%%
{digit}+ {
           yylval = atoi(yytext);
           return Integer;
         }
"+"|"*"  {
           return *yytext;
         }
[ \t\n]  ; /* スペース，タブ，改行は無視 */
.        yyerror("Error: invalid character");
%%
