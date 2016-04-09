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
void enter_scope();
void leave_scope();

%}

%%
main 								{ return (MAIN);	}

begin								{ return (BEGIN_E); enter_scope();	}

end									{ return (END_E);	leave_scope();	}					

int									{ fflush(stdout); return (INT);	}
char								{ fflush(stdout); return (CHAR);	}
void 								{ fflush(stdout); return (VOID);	}
long								{ fflush(stdout); return (LONG);	}
enum								{ fflush(stdout); return (ENUM);	}
if									{ fflush(stdout); return (IF);	}
else								{ fflush(stdout); return (ELSE);	}
do									{ fflush(stdout); return (DO);	}
continue							{ fflush(stdout); return (CONTINUE);	}

and									{ fflush(stdout); return (AND);	}
or 									{ fflush(stdout); return (OR);	}
lt									{ fflush(stdout); return (LT);	}
gt									{ fflush(stdout); return (GT);	}
eq									{ fflush(stdout); return (EQ);	}
neq									{ fflush(stdout); return (NEQ);	}
ge									{ fflush(stdout); return (GE);	}
le 									{ fflush(stdout); return (LE);	}

[ \t\n]+							{ /* delete */		}

{Letter}({Letter}|{Digit}|_)*		{ process_id();
									  return (ID);		}

{IntLit}							{ yylval.intstuff = atoi(yytext);
				          			  return (INTLITERAL);	}

"="									{ return ('=');		}
";"									{ return (';');		}
"*"									{ return ('*');		}
"**"								{ return (EXPO);	}
"/"									{ return ('/');		}
"-"									{ return ('-');		}
"+"									{ return ('+');		}
"("									{ return ('(');		}
")"									{ return (')');		}
"["									{ return ('[');		}
"]"									{ return (']');		}
","									{ return (',');		}
":"									{ return (':');		}
"."									{ return ('.');		}
"<<"								{ return (LEFT_SHIFT);		}
">>"								{ return (RIGHT_SHIFT);		}
'^'									{ return ('^');		}
'|'									{ return ('|');		}
'&'									{ return ('&');		}
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
	t = new_table -> Search_symbol(yytext);
	if(!t)
	{
	   /*  a symbol table entry has a character string "key" taken
               from yytext, and a register "number", in the range 4-31.  */
		// cout<<"YYTEXT:"<<yytext<<endl;
		t = new_table -> Insert_symbol(yytext,assign_next_register());

	}
	else
	{
	    /* the identifier (whose name is stored in yytext) is already
               in the symbol table.  */
		// cout<<"yytext already existed"<<endl;
	}
	yylval.symbolstuff = t;
        /*printf("in process get id %s\n",yylval.symbolstuff->name);*/

}

void enter_scope()
{
	new_table->Enter_new_scope();
}

void back_scope()
{
	new_table->Leave_current_scope();
}

int assign_next_register()
{
	/* The compiler allocates each variable to a different machine
           register.  This routine just chooses the next register in
           the range r4 to r31.  Registers r0-r3 are reserved for other
           purposes  */

	static int register_number;
	register_number = (register_number + 1) % 28;
	return register_number;
}
