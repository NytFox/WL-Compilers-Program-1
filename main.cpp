#include <iostream>
#include "class_header.h"
using namespace std;

int main(){
	Symbol_Table* new_table;
	new_table = new Symbol_Table;
	new_table -> Insert_symbol("a","int","5");
	Scope* t;
	if(t = new_table -> Search_symbol("a")){
		cout<<"name searched"<<endl;
		char* tmp=t -> Search_symbol("a") -> type;
		cout<<tmp<<endl;
	}
	else{
		cout<<"no found"<<endl;
	}
	cout<<"level:"<<new_table->level<<endl;

	new_table -> Enter_new_scope();

	new_table -> Insert_symbol("a","char","10");
	if(t = new_table -> Search_symbol("a")){
		cout<<"name searched"<<endl;
		char* tmp=t -> Search_symbol("a") -> type;
		cout<<tmp<<endl;
	}
	else{
		cout<<"no found"<<endl;
	}

	new_table -> Leave_current_scope();
	new_table -> Insert_symbol("a","bool","100");
	if(t = new_table -> Search_symbol("a")){
		cout<<"name searched"<<endl;
		char* tmp=t -> Search_symbol("a") -> type;
		cout<<tmp<<endl;
	}
	else{
		cout<<"no found"<<endl;
	}

	cout<<"test4"<<endl;




	return 0;
}