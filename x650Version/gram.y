%{
#include "defs.h"
void yyerror(char *s);
%}

%union { /* Define stack type */
        int intstuff;
}

%token		ID
%token		IF
%token		INT
%token		FLOAT
%token		DOUBLE
%token		CHAR
%token		STRING_LITERAL
%token		INTLITERAL
%token		C_REGISTER
%token		I_REGISTER
%token		F_REGISTER
%token		D_REGISTER
%token		IPTR
%token		CPTR
%token		PUSHC
%token		PUSHI
%token		PUSHF
%token		PUSHD
%token		FRAMEPTR
%token		STACKPTR
%token		LBRACKET
%token		RBRACKET
%token		LPAREN
%token		RPAREN
%token		RCURLY
%token		LCURLY
%token		GOTO
%token		RETURN
%token		LABEL

/* %program function statement statement_list op relop intDeclaration globals*/

%start program
%%
program		: globals function_list 
		;

globals		: INT intDeclaration ';' 
                  pointerDecls ';'
                  CHAR '*' FRAMEPTR ',' '*' STACKPTR ';'
       		| INT intDeclaration ';' 
                  pointerDecls ';'
                  CHAR '*' FRAMEPTR ',' '*' STACKPTR ';'
                  staticData 
		;

staticData	: staticDecl 
                | staticDecl staticData
		;

staticDecl	:  CHAR ID LBRACKET INTLITERAL RBRACKET ';'
		;

pointerDecls	: INT iptrDecls ';' CHAR cptrDecls
		;

iptrDecls	: '*' IPTR
		| '*' IPTR ',' iptrDecls
		;

cptrDecls	: '*' CPTR
		| '*' CPTR ',' cptrDecls
		;

intDeclaration	: I_REGISTER
		| I_REGISTER ',' intDeclaration
		;

register	: I_REGISTER
                ;

parameterList	: register
                | IPTR
		| register ',' parameterList
		| IPTR ',' parameterList
		;

function_list	: function
		| function_list function
		;

function 	: ID LPAREN RPAREN LCURLY statement_list RCURLY 
         	| ID LPAREN parameterList RPAREN LCURLY statement_list RCURLY 
		;
			
statement_list	: statement
 		| statement_list statement
		;

statement	: register '=' register op register ';' 
         	| register '=' register op INTLITERAL ';' 
         	| register '=' INTLITERAL op register ';' 
		| register '=' register ';' 
		| register '=' deref ';' 
		| register '=' INTLITERAL ';' 
		| deref '=' register ';'
		| PUSHI LPAREN I_REGISTER RPAREN ';'
		| PUSHC LPAREN I_REGISTER RPAREN ';'
		| ID LPAREN RPAREN ';'
		| ID LPAREN parameterList RPAREN ';'
		| IPTR '=' ID LPAREN register RPAREN ';'
		| IPTR '=' '&' register ';'
		| CPTR '=' ID LPAREN register RPAREN ';'
		| ID LPAREN STRING_LITERAL RPAREN ';'
		| LABEL
		| GOTO ID ';'
		| RETURN ';'
		| IF LPAREN register relop register RPAREN GOTO ID ';'
		;

deref		: '*' LPAREN FRAMEPTR '+' INTLITERAL RPAREN
		| '*' IPTR
		| '*' CPTR
     		| '*' LPAREN ID '+' INTLITERAL RPAREN
		;

op		: '*' 
		| '+'
		| '-'
		| '/'
		| '%'
		| '<' '<'
		| '>' '>'
		| '&'
		| '|'
		| '^'
		| '~'
		;

relop		: '>' 
		| '<'
		| '=' '='
		| '!' '='
		| '>' '='
		| '<' '='
		;
%%


void yyerror(char *s)
{
	fflush(stdout);
	printf("\nSyntax Error %s\n",s);
}
