/* A Bison parser, made by GNU Bison 2.5.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2011 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     ID = 258,
     IF = 259,
     INT = 260,
     FLOAT = 261,
     DOUBLE = 262,
     CHAR = 263,
     STRING_LITERAL = 264,
     INTLITERAL = 265,
     C_REGISTER = 266,
     I_REGISTER = 267,
     F_REGISTER = 268,
     D_REGISTER = 269,
     IPTR = 270,
     CPTR = 271,
     PUSHC = 272,
     PUSHI = 273,
     PUSHF = 274,
     PUSHD = 275,
     FRAMEPTR = 276,
     STACKPTR = 277,
     LBRACKET = 278,
     RBRACKET = 279,
     LPAREN = 280,
     RPAREN = 281,
     RCURLY = 282,
     LCURLY = 283,
     GOTO = 284,
     RETURN = 285,
     LABEL = 286
   };
#endif
/* Tokens.  */
#define ID 258
#define IF 259
#define INT 260
#define FLOAT 261
#define DOUBLE 262
#define CHAR 263
#define STRING_LITERAL 264
#define INTLITERAL 265
#define C_REGISTER 266
#define I_REGISTER 267
#define F_REGISTER 268
#define D_REGISTER 269
#define IPTR 270
#define CPTR 271
#define PUSHC 272
#define PUSHI 273
#define PUSHF 274
#define PUSHD 275
#define FRAMEPTR 276
#define STACKPTR 277
#define LBRACKET 278
#define RBRACKET 279
#define LPAREN 280
#define RPAREN 281
#define RCURLY 282
#define LCURLY 283
#define GOTO 284
#define RETURN 285
#define LABEL 286




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 2068 of yacc.c  */
#line 6 "gram.y"
 /* Define stack type */
        int intstuff;



/* Line 2068 of yacc.c  */
#line 118 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


