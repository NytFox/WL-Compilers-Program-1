Digit		[0-9]
Letter		[a-zA-Z]
IntLit		{Digit}+

%{
#include "defs.h"
#include "y.tab.h"
%}

%%
[ \t\n]+				{ /* delete */		}

pushc					{  return (PUSHC);	}

pushi					{  return (PUSHI);	}

pushf					{  return (PUSHF);	}

pushd					{  return (PUSHD);	}

if					{  return (IF);		}

char					{  return (CHAR);	}

int					{ /* printf("Lex sees int\n");
					  fflush(stdout);  */
						return (INT);	}

float					{ /* printf("Lex sees float\n");
					  fflush(stdout);  */
						return (FLOAT);}

void					{ /* printf("Lex sees void\n");
					  fflush(stdout);  */
						return (VOID);}

goto 					{ /* printf("Lex sees goto\n");
					  fflush(stdout);  */
						return (GOTO);	}

return 					{ /* printf("Lex sees return\n");
					  fflush(stdout);  */
						return (RETURN);}

"r"{IntLit}				{ /* printf("Lex sees %s\n", yytext);
					  fflush(stdout);  */
					    return (I_REGISTER);  }

"d"{IntLit}				{ /* printf("Lex sees %s\n", yytext);
					  fflush(stdout);  */
					    return (D_REGISTER);  }

"f"{IntLit}				{ /* printf("Lex sees %s\n", yytext);
					  fflush(stdout);  */
					    return (F_REGISTER);  }

"iptr"{IntLit}				{ /* printf("Lex sees %s\n", yytext);
					  fflush(stdout);  */
					    return (IPTR);  }

"cptr"{IntLit}				{ /* printf("Lex sees %s\n", yytext);
					  fflush(stdout);  */
					    return (CPTR);  }

{Letter}+{IntLit}":"				{ /* printf("Lex sees %s\n", yytext);
					  fflush(stdout);  */
					  return (LABEL);    }

fp 					{ /* printf("Lex sees frameptr\n");
					  fflush(stdout);  */
					  return (FRAMEPTR); 	}

sp 					{ /* printf("Lex sees stackptr\n");
					  fflush(stdout);  */
					  return (STACKPTR); 	}

{Letter}({Letter}|{Digit}|_)*		{ return (ID);		}

{IntLit}				{ return (INTLITERAL);	}

L?\"(\\.|[^\\"])*\"     		{ return(STRING_LITERAL); }

"("             			{ return (LPAREN); 	}
")"             			{ return (RPAREN); 	}
"}"             			{ return (RCURLY); 	}
"{"             			{ return (LCURLY); 	}
"["             			{ return (LBRACKET); 	}
"]"             			{ return (RBRACKET); 	}
"&"             			{ return ('&'); 	}
"|"             			{ return ('|'); 	}
"^"             			{ return ('^'); 	}
"~"             			{ return ('^'); 	}
"="             			{ return ('='); 	}
";"             			{ return (';'); 	}
","             			{ return (','); 	}
"+"             			{ return ('+'); 	}
"-"             			{ return ('-'); 	}
"*"             			{ return ('*'); 	}
"/"             			{ return ('/'); 	}
"!"             			{ return ('!'); 	}
">"             			{ return ('>'); 	}
"<"             			{ return ('<'); 	}
%%
