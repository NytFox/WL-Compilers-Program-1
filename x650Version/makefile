assembler	:gram.o lex.o symtab.o list.o main.o
		cc -g gram.o lex.o symtab.o list.o main.o -o assembler -ll

gram.o		: defs.h gram.c lex.o symtab.o list.o main.o
		cc -g -c -g gram.c

gram.c		: gram.y
		yacc -dv gram.y
		cp y.tab.c gram.c

gram.y		: gram.tok gram.prod
		cat gram.tok gram.prod > gram.y

lex.o		: defs.h gram.tok lex.c
		cc -g -c -g lex.c

lex.c		: lex.l
		lex lex.l
		cp lex.yy.c lex.c

symtab.o	: defs.h 
		cc -g -c -g symtab.c

list.o		: defs.h 
		cc -g -c -g list.c

main.o		: defs.h 
		cc -g -c -g main.c

clean		:
		rm assembler *.o gram.y gram.c lex.c y.tab.h y.tab.c y.output
