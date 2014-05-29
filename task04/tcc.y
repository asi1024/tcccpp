%{
#include <stdio.h>
%}
//%define parse.error verbose
%token Integer Identifier

%%
program:
  external-declaration ;
  | program external-declaration ;
  ;
external-declaration:
  declaration ;
  | function-definition ;
  ;
declaration:
  "int" declarator-list ';' ;
  ;
declarator-list:
  declarator ;
  | declarator-list ',' declarator ;
  ;
declarator:
  identifier ;
  ;
function-definition:
  "int" declarator '(' parameter-type-list ')' compound-statement ;
  ;
parameter-type-list:
  ;
  | parameter-type-list ',' parameter-declaration ;
  ;
parameter-declaration:
  "int" declarator ;
  ;
statement:
  ';' ;
  | expression ';' ;
  | compound-statement ;
  | "if" '(' expression ')' statement ;
  | "if" '(' expression ')' statement "else" statement ;
  | "while" '(' expression ')' statement ;
  | "return" expression ';' ;
  ;
compound-statement:
  '{' declaration-list statement-list '}' ;
  ;
declaration-list:
  ;
  | declaration-list declaration ;
  ;
statement-list:
  ;
  | statement-list statement ;
  ;
expression:
  assign-expr ;
  | expression ',' assign-expr ;
  ;
assign-expr:
  logical-OR-expr ;
  | identifier '=' assign-expr ;
  ;
logical-OR-expr:
  logical-AND-expr ;
  | logical-OR-expr "||" logical-AND-expr ;
  ;
logical-AND-expr:
  equality-expr ;
  | logical-AND-expr "&&" equality-expr ;
  ;
equality-expr:
  relational-expr ;
  | equality-expr "==" relational-expr ;
  | equality-expr "!=" relational-expr ;
  ;
relational-expr:
  add-expr ;
  | relational-expr '<' add-expr ;
  | relational-expr '>' add-expr ;
  | relational-expr "<=" add-expr ;
  | relational-expr ">=" add-expr ;
  ;
add-expr:
  mult-expr ;
  | add-expr '+' mult-expr ;
  | add-expr '-' mult-expr ;
  ;
mult-expr:
  unary-expr ;
  | mult-expr '*' unary-expr ;
  | mult-expr '/' unary-expr ;
unary-expr:
  postfix-expr ;
  | '-' unary-expr ;
  ;
postfix-expr:
  primary-expr ;
  | identifier '(' argument-expression-list ')' ;
  | identifier '('  ')' ;
  ;
primary-expr:
  identifier ;
  | constant ;
  | '(' expression ')' ;
  ;
argument-expression-list:
  assign-expr ;
  | argument-expression-list ',' assign-expr ;
  ;
constant:
  Integer ;
  ;
identifier:
  Identifier ;
  ;
%%
extern int yylineno;

int yyerror(char *s) {
  fprintf(stderr, "%d: %s\n", yylineno, s);
  return 0;
}
main() {
  yyparse();
}
