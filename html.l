%option noyywrap
%option noinput
%option nounput

%{
/*
NOM : ABONNEAU
Prenom : Benjamin
lasse : 4IR-B2
*/

#include "html.tab.h"
%}

/* Déclarations des classes et des expressions régulières */

IDENTIFIERS		    [a-z][a-z0-9_]*
INTEGERS            0[xX][a-fA-F0-9]+|[0-9]+

SEPERATEUR          [ \t\n]
ESPACES             {SEPERATEUR}+
SINGLECOMMENT       "//".*

%s                  COMMENT

/*Règles de traduction*/
%%
"if"				{ return tIF; }
"else"				{ return tELSE; }
"while"				{ return tWHILE; }
"print"				{ return tPRINT; }
"return"			{ return tRETURN; }
"const"             { return tCONST; }
"int"				{ return tINT; }
"void"				{ return tVOID; }
"main"              { return tMAIN; }
{SINGLECOMMENT}     ;
"/*"		        BEGIN(COMMENT);
<COMMENT>"*/"       BEGIN(INITIAL);

<COMMENT>[^*\n]+    ;
<COMMENT>"\n"       ;
<COMMENT>"*"        ;
"+"					{ return tADD; }
"-"					{ return tSUB; }
"*"					{ return tMUL; }
"/" 				{ return tDIV; }
"<" 				{ return tLT; }
">" 				{ return tGT; }
"!=" 				{ return tNE; }
"==" 				{ return tEQ; }
">=" 				{ return tGE; }
"<=" 				{ return tLE; }
"=" 				{ return tASSIGN; }
"&&" 				{ return tAND; }
"||" 				{ return tOR; }
"{" 				{ return tLBRACE; }
"}" 				{ return tRBRACE; }
"(" 				{ return tLPAR; }
")" 				{ return tRPAR; }
";" 				{ return tSEMI; }
"," 				{ return tCOMMA; }

{IDENTIFIERS}		{yylval.sval=strdup(yytext); return tID;}
{INTEGERS}          {yylval.ival=atoi(yytext); return tNB;}
{ESPACES}           ;
.                   printf("tERROR\n");
%%