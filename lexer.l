%{
  #include <stdio.h>
  #include "syntax.tab.h"

  int show_tokens = 0;
  void print_token(const char* message);
%}

/* To read ONLY one file at a time. */
%option noyywrap

/* Enables the tracking of line numbers in the input file. */
%option yylineno

/* Regular expressions */
POSINTEGER  [1-9][0-9]*
STRING      [^"]*
WHITESPACE  [ \t]+
COMMENT     [^-]*(?:-[^-][^-]*)*

%%

"<LinearLayout"               {print_token("LinearLayout start was found!"); return LINEARLAYOUT_START;}
"<RelativeLayout"             {print_token("RelativeLayout start was found!"); return RELATIVELAYOUT_START;}
"<TextView"                   {print_token("TextView start was found!"); return TEXTVIEW_START;}
"<ImageView"                  {print_token("ImageView start was found!"); return IMAGEVIEW_START;}
"<Button"                     {print_token("Button start was found!"); return BUTTON_START;}
"<RadioButton"                {print_token("RadioButton start was found!"); return RADIOBUTTON_START;}
"<RadioGroup"                 {print_token("RadioGroup start was found!"); return RADIOGROUP_START;}
"<ProgressBar"                {print_token("ProgressBar start was found!"); return PROGRESSBAR_START;}

"<\/LinearLayout>"            {print_token("LinearLayout end was found!"); return LINEARLAYOUT_END;}
"<\/RelativeLayout>"          {print_token("RelativeLayout end was found!"); return RELATIVELAYOUT_END;}
"<\/TextView>"                {print_token("TextView end was found!"); return TEXTVIEW_END;}
"<\/ImageView>"               {print_token("ImageView end was found!"); return IMAGEVIEW_END;}
"<\/Button>"                  {print_token("Button end was found!"); return BUTTON_END;}
"<\/RadioButton>"             {print_token("RadioButton end was found!"); return RADIOBUTTON_END;}
"<\/RadioGroup>"              {print_token("RadioGroup end was found!"); return RADIOGROUP_END;}
"<\/ProgressBar>"             {print_token("ProgressBar end was found!"); return PROGRESSBAR_END;}

"\/>"                         {print_token("Self-closing tag was found!"); return SELFCLOSING;}
">"                           {print_token("End of start tag was found!"); return ENDTAG;}

"android:layout_width="       {print_token("Layout width attribute was found!"); return LAYOUT_WIDTH;}
"android:layout_height="      {print_token("Layout height attribute was found!"); return LAYOUT_HEIGHT;}
"android:id="                 {print_token("ID attribute was found!"); return ID;}
"android:orientation="        {print_token("Orientation attribute was found!"); return ORIENTATION;}
"android:text="               {print_token("Text attribute was found!"); return TEXT;}
"android:textColor="          {print_token("TextColor attribute was found!"); return TEXTCOLOR;}
"android:src="                {print_token("Src attribute was found!"); return SRC;}
"android:padding="            {print_token("Padding attribute was found!"); return PADDING;}
"android:checkedButton="      {print_token("CheckedButton attribute was found!"); return CHECKEDBUTTON;}
"android:max="                {print_token("Max attribute was found!"); return MAX;}
"android:progress="           {print_token("Progress attribute was found!"); return PROGRESS;}
"android:radioButton_count="  {print_token("RadioButton count attribute was found!"); return RADIOBUTTON_COUNT;}
"\""{POSINTEGER}"\""          {print_token("Positive integer was found!"); 
                               /* Assigns the integer value instead of a string */
                               yylval.integer = atoi(yytext + 1);
                               return POSINTEGER_VALUE;}

"\""{STRING}"\""              {print_token("String was found!"); yylval.string = strdup(yytext); return STRING_VALUE;}

"<!--"{COMMENT}"-->"          {/* Ignore comments */}
{WHITESPACE}                  {/* Ignore whitespace and tabs */}
\r\n                          {/* Ignore change of line */}
<<EOF>>                       {print_token("End of file."); return ENDOFFILE; }
.                             {/* printf("Invalid token at line %d: %s\n", yylineno, yytext); */}

%%

void print_token(const char* message) {
  if (show_tokens)
    printf("%s\n", message);
}