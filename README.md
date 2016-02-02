*****************************************************

WL-Compilers-Program-1 Read Me

*****************************************************
Description:

	This is a simple implementation of a symbol table with hash tables
	Scopes are connected as a stack of hashtables
	Symbols are stored in the hashtable and collinsions are dealt with linked list 

Files:
class_header.h 					: class declaration
class_implementation.cpp 		: class functions
main.cpp 						: test functions

Running instruction:

Environment						: Linux
Command  						: 1) g++ *.cpp
								  2) ./a.out

Notice: warnings would be thrown out due to string conversion not enabled by defualt. As testing purpose, it doesn't influence the result.