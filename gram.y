%{
extern "C"
{
	int yylex(void);
	int yyparse(void);
}
#include "defs.h"
#include "symtab_class_header.h"
#include <iostream>
using namespace std;
char *start_expression_string(Symbol symbol);
void generate_exp(Symbol *symbol,char* rhs);
int yyerror(char* s);
void generate_copy(Symbol* symbol,int value);
%}

%union 
{
        int intstuff;
        char* stringstuff;
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

		}
		;

statement  : END_E ';'
		{

		}
		;

statement  :  ID ASG expression ';' 
		{ 
			$$ = $1->name; 
			generate_exp($1,$3);
		}
   		;

expression : expression add_op term 
		{
		    printf("\nWe've seen a add_op\n\n"); 
		}
	   | term
		{ 
		    printf("We've seen an TERM \n"); 
		}
   		;

term : term mul_op factor 
		{
		    printf("\nWe've seen a mul_op \n\n"); 
		}
	   | factor
		{ 
		    printf("We've seen an FACTOR \n"); 
		}
   		;

factor 	: factor EXPO atom
		{
			printf("We've seen an EXPO operator\n"); 
		}
		| atom
		;

atom	: ID
		| INTLITERAL
		| '('
		| ')'
		;


add_op 	: '+'
		| '-'
   		;

mul_op	: '*'
		| '/'
		;
%%

void generate_copy(Symbol* symbol,int value)
{
	/*  write a statment of the form 
		
		oril	#,r0,rd   
	    
	    where # is an integer constant constant  and
	    rd is the destination register.  r0 is always 
	      0 in this architecture.
	*/

	printf("oril %d,r0,r%d\n",value,symbol->offset);
}


void generate_exp(Symbol *symbol,char *rhs)
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
	
int yyerror(char *s)
{
        fflush(stdout);
        printf("Syntax Error %s\n",s);
        return 0;
}

