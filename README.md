*****************************************************

WL-Compilers-Program-4 Read Me

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



Notes (complished & not complished & problems encountered)

(we included some function at the top, in order to solve the function part, it wont go through ctran grammar test)

1. Functional for bitwise operation.

2. Functional for user function.

3. Problems encountered:
	newHanoi program wouldnt give an expected and runnable result as an output, which caused a lot confusion.

	The problems we have addressed are as followings:

	1) When ever sp goes back to original position, only the predicted part (sp = sp -200) is included, while the "pushi" part was ignored.
		Thus a pop function should be included to get "sp" back to its original position.

	3) statement "fp = *(fp+0)" is put at the beginning of the function call part, which leading to the problem that the function is not reading proper
		location of "pushed" data. Instead, the statement should be put before the part of restoring all local variable.

	3) The way how "fp" is stored and retrieved would cause segmentation fault, the reason is that "sp" is defined as an "char" pointer while 
		the address of "fp" needs 4 byte size. Thus a temperory stack for store and retrieve "fp" postion could solve the problem.

	What we have done to solve the problem: 
	1) We created a "fp" stack to store and retrieve "fp" pointer position, which included two functions at the top of the program to do the push and pop operation.
	2) "sp" is restored after "fp" restoration: "fp = *tmp;fp_pop();sp = fp + 4;"


3. Potential optimization: 
	1) more efficient registrator usage by tracking IDs that are not variables.
	2) eliminate extra variable value passing part.
	3) eliminate duplicate variables that carry same information


Time just won't allow us to finish all the work here. We think the example contains too much confusion and it took a lot time to figure all of them out. Still we tried our best to figure out the whole process


