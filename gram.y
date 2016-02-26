%{
extern "C"
{
	int yylex(void);
	int yyparse(void);
}
#include "symtab_class_header.h"
//original
const char *start_expression_string(Symbol symbol);
void generate_exp(Symbol *symbol,const char *rhs);
int yyerror(const char *s);
void generate_copy(Symbol* symbol,int value);
char *new_registrator();
extern int assign_next_register();
extern char *  itoa ( int value, char * str, int base );
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

%type <stringstuff> factor 
%type <stringstuff> term
%type <stringstuff> expression 
%type <stringstuff> statement

%start statement_list 

%%
statement_list  :  statement_list statement
                | statement
                ;

statement  : BEGIN_E ';'
		{
			printf("\nSeen BEGIN\n\n");
			output_file << "int r0, r1, r2, r3, r4, r5, r6, r7;\nint *iptr1;\nchar *cptr1;\nchar *fp, *sp;\n\nmain{\n"<<endl;
		}
		;

statement  : END_E ';'
		{
			printf("\nSeen END;\n\n"); 
			output_file << "}\n"<<endl;
		}
		;
		
statement  : ID '(' ID ')' ';'
		{
			printf("\nSeen FUNCTION\n\n"); 
		}
		;

statement  : ID ASG expression ';' 
		{ 
			printf("\nSeen EXP PASSING\n\n");
			//char *rd = start_expression_string($1);
		    cout<< rd <<" = " << $3<<endl;

		}
  		;

expression : expression '+' term
		{
		    printf("\nSeen ADD_OP\n\n"); 
		    char *rd = new_registrator();
		    cout<< rd <<" = " << $1 << " + "<< $3<<endl;
		    $$ = rd;

		}
		| expression '-' term
		{
		    printf("\nSeen ADD_OP\n\n"); 
		   char *rd = new_registrator();
		    cout<< rd <<" = " << $1 << " - "<< $3<<endl;
		    $$ = rd;
		    
		}
	    | term
		{ 
		    printf("Seen Term \n"); 
		}
   		;

term : 	term '*' factor 
		{
		    printf("\nSeen MUL_OP \n\n"); 
		    char *rd = new_registrator();
		    cout<< rd <<" = " << $1 << " * "<< $3<<endl;
		    $$ = rd;
		}
		| term '/' factor 
		{
		    printf("\nSeen MUL_OP \n\n"); 
		    char *rd = new_registrator();
		    cout<< rd <<" = " << $1 << " / "<< $3<<endl;
		    $$ = rd;
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
			cout<<"Seen ID->"<<$1->name<<endl;
			//$$ = start_expression_string($1->offset);
		}
		| INTLITERAL
		{
			cout<<"Seen INTLITERAL->"<<$1<<endl;
			char buffer[4];
			itoa($1,buffer,10);
			$$ = buffer;
		}
		;

parentheses : '(' expression ')' 
		{

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


char *start_expression_string(int offset)
{
	char buffer[10];
	char *result;
	result = (char *)malloc(4);  /*  tacky, but should be big enuff  */

	strcpy(result,"r");
	sprintf(buffer,"%d",offset);
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
