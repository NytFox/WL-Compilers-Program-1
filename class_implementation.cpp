#include <iostream>
#include "class_header.h"
using namespace std;

Symbol_Table::Symbol_Table(){						
	current = new Scope;
	head = current;
	level = 1;
}

Scope* Symbol_Table::Enter_new_scope(){			
	Scope* new_scope;
	new_scope = new Scope;
	new_scope->Upper_scope() = current;
	current = new_scope;
	level++;
	return current;
}

Scope* Symbol_Table::Leave_current_scope(){	
	Scope* tmp;
	tmp = current;
	current = current->Upper_scope();
	delete tmp;
	level--;
	return current;
}

Scope* Symbol_Table::Insert_symbol(char* s,char* type, char* value){
	current->Insert_symbol(s,type,value);
	return current;
}

Scope* Symbol_Table::Search_symbol(char* s){
	current->Search_symbol(s);
	return current;
}


Scope::Scope(){
	for( int i = 0; i < HT_SIZE ; i++){
		hashtable[i] = 0;
		count = 0;
		upper = NULL;
	}
}

Symbol* Scope::Empty_table(){
	for( int i = 0; i < HT_SIZE ; i++){
		hashtable[i] = 0;
		count = 0;
		upper = NULL;
	}
	return hashtable[0];

}

unsigned int Scope::Hash_value(char* s){

}

Symbol* Scope::Insert_symbol(char* s, char* type, char* value){
	int hv = Hash_value(s);
	hashtable[hv] = new Symbol(s);
	hashtable[hv] -> Give_attributes(type, value);
	
}

Symbol* Scope::Search_symbol(char* s)(){

}

unsigned int Scope::Count_table_symbols(){

}

