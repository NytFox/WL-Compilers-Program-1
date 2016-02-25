#include "symtab_class_header.h"
extern "C"
{
	int yylex(void);
	int yyparse(void);
}
/*  global variable(s), used in the compiler  */
int const_value;
Symbol_Table *new_table;

int main()
{
	
	/*  first we set up any initialization necessary for the compiler  */
	new_table = new Symbol_Table();

	/*  We MIGHT have some code here to spit out any "formatting" that
            the output (assembler ?) requires  before the "real" code
            things like .csect commands, .text,  etc. */

	/*  yyparse is the name of the parser.  It parses the program, and
            allows us to spit out code during the parse.  */
    ofstream output_file;
    output_file.open("CM_code.cm");
    cout << "int r0, r1, r2, r3, r4, r5, r6, r7;\nint *iptr1;\nchar *cptr1;\nchar *fp, *sp;\n\nmain()\n{\n"<<endl;
    output_file << "int r0, r1, r2, r3, r4, r5, r6, r7;\nint *iptr1;\nchar *cptr1;\nchar *fp, *sp;\n\nmain()\n{\n"<<endl;
    yyparse();
    cout << "}\n"<<endl;
    output_file << "}\n"<<endl;
    new_table -> Search_symbol("x");





    output_file.close();
    return 0;
	/*  Having compiled the program an spit out the code, we might need
	    to add some postscript to the assembler output --- space statements,
	    etc.  */
}
