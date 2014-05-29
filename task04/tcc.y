%{
#include <stdio.h>
%}
%error_verbose
%token Integer Identifier
%token Int If Else While Return Equal OR AND LEQ GEQ NEQ

%%
program:
  external-declaration
  | program external-declaration
  ;
external-declaration:
  declaration
  | function-definition
  ;
declaration:
  Int declarator-list ';'
  ;
declarator-list:
  declarator
  | declarator-list ',' declarator
  ;
declarator:
  identifier
  ;
function-definition:
  Int declarator '(' ')' compound-statement
  | Int declarator '(' parameter-type-list ')' compound-statement
  ;
parameter-type-list:
  parameter-declaration
  | parameter-type-list ',' parameter-declaration
  ;
parameter-declaration:
  Int declarator
  ;
statement:
  ';'
  | expression ';'
  | compound-statement
  | If '(' expression ')' statement
  | If '(' expression ')' statement Else statement
  | While '(' expression ')' statement
  | Return expression ';'
  ;
compound-statement:
  '{' declaration-list statement-list '}'
  | '{' statement-list '}'
  | '{' declaration-list '}'
  | '{' '}'
  ;
declaration-list:
  declaration
  | declaration-list declaration
  ;
statement-list:
  statement
  | statement-list statement
  ;
expression:
  assign-expr
  | expression ',' assign-expr
  ;
assign-expr:
  logical-OR-expr
  | identifier '=' assign-expr
  ;
logical-OR-expr:
  logical-AND-expr
  | logical-OR-expr OR logical-AND-expr
  ;
logical-AND-expr:
  equality-expr
  | logical-AND-expr AND equality-expr
  ;
equality-expr:
  relational-expr
  | equality-expr Equal relational-expr
  | equality-expr NEQ relational-expr
  ;
relational-expr:
  add-expr
  | relational-expr '<' add-expr
  | relational-expr '>' add-expr
  | relational-expr LEQ add-expr
  | relational-expr GEQ add-expr
  ;
add-expr:
  mult-expr
  | add-expr '+' mult-expr
  | add-expr '-' mult-expr
  ;
mult-expr:
  unary-expr
  | mult-expr '*' unary-expr
  | mult-expr '/' unary-expr
unary-expr:
  postfix-expr
  | '-' unary-expr
  ;
postfix-expr:
  primary-expr
  | identifier '(' argument-expression-list ')'
  | identifier '('  ')'
  ;
primary-expr:
  identifier
  | constant
  | '(' expression ')'
  ;
argument-expression-list:
  assign-expr
  | argument-expression-list ',' assign-expr
  ;
constant:
  Integer
  ;
identifier:
  Identifier
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
