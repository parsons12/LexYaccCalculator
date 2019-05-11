# LexYaccCalculator

A floating point calculator using lex and yacc syntax.

To run:

flex calc.l
yacc -d calc.y
gcc lex.yy.c y.tab.c -ll
