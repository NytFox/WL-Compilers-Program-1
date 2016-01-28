#ifndef SYMBOL_TABLE_HEADER
#define SYMBOL_TABLE_HEADER


#define HT_SIZE 5120					//Hashtable size
class Symbol {							// Symbol node in the hash table
public:
	Symbol(char* s);					// Constructor
	~Symbol();							// Destructor
	Symbol* Next_bucket();
	Symbol* Next_symbol();

private:
	char* name;							// pointer of the variable
	Symbol* next_bucket;				// next same name variable (different scopes)
	Symbol* next_symbol;				// next variable
	/*
	 	Attributes
		Add new attributes to the end
	*/
	char* type;							// variable type
	char* value;						// variable value
};

class Symbol_Table {
public:
	Symbol_Table();						// constructor
	Symbol* Empty_table();				// empty current table	
	Symbol* Insert_symbol(char* s);		// insert a new symbol
	Symbol* Search_symbol(char* s);		// search symbol
	Symbol* Head_symbol() { return head; }	//return the head symbol
	Symbol* Tail_symbol() { reutrn tail; }	//return the tail symbol
	unsigned int Count_table_symbols();

private:
	Symbol* hashtable[HT_SIZE];			// define hashtable size
	Symbol* head;						// head symbol of the hashtable(first inserted)
	Symbol* tail;						// tail symbol of the hashtable(last inserted)
	unsigned int count;					// number of symbols in the hashtable
};


#endif