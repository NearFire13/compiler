%{
/*
NOM : ABONNEAU
Prenom : Benjamin 
Classe : 4IR-B2
*/

// Si même scope, même profondeur

#include <stdio.h>
#include <stdlib.h>
#include "symbol_table.c"
%}

%code provides {
  int yylex (void);
  void yyerror (const char *);
  
}

%union { char *sval; int ival }

%token <sval> tID
%token <ival> tNB
%token tLBRACE tRBRACE tLPAR tRPAR tVOID tINT tCOMMA tRETURN tSEMI tWHILE tIF tELSE tPRINT tCONST tMAIN
%token tADD tSUB tMUL tDIV tASSIGN
%token tGT tEQ tLT tNE tGE tLE tAND tOR

%nonassoc NEG

%%

function_declaration:
    function_declaration function_declaration
    | tVOID function_id tLPAR function_args tRPAR tLBRACE function_body tRBRACE { printf("get a procedure_declaration\n"); }
    | tINT function_id tLPAR function_args tRPAR tLBRACE function_body function_return tRBRACE { printf("get a function_declaration\n"); }
    ;

function_id:
    tMAIN { printf("get a function_id\n"); }
    | tID { printf("get a function_id\n"); }
    ;


function_return:
    tRETURN tID tSEMI { printf("get a function_return\n"); }
    ;

function_args:
    tVOID
    | tINT tID { printf("get a function_args\n"); }
    | tINT tID tCOMMA function_args { printf("get a function_args\n"); }
    ;

function_body:
    %empty
    | structure_while function_body  { printf("get a function_body\n"); }
    | constante_declaration function_body { printf("get a function_body\n"); }
    | variable_declaration function_body { printf("get a function_body\n"); }
    | structure_condition function_body { printf("get a function_body\n"); }
    | call_function function_body { printf("get a function_body\n"); }
    ;


constante_declaration:
    tCONST tINT tID tSEMI { printf("get a constante_declaration\n"); }
    | tCONST tINT tID tASSIGN expression tSEMI { printf("get a constante_declaration\n"); }
    | tCONST tINT body_variable tCOMMA constante_declaration { printf("get a constante_declaration\n"); }
    | body_variable tCOMMA constante_declaration { printf("get a constante_declaration\n"); }
    | body_variable tSEMI { printf("get a constante_declaration\n"); }
    ;

variable_declaration:
    tINT tID tSEMI { push_symbol(&symbol_table, $1, char * address, int profondeur, char * type); printf("get a constante_declaration\n"); }
    | tINT tID tASSIGN expression tSEMI { printf("get a constante_declaration\n"); }
    | tINT body_variable tCOMMA variable_declaration { printf("get a constante_declaration\n"); }
    | body_variable tCOMMA variable_declaration { printf("get a constante_declaration\n"); }
    | body_variable tSEMI { printf("get a constante_declaration\n"); }
    ;

body_variable:
    tID
    | tID tASSIGN expression
    ;

structure_while:
    tWHILE tLPAR condition tRPAR tLBRACE function_body tRBRACE { printf("get a structure_while\n"); }
    ;

structure_condition:
    tIF tLPAR condition tRPAR tLBRACE function_body tRBRACE { printf("get a structure_condition\n"); }
    | structure_condition tELSE tLBRACE function_body tRBRACE { printf("get a structure_condition\n"); }
    ;

expression:
    expression expression_operator expression { printf("get a expression\n"); }
    | expression_operator expression %prec NEG { printf("get a expression\n"); }
    | value { printf("get a expression\n"); }
	;

expression_operator:
    tADD { printf("get a tADD\n"); }
    | tSUB { printf("get a tSUB\n"); }
    | tMUL { printf("get a tMUL\n"); }
    | tDIV { printf("get a tDIV\n"); }
    | tASSIGN { printf("get a tASSIGN\n"); }
    ; 

condition:
    condition condition_operator condition { printf("get a condition\n"); }
    | value { printf("get a condition\n"); }
    ;

value:
    tNB { printf("get a value\n"); }
    | tID { printf("get a value\n"); }

condition_operator:
    tGT { printf("get a tGT\n"); }
    | tEQ { printf("get a tEQ\n"); }
    | tLT { printf("get a tLT\n"); }
    | tNE { printf("get a tNE\n"); }
    | tGE { printf("get a tGE\n"); }
    | tLE { printf("get a tLE\n"); }
    | tAND { printf("get a tAND\n"); }
    | tOR { printf("get a tOR\n"); }
    ;

call_function:
    tPRINT tLPAR expression tRPAR tSEMI { printf("get a call_function\n"); }
    | tINT tID tASSIGN tID tLPAR call_args tRPAR tSEMI { printf("get a call_function\n"); }
    ;

call_args:
    expression { printf("get a call_args\n"); }
    | expression tCOMMA call_args { printf("get a call_args\n"); }
    ;
%%

void yyerror(const char *msg) {
  fprintf(stderr, "error: %s\n", msg);
  exit(1);
}

int main(void)
{
  if(yyparse() == 0)
  {
    printf("Analyse réussie\n");
  }
}
