%{
extern "C"
{
	int yylex(void);
	int yyparse(void);
}
#include "symtab_class_header.h"
#include <typeinfo>
//original
const char *start_expression_string(Symbol symbol);
void generate_exp(Symbol *symbol,const char *rhs);
int yyerror(const char *s);
void generate_copy(Symbol* symbol,int value);

//new codes

%}

%union 
{
        int intstuff;
        const char *stringstuff;
        Symbol* symbolstuff;  
}

%token BEGIN_E
%token END_E
%token ASG 
%token EXPO
%token <intstuff> INTLITERAL
%token <symbolstuff> ID

%type <stringstuff> expression 
%type <stringstuff> statement /* statement_list */
%start statement_list 

%%
statement_list  :  statement_list statement
                | statement
                ;

statement  : BEGIN_E ';'
		{
			printf("\nSeen: BEGIN\n\n");
		}
		;

statement  : END_E ';'
		{
			printf("\nSeen: END;\n\n"); 
		}
		;
		
statement  : ID '(' ID ')' ';'
		{
			printf("\nSeen: FUNCTION\n\n"); 
		}
		;

statement  : ID ASG expression ';' 
		{ 
			printf("\nSeen: EXP PASSING\n\n");
			Symbol *tmp1;
			tmp1 = $1;
			Symbol *tmp2;
			tmp2 = new_table -> Search_symbol("x");
			cout<<$1->name<<endl;
		}
  		;

expression : expression add_op term
		{
		    printf("\nSeen: ADD_OP\n\n"); 
		}
	    | term
		{ 
		    printf("Seen: Term \n"); 
		}
   		;

term : term mul_op factor 
		{
		    printf("\nSeen: MUL_OP \n\n"); 
		}
	   	| factor
		{ 
		    printf("Seen: FACTOR \n"); 
		}
   		;

factor 	: factor EXPO parentheses
		{
			printf("Seen: EXPO_OP\n"); 
		}
		| parentheses
		{
			printf("\nSeen: PARENTHESES\n\n"); 
		}
		| ID
		{
			printf("\nSeen: ID\n\n"); 
			cout<<$1->name<<endl;
		}
		| INTLITERAL
		{
			printf("\nSeen: INTLITERAL\n\n"); 
			cout<<$1<<endl;
		}
		;

parentheses : '(' expression ')' 
		{

		}
		;


add_op 	: '+'
		| '-'
   		;

mul_op	: '*'
		| '/'
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
	
int yyerror(const char *s)
{
        fflush(stdout);
        printf("Syntax Error %s\n",s);
        return 0;
}

