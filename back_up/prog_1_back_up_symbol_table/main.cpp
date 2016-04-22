#include <iostream>
#include "class_header.h"
using namespace std;

int main(){
	Symbol_Table* new_table;
	new_table = new Symbol_Table;
	cout <<"New scope created"<<endl;
	new_table -> Insert_symbol("a","int","5");
	cout << "Symbol: ' int a 5 ' is inserted to a current scope"<<endl;
	new_table -> Insert_symbol("b","string","abc");
	cout << "Symbol: ' string b abc ' is inserted to a current scope"<<endl;
	Scope* t;
	cout << "Searching symbol 'a' "<<endl;
	if(t = new_table -> Search_symbol("a")){
		cout<<"symbol detected:"<<endl;
		cout<<"Type:"<<t -> Search_symbol("a") -> type<<endl;
		cout<<"Value:"<<t -> Search_symbol("a") -> value<<endl;
	}
	else{
		cout<<"not found"<<endl;
	}

	new_table -> Enter_new_scope();
	cout <<"Enter next scope"<<endl;
	new_table -> Insert_symbol("a","char","10");
	cout <<"Symbol: ' char a 10 ' is inserted to a new scope"<<endl;
	cout << "Searching symbol 'a' "<<endl;
	if(t = new_table -> Search_symbol("a")){
		cout<<"symbol detected:"<<endl;
		cout<<"Type:"<<t -> Search_symbol("a") -> type<<endl;
		cout<<"Value:"<<t -> Search_symbol("a") -> value<<endl;
	}
	else{
		cout<<"not found"<<endl;
	}
	cout << "Searching symbol 'b' (upper scope)"<<endl;
	if(t = new_table -> Search_symbol("b")){
		cout<<"symbol detected:"<<endl;
		cout<<"Type:"<<t -> Search_symbol("b") -> type<<endl;
		cout<<"Value:"<<t -> Search_symbol("b") -> value<<endl;
	}
	else{
		cout<<"not found"<<endl;
	}
	cout << "Leave current scope"<<endl;
	new_table -> Leave_current_scope();

	new_table -> Insert_symbol("a","bool","100");
	cout <<"Symbol: ' bool a 100 ' is inserted to a new scope"<<endl;
	cout << "Searching symbol 'a' (collinsion test, suppose to get new inserted)"<<endl;
	if(t = new_table -> Search_symbol("a")){
		cout<<"symbol detected:"<<endl;
		cout<<"Type:"<<t -> Search_symbol("a") -> type<<endl;
		cout<<"Value:"<<t -> Search_symbol("a") -> value<<endl;
	}
	else{
		cout<<"not found"<<endl;
	}

	return 0;
}