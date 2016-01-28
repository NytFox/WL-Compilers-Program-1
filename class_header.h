#ifndef SYMBOL_TABLE_HEADER
#define SYMBOL_TABLE_HEADER


#define HT_SIZE 1024					// Hashtable size
class Symbol {							// Symbol node in the hash table
public:
	Symbol(char* s);					// Constructor
	~Symbol();							// Destructor
	Symbol* Next_bucket();

private:
	char* name;							// pointer of the variable
	Symbol* next_bucket;				// next collinsion variable
	/*
	 	Attributes
		Add new attributes to the end
	*/
	char* type;							// variable type
	char* value;						// variable value
};

class Scope {							// one hashtable for one scope
public:
	Scope();
	Symbol* Empty_table();				// empty current table	
	Symbol* Insert_symbol(char* s, char* type, char* value);		// insert a new symbol
	Symbol* Search_symbol(char* s);		// search symbol
	//Symbol* Head_symbol() { return head; }	//return the head symbol
	//Symbol* Tail_symbol() { reutrn tail; }	//return the tail symbol
	unsigned int Count_table_symbols();// return number of symbols in the table
private:
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
	Scope* Insert_symbol(char* s);
	Scope* Search_symbol(char* s);

private:
	Symbol_Table* table;				// pointer of the symboltable
	Scope* current;						// current scope
	unsigned int level;					// number of scopes in the list
};


#endif