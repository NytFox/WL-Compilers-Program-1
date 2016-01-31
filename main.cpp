#include <iostream>
#include "class_header.h"
using namespace std;

int main(){
	Symbol_Table* new_table;
	new_table = new Symbol_Table;
	char* name = "a";
	char* type = "int";
	char* value = "5";
	new_table -> Insert_symbol(name,type,value);
	cout<<"test1"<<endl;
	if(new_table -> Search_symbol(name)){
		cout<<"name searched"<<endl;
	}
	else{
		cout<<"no found"<<endl;
	}
	new_table -> Enter_new_scope();
	cout<<"test3"<<endl;
	new_table -> Leave_current_scope();
	cout<<"test4"<<endl;




	return 0;
}