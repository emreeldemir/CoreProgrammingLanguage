core  : core.l core.y
		yacc -d core.y
		lex core.l
		gcc -o core lex.yy.c y.tab.c -ll
	
clean :
		rm -f y.tab.c y.tab.h lex.yy.c core
