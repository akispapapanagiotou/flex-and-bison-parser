/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_SYNTAX_TAB_H_INCLUDED
# define YY_YY_SYNTAX_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    ENDOFFILE = 0,                 /* "End of File"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    LINEARLAYOUT_START = 258,      /* "Start of LinearLayout"  */
    RELATIVELAYOUT_START = 259,    /* "Start of RelativeLayout"  */
    TEXTVIEW_START = 260,          /* "Start of TextView"  */
    IMAGEVIEW_START = 261,         /* "Start of ImageView"  */
    BUTTON_START = 262,            /* "Start of Button"  */
    RADIOBUTTON_START = 263,       /* "Start of RadioButton"  */
    RADIOGROUP_START = 264,        /* "Start of RadioGroup"  */
    PROGRESSBAR_START = 265,       /* "Start of ProgressBar"  */
    LINEARLAYOUT_END = 266,        /* "End of LinearLayout"  */
    RELATIVELAYOUT_END = 267,      /* "End of RelativeLayout"  */
    TEXTVIEW_END = 268,            /* "End of TextView"  */
    IMAGEVIEW_END = 269,           /* "End of ImageView"  */
    BUTTON_END = 270,              /* "End of Button"  */
    RADIOBUTTON_END = 271,         /* "End of RadioButton"  */
    RADIOGROUP_END = 272,          /* "End of RadioGroup"  */
    PROGRESSBAR_END = 273,         /* "End of ProgressBar"  */
    SELFCLOSING = 274,             /* "Self-closing Tag"  */
    ENDTAG = 275,                  /* "End of Start Tag"  */
    LAYOUT_WIDTH = 276,            /* "Layout Width Attribute"  */
    LAYOUT_HEIGHT = 277,           /* "Layout Height Attribute"  */
    ID = 278,                      /* "ID Attribute"  */
    ORIENTATION = 279,             /* "Orientation Attribute"  */
    TEXT = 280,                    /* "Text Attribute"  */
    TEXTCOLOR = 281,               /* "TextColor Attribute"  */
    SRC = 282,                     /* "Src Attribute"  */
    PADDING = 283,                 /* "Padding Attribute"  */
    CHECKEDBUTTON = 284,           /* "CheckedButton Attribute"  */
    MAX = 285,                     /* "Max Attribute"  */
    PROGRESS = 286,                /* "Progress Attribute"  */
    RADIOBUTTON_COUNT = 287,       /* "RadioButton Count Attribute"  */
    POSINTEGER_VALUE = 288,        /* "Positive Integer Value"  */
    STRING_VALUE = 289             /* "String Value"  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 34 "syntax.y"

  char* string;
  int integer;

#line 103 "syntax.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_SYNTAX_TAB_H_INCLUDED  */
