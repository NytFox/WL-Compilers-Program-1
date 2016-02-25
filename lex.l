Digit		[0-9]
Letter		[a-zA-Z]
IntLit		{Digit}+

%{
extern "C"
{
	int yylex(void);
	int yyparse(void);
}

#include "symtab_class_header.h"
#include "y.tab.h"
#include <iostream>
using namespace std;
void process_id();
int assign_next_register();

%}

%%

begin								{ return (BEGIN_E);	}

end									{ return (END_E);	}					

[ \t\n]+							{ /* delete */		}

{Letter}({Letter}|{Digit}|_)*		{ process_id();
									  return (ID);		}

{IntLit}							{ yylval.intstuff = atoi(yytext);
				          			  return (INTLITERAL);	}

"="									{ return (ASG);		}
";"									{ return (';');		}
"*"									{ return ('*');		}
"**"								{ return (EXPO);	}
"/"									{ return ('/');		}
"-"									{ return ('-');		}
"+"									{ return ('+');		}
"("									{ return ('(');		}
")"									{ return (')');		}
%%

void process_id()
{
	/*  The following uses a chained hash table implementation of
            a symbol table.  Each "bucket" of the hash table consists
            of a list.  Each element of THOSE lists (Nodes) contain
	    a field "stuff" which has the acutal symbol table goodies,
	    like a character string "key" and an integer "register number."
	*/

	Symbol *t;
	if(!(t = new_table -> Search_symbol(yytext)))
	{
	   /*  a symbol table entry has a character string "key" taken
               from yytext, and a register "number", in the range 4-31.  */
		cout<<"YYTEXT:"<<yytext<<endl;
		t = new_table -> Insert_symbol(yytext,assign_next_register());

	}
	else
	{
	    /* the identifier (whose name is stored in yytext) is already
               in the symbol table.  */
		cout<<"yytext already existed"<<endl;
	}
	yylval.symbolstuff = t;
        /*printf("in process get id %s\n",yylval.symbolstuff->name);*/

}

int assign_next_register()
{
	/* The compiler allocates each variable to a different machine
           register.  This routine just chooses the next register in
           the range r4 to r31.  Registers r0-r3 are reserved for other
           purposes  */

	static int register_number;
	register_number = (register_number + 1) % 28;
	return register_number + 4;
}
