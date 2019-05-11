%{
#include <stdio.h>
#include <math.h>
void yyerror(char *);
int yylex(void);
double var[26]; /* array to store variables*/
%}

/* token types */
%union
{
  int intVal;
  double doubleVal;
  char charVal;
}
/* declare tokens */
%token <intVal> INTEGER
%token <doubleVal> DOUBLE
%token <intVal> VARIABLE
%token <charVal> PRINT
%token <charVal> SEMICOLON
%right '='
%left '+' '-'
%left '*' '/'

%%
/* start */
program:
	program statement SEMICOLON '\n'
	| program '\n'
	|
	;

/* check for type of statement */
statement:
		expression
	| PRINT expression {  printf("Printing: %g\n", $<doubleVal>2); }/* for Printing */
	| PRINT VARIABLE '=' expression {  printf("Printing: %g\n", $<doubleVal>4); }/* for printing*/
	| assignment
	;

/* storing variables in array */
assignment:
	VARIABLE '=' assignment { var[$<intVal>1] = var[$<intVal>3]; }
	| VARIABLE '=' expression { var[$<intVal>1] = $<doubleVal>3; }
	;

/* calculations */
expression:
	DOUBLE
	| INTEGER { $<doubleVal>$ = $<intVal>1; }
	| VARIABLE { $<doubleVal>$ = var[$<intVal>1]; }
	| '-' expression { $<doubleVal>$ = -$<doubleVal>2; }
	| expression '+' expression { $<doubleVal>$ = $<doubleVal>1 + $<doubleVal>3;
																printf("%g + %g = %g\n",$<doubleVal>1, $<doubleVal>3,$<doubleVal>$);}
	| expression '-' expression { $<doubleVal>$ = $<doubleVal>1 - $<doubleVal>3;
																printf("%g - %g = %g\n",$<doubleVal>1, $<doubleVal>3,$<doubleVal>$);}
	| expression '*' expression { $<doubleVal>$ = $<doubleVal>1 * $<doubleVal>3;
																printf("%g * %g = %g\n",$<doubleVal>1, $<doubleVal>3,$<doubleVal>$);}
	| expression '/' expression { $<doubleVal>$ = $<doubleVal>1 / $<doubleVal>3;
																printf("%g / %g = %g\n",$<doubleVal>1, $<doubleVal>3,$<doubleVal>$);}
	| '(' expression ')' { $<doubleVal>$ = $<doubleVal>2; }
	;
%%
void yyerror(char *s)
{
	fprintf(stderr, "%s\n", s);
}
int main(void)
{
	yyparse();
}
