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
	new_scope -> New_upper_scope(current);
	current = new_scope;
	level++;
	return current;
}

Scope* Symbol_Table::Leave_current_scope(){	
	Scope* tmp;
	tmp = current;
	current = current->Return_upper_scope();
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
		hashtable[i] = NULL;
		count = 0;
		upper = NULL;
	}
}

Symbol* Scope::Empty_table(){
	for( int i = 0; i < HT_SIZE ; i++){
		hashtable[i] = NULL;
		count = 0;
		upper = NULL;
	}
	return hashtable[0];

}

unsigned int Scope::Hash_value(char* s){
	unsigned hv = 0;
	while(*s != '\0'){
		hv = hv + *s;
		s++;
	}
	return hv;
}

Symbol* Scope::Insert_symbol(char* s, char* type, char* value){
	int hv = Hash_value(s);
	if(hashtable[hv] != NULL){
		Symbol* new_bucket;
		new_bucket = new Symbol(s);
		new_bucket -> Give_attributes(type, value);
		new_bucket -> Next_bucket(hashtable[hv]);
		hashtable[hv] = new_bucket;
		count++;
		return new_bucket;
	}
	hashtable[hv] = new Symbol(s);
	hashtable[hv] -> Give_attributes(type, value);
	count++;
	return hashtable[hv];

}

Scope* Scope::New_upper_scope(Scope* up){
	upper = up;
	return upper;
}
Scope* Scope::Return_upper_scope(){
	return upper;
}

unsigned int Scope::Count_table_symbols(){
	return count;
}

