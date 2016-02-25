compiler	:gram.o lex.o symtab.o  main.o  
		g++ gram.o lex.o symtab.o main.o -o compiler -ll

gram.o		: gram.c lex.o symtab.o main.o symtab_class_header.h
		g++ -c -g gram.c

gram.c		: gram.y symtab_class_header.h 
		yacc -d gram.y
		mv y.tab.c gram.c

gram.y		: gram.tok gram.prod
		cat gram.tok gram.prod > gram.y

lex.o		: gram.tok lex.c symtab_class_header.h 
		g++ -c -g lex.c

lex.c		: lex.l
		lex lex.l
		mv lex.yy.c lex.c

symtab.o	: symtab_class_header.h
		g++ -c -g symtab.cpp

main.o		: main.c symtab_class_header.h
		g++ -c -g main.c

clean		:
		rm compiler *.o gram.y gram.c lex.c y.tab.h y.output
