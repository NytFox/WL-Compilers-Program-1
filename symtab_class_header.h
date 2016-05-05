#ifndef SYMBOL_TABLE_HEADER
#define SYMBOL_TABLE_HEADER

#define HT_SIZE 1024
#include <iostream>
using namespace std;
#include <string>
#include <cstring>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int const_value;						// Hashtable size
class Symbol {							// Symbol node in the hash table
public:
	Symbol(const char* s);					// Constructor
	Symbol* Give_attributes(const char* t, const char* v, int offset);
	Symbol* Give_attributes(int offset);
	~Symbol();							// Destructor
	Symbol* Next_bucket();
	Symbol* New_next_bucket(Symbol* next);
	const char* Return_name();

public:
	char* name;							// pointer of the variable
	Symbol* next_bucket;				// next collinsion variable
	int offset;
	/*
	 	Attributes
		Add new attributes to the end
	*/
	const char *type;						// variable type
	const char* value;						// variable value
	int type_size;
	//if is an array
	int if_array;
	int array_location;
};

class Scope {							// one hashtable for one scope
public:
	Scope();
	Symbol* Empty_table();				// empty current table
	Symbol* Insert_symbol(const char* s, const char* type, const char* value, int offset);
	Symbol* Insert_symbol(const char* s, int offset);		// insert a new symbol
	Symbol* Search_symbol(const char* s);		// search symbol
	//Symbol* Head_symbol() { return head; }	//return the head symbol
	//Symbol* Tail_symbol() { reutrn tail; }	//return the tail symbol
	unsigned int Count_table_symbols();// return number of symbols in the table
	unsigned int Hash_value(const char* s);
	Scope* New_upper_scope(Scope* up);
	Scope* Return_upper_scope();

public:
	Symbol* hashtable[HT_SIZE];			// define hashtable size
	//Symbol* head;						// head symbol of the hashtable(first inserted)
	//Symbol* tail;						// tail symbol of the hashtable(last inserted)
	unsigned int count;					// number of symbols in the hashtable
	Scope* upper;
};

class Symbol_Table {					// list of scopes (hashtables)
public:
	Symbol_Table();						// constructor
	Scope* Enter_new_scope();			// enter new scope ( add a new scope to the head of the list)
	Scope* Leave_current_scope();		// exit the scope (remove current scope from the list)
	Scope* Currrent_scope();			// return pointer of current scope
	Symbol* Insert_symbol(const char* s, const char* type, const char* value, int offset);
	Symbol* Insert_symbol(const char* s, int offset);
	Symbol* Search_symbol(const char* s);

public:
	Scope* head;						// pointer of the head
	Scope* current;						// current scope
	unsigned int level;					// number of scopes in the list
};

extern Symbol_Table* new_table;
extern ofstream output_file;
#endif