%{
extern "C"
{
	int yylex(void);
	int yyparse(void);
}
#include "symtab_class_header.h"
#include <ctype.h>
//original
char *start_expression_string(Symbol *symbol);
void generate_exp(Symbol *symbol,const char *rhs);
int yyerror(const char *s);
void generate_copy(Symbol* symbol,int value);
char *new_registrator();
void function_call(Symbol *func, Symbol *para);
char *Calc_exponential(const char *r1,const char *r2);
int assign_next_lable();
char *get_number(int num);
bool is_number(const char *string);
void cal_operation(char oprator,const char *left, const char *right,const char *target);
extern int assign_next_register();
%}

%union 
{
        int intstuff;
        const char *stringstuff;
        Symbol* symbolstuff;  
}


%token MAIN
%token BEGIN_E
%token END_E
%token ASG 
%token EXPO
%token INT
%token CHAR
%token LONG
%token ENUM
%token VOID
%token DO
%token IF
%token ELSE
%token <stringstuff> AND
%token <stringstuff> OR
%token <stringstuff> LT
%token <stringstuff> GT
%token <stringstuff> EQ
%token <stringstuff> NEQ
%token <stringstuff> LE
%token <stringstuff> GE
%token <intstuff> INTLITERAL
%token <symbolstuff> ID

%type <stringstuff> factor 
%type <stringstuff> term
%type <stringstuff> expression 
%type <stringstuff> statement
%type <stringstuff> parentheses
%type <stringstuff> declaration
%type <stringstuff> declaration_item
%type <stringstuff> arraycontent
%type <stringstuff> if_content

%type <stringstuff> comparison
%start statement_list 

%%
statement_list  :  statement_list statement
                | statement
                ;

statement  : MAIN  '(' ')' ':' VOID BEGIN_E
			{
				cout << "int r0, r1, r2, r3, r4, r5, r6, r7, r8,r9,r10,r11,r12;\nint *iptr1;\nchar *cptr1;\nchar *fp, *sp;\nmain()\n{\ninitstack();\n"<<endl;
			}
			;
statement  : BEGIN_E
		{
			//printf("\nSeen BEGIN\n\n");
			cout << "{\n"<<endl;
		}
		;

statement  : END_E 
		{
			//printf("\nSeen END;\n\n"); 
			cout << "}\n"<<endl;
		}
		;


statement : 	IF '(' if_content ')' statement ELSE statement
			{

			}
			| IF '(' if_content ')' statement
			{

			}
			;

if_content : comparison AND if_content
			{

			}
			|comparison OR if_content
			{

			}
			| comparison
			{

			}
			;

comparison : expression '.' GT '.' expression
			{

			}
			|expression '.' LT '.' expression
			{

			}
			|expression '.' GE '.' expression
			{

			}
			|expression '.' LE '.' expression
			{

			}
			|expression '.' EQ '.' expression
			{

			}
			|expression '.' NEQ '.' expression
			{

			}
			|
			;



statement : declaration
			{

			}
			;
declaration : declaration_item ';' declaration
			{
				printf("\nSeen sequent declaration;\n\n");
			}
			| declaration_item
			{
				printf("\nSeen single declaration;\n\n");
			}
			;

declaration_item : type ID '[' arraycontent ']'
			{
				printf("\nSeen array declaration;\n\n");
			}
			| type ID
			{
				printf("\nSeen type declaration;\n\n");
			}
			;

arraycontent: INTLITERAL ',' arraycontent
			{
				printf("\nSeen multi-dimention array declaration;\n\n");
			}
			| INTLITERAL
			{
				printf("\nSeen 1D array declaration;\n\n");
			}
			;


type		: INT
			| CHAR
			| LONG
			;

statement  : ID '(' ID ')' ';'
		{
			//printf("\nSeen FUNCTION\n\n"); 
			function_call($1,$3);
		}
		;

statement  : ID ASG expression ';' 
		{ 
			//printf("\nSeen EXP PASSING\n\n");
		    cout<< "r"<<$1->offset <<" = "<< $3 << ";"<<endl;

		}
  		;

expression : expression '+' term
		{
		    //printf("\nSeen ADD_OP\n\n"); 
		    char *rd = new_registrator();
		    cal_operation('+',$1,$3,rd);
		    $$ = rd;

		}
		| expression '-' term
		{
		    // printf("\nSeen ADD_OP\n\n"); 
		   	char *rd = new_registrator();
		    //cout<< rd <<" = " << $1 << " - "<< $3<<";"<<endl;
		    cal_operation('-',$1,$3,rd);
		    $$ = rd;
		    
		}
	    | term
		{ 
		    // printf("Seen Term \n"); 
		    $$ = $1;
		}
   		;

term : 	term '*' factor 
		{
		    // printf("\nSeen MUL_OP \n\n"); 
		    char *rd = new_registrator();
		    cal_operation('*',$1,$3,rd);
		    $$ = rd;
		}
		| term '/' factor 
		{
		    // printf("\nSeen MUL_OP \n\n"); 
		    char *rd = new_registrator();
		    cal_operation('/',$1,$3,rd);
		    $$ = rd;
		}
	   	| factor
		{ 
		    // printf("Seen: FACTOR \n"); 
		    $$ = $1;
		}
   		;

factor 	: factor EXPO parentheses
		{
			// printf("Seen: EXPO_OP\n");
			char *rd = new_registrator(); 	
		    cout<< rd <<" = "<<Calc_exponential($1,$3)<<";"<<endl;
			$$ = rd;
		}
		| parentheses
		{
			// printf("\nSeen: PARENTHESES\n\n"); 
			$$ = $1;
		}
		;

parentheses : '(' expression ')' 
		{ 
			$$ = $2;	
		}
		| ID
		{
			// cout<<"Seen ID->"<<$1->name<<endl;
			$$ = start_expression_string($1);
		}
		| INTLITERAL
		{
			// cout<<"Seen INTLITERAL->"<<$1<<endl;
			$$ = get_number($1);
		}
		;

%%

void Generate_value_passing(Symbol* symbol,int value)
{
	/*  write a statment of the form 
		
		oril	#,r0,rd   
	    
	    where # is an integer constant constant  and
	    rd is the destination register.  r0 is always 
	      0 in this architecture.
	*/

	printf("oril %d,r0,r%d\n",value,symbol->offset);
}


void generate_exp(Symbol *symbol,const char *rhs)
{
	/*  write a statment of the form 
		
		ai	rs,#,rd   
	    
	    where # is an integer constant constant,  
	    rs is the source register and
	    rd is the destination register.
	*/

	printf("ai   %s,%d,r%d\n",rhs,const_value,symbol->offset);
}


char *start_expression_string(Symbol *symbol)
{
	char buffer[10];
	char *result;
	result = (char *)malloc(4);  /*  tacky, but should be big enuff  */

	strcpy(result,"r");
	sprintf(buffer,"%d",symbol->offset);
	strcat(result,buffer);

	return result;
}

char *new_registrator()
{
	char buffer[10];
	char *result;
	result = (char *)malloc(4);  /*  tacky, but should be big enuff  */

	strcpy(result,"r");
	sprintf(buffer,"%d",assign_next_register());
	strcat(result,buffer);
	return result;
}

int yyerror(const char *s)
{
        fflush(stdout);
        printf("Syntax Error %s\n",s);
        return 0;
}

void function_call(Symbol *func, Symbol *para)
{
	if(strcmp(func->name,"output")==0)
	{
		cout<<"printInt(r"<<para->offset<<");"<<endl;
	}
}

char *Calc_exponential(const char *r1, const char *r2)
{
			int l = assign_next_lable();
			char *rt_i = new_registrator();
			cout<<rt_i<<"= 0;"<<endl;
			char *rx = new_registrator();
			cout<<rx<<"= 1;"<<endl;
			cout<<"L"<<l<<":"<<endl;
			cout<<rx<<" = "<<rx<<"*"<<r1<<";"<<endl;
			cout<<rt_i<<" = "<<rt_i<<" + 1;"<<endl;
			cout<<"if("<<r2<<">"<<rt_i<<") goto L"<<l<<";"<<endl;
			return rx;
}

int assign_next_lable()
{
	/* The compiler allocates each variable to a different machine
           register.  This routine just chooses the next register in
           the range r4 to r31.  Registers r0-r3 are reserved for other
           purposes  */

	static int lable;
	lable = lable + 1;
	return lable;
}


char *get_number(int num)
{
	char *buffer;
	buffer = new char[4];
	sprintf(buffer,"%d\0",num);
	return buffer;
}

bool is_number(const char *string)
{
	bool result = 0;
	for(int i=0;i<strlen(string);i++)
	{
		result = isdigit(string[i]);
		if(!result)
			return 0;
	}
	return 1;
}

void cal_operation(char oprator,const char *left, const char *right, const char *target)
{
	int temp;
	int a,b;
	if(is_number(left)&&is_number(right))
	{
		//cout<< "T1"<<endl;
		a = atoi(left);
		b = atoi(right);

		char *rd_1 = new_registrator();
		char *rd_2 = new_registrator();
		cout<< rd_1 <<" = " << a <<endl;
		cout<< rd_2 <<" = " << b <<endl;
		cout<< target << " = ";
		switch(oprator)
		{
			case '+':{
				cout<<rd_1<<"+"<<rd_2;
				break;
			}
			case '-':{
				cout<<rd_1<<"-"<<rd_2;
				break;
			}
			case '*':{
				cout<<rd_1<<"*"<<rd_2;
				break;
			}
			case '/':{
				cout<<rd_1<<"/"<<rd_2;
				break;
			}
			default: break;
		}
	}
	else
	{
		cout<< target << " = ";
		//cout<< "T2"<<endl;
		switch(oprator)
		{
			case '+':{
				cout<<left<<"+"<<right;
				break;
			}
			case '-':{
				cout<<left<<"-"<<right;
				break;
			}
			case '*':{
				cout<<left<<"*"<<right;
				break;
			}
			case '/':{
				cout<<left<<"/"<<right;
				break;
			}
			default: break;
		}
	}
	cout<<";"<<endl;
}








