*****************************************************

WL-Compilers-Program-3 Read Me

Author: Xinyue Wang, Li Zhang

*****************************************************
Description:

	This is a simple implementation of a cTran language compiler.

Files:
gram.prog						: bison file
gram.tok 						: bison head file 
lex.l 							: yacc file
main.c 							: test functions
makefile						: compile the program
README.md 						: readme file
symtab_class_header.h 			: symbol table header file
symtab.cpp 						: symbol talbe implementation


Running instruction:

Environment						: Linux
Command  						: 1) make
								  2) ./compiler < Inputfile > outputfile.c
								  3) access CMachine:
								  	./assembler < outputfile.c
								  	gcc outputfile.c AssemblyCode/accessories.c