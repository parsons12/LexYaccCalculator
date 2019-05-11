%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
void yyerror(char *);
%}

%%

[a-z]			{ yylval.intVal = *yytext - 'a'; return VARIABLE; }	/* convert a-z to int */
[0-9]+			{ yylval.intVal = atoi(yytext); return INTEGER; }
([0-9]*[.])?[0-9]+	{ yylval.doubleVal = atof(yytext); return DOUBLE; }
print			{	return PRINT;  }
;					{ return SEMICOLON; }
[-+()=*/\n]		{ return *yytext; }
[ \t]+			;	/* skip whitespace */
.			yyerror("Unknown Character");	/* throw error for any other character */

%%
int yywrap(void)
{
	return 1;
}
