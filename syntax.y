%{
  #include <stdio.h>  
  #include <string.h>
  #include <stdlib.h>
  #include <stdbool.h>

  extern FILE *yyin;
  extern int yylex();
  extern int yylineno;

  char* ID_array[50];
  int number_of_IDs = 0; 
  bool has_duplicate_IDs = false;

  bool is_width_allowed = true;
  bool is_height_allowed = true;

  bool is_padding_positive = true;

  int max_value;
  int progress_value;
  bool is_progress_allowed = true;

  int numRadioButtons = 0;
  int radioButton_count_input;

  void yyerror(const char *errmsg);
  void print_program(FILE *file);
%}

// Provides more detailed error messages
%define parse.error verbose

%union {
  char* string;
  int integer;
}

%token LINEARLAYOUT_START           "Start of LinearLayout"
%token RELATIVELAYOUT_START         "Start of RelativeLayout"
%token TEXTVIEW_START               "Start of TextView"
%token IMAGEVIEW_START              "Start of ImageView"
%token BUTTON_START                 "Start of Button"
%token RADIOBUTTON_START            "Start of RadioButton"
%token RADIOGROUP_START             "Start of RadioGroup"
%token PROGRESSBAR_START            "Start of ProgressBar"

%token LINEARLAYOUT_END             "End of LinearLayout"
%token RELATIVELAYOUT_END           "End of RelativeLayout"
%token TEXTVIEW_END                 "End of TextView"
%token IMAGEVIEW_END                "End of ImageView"
%token BUTTON_END                   "End of Button"
%token RADIOBUTTON_END              "End of RadioButton"
%token RADIOGROUP_END               "End of RadioGroup"
%token PROGRESSBAR_END              "End of ProgressBar"

%token SELFCLOSING                  "Self-closing Tag"
%token ENDTAG                       "End of Start Tag"

%token LAYOUT_WIDTH                 "Layout Width Attribute"  
%token LAYOUT_HEIGHT                "Layout Height Attribute"
%token ID                           "ID Attribute"
%token ORIENTATION                  "Orientation Attribute"
%token TEXT                         "Text Attribute"
%token TEXTCOLOR                    "TextColor Attribute"
%token SRC                          "Src Attribute"
%token PADDING                      "Padding Attribute"
%token CHECKEDBUTTON                "CheckedButton Attribute"
%token MAX                          "Max Attribute"
%token PROGRESS                     "Progress Attribute"
%token RADIOBUTTON_COUNT            "RadioButton Count Attribute"

%token <integer> POSINTEGER_VALUE   "Positive Integer Value"
%token <string> STRING_VALUE        "String Value"

%token ENDOFFILE 0                  "End of File"

%%

root: linearLayout | relativeLayout;

linearLayout: LINEARLAYOUT_START width height id_optional orientation_optional ENDTAG content LINEARLAYOUT_END;

relativeLayout: emptyRelativeLayout | nonEmptyRelativeLayout;

nonEmptyRelativeLayout: RELATIVELAYOUT_START width height id_optional ENDTAG content RELATIVELAYOUT_END;

emptyRelativeLayout: RELATIVELAYOUT_START width height id_optional ENDTAG RELATIVELAYOUT_END | RELATIVELAYOUT_START width height id_optional SELFCLOSING;

content: options | options content;

options: linearLayout | relativeLayout | textView | imageView | button | radioGroup | progressBar;

textView: TEXTVIEW_START width height id_optional text textColor_optional ENDTAG TEXTVIEW_END | TEXTVIEW_START width height id_optional text textColor_optional SELFCLOSING;

imageView: IMAGEVIEW_START width height id_optional src padding_optional ENDTAG IMAGEVIEW_END | IMAGEVIEW_START width height id_optional src padding_optional SELFCLOSING;

button: BUTTON_START width height id_optional text padding_optional ENDTAG BUTTON_END | BUTTON_START width height id_optional text padding_optional SELFCLOSING;

radioGroup: RADIOGROUP_START width height id_optional radioButton_count checkedButton_optional ENDTAG radioGroupContent RADIOGROUP_END;

radioGroupContent: radioButton | radioButton radioGroupContent;

radioButton: RADIOBUTTON_START width height id_optional text ENDTAG RADIOBUTTON_END {
  numRadioButtons++;
} | RADIOBUTTON_START width height id_optional text SELFCLOSING {
  numRadioButtons++;
};

progressBar: PROGRESSBAR_START width height id_optional max_optional progress_optional ENDTAG PROGRESSBAR_END | PROGRESSBAR_START width height id_optional max_optional progress_optional SELFCLOSING;

width: LAYOUT_WIDTH POSINTEGER_VALUE | LAYOUT_WIDTH STRING_VALUE {
  char* width = $2;

  /* Check if width's value is allowed */
  if (strcmp("\"wrap_content\"", width) != 0 && strcmp("\"match_parent\"", width) != 0) {
    printf("ERROR: This layout width value (%s) is not allowed at line %d.\n", width, yylineno);
    is_width_allowed = false;
  }
};

height: LAYOUT_HEIGHT POSINTEGER_VALUE | LAYOUT_HEIGHT STRING_VALUE {
  char* height = $2;

  /* Check if height's value is allowed */
  if (strcmp("\"wrap_content\"", height) != 0 && strcmp("\"match_parent\"", height) != 0) {
    printf("ERROR: This layout height value (%s) is not allowed at line %d.\n", height, yylineno);
    is_height_allowed = false;
  }
};

id_optional: ID STRING_VALUE {
  char* current_ID = $2;

  /* Check for duplicate ID */
  for (int i=0; i<number_of_IDs; i++){
    if (strcmp(ID_array[i], current_ID) == 0 ){
      printf("ERROR: Duplicate ID %s was found at line %d.\n", current_ID, yylineno);
      has_duplicate_IDs = true;
      break;
    }
  }

  /* Store unique IDs in the ID array if no duplicates exist */
  if (!has_duplicate_IDs){
    ID_array[number_of_IDs] = strdup(current_ID);
    number_of_IDs++;
  }
  
} | %empty;

orientation_optional: ORIENTATION STRING_VALUE | %empty;

text: TEXT STRING_VALUE;

textColor_optional: TEXTCOLOR STRING_VALUE | %empty;

src: SRC STRING_VALUE;

padding_optional: PADDING POSINTEGER_VALUE | PADDING STRING_VALUE {
  char* padding = $2;

  /* Check if the padding is positive */
  if (atoi(padding) <= 0) {
    printf("Invalid padding value %s at line %d. Padding must be a positive integer.\n", padding, yylineno);
    is_padding_positive = false;
  } 

} | %empty;

checkedButton_optional: CHECKEDBUTTON STRING_VALUE | %empty;

max_optional: MAX POSINTEGER_VALUE {
  max_value = $2;
} | %empty;

progress_optional: PROGRESS POSINTEGER_VALUE {
  progress_value = $2;

  /* Check if progress value is between 0 and max value */
  if (progress_value < 0 || progress_value > max_value) {
    printf("Invalid progress value: %d. Progress value must be between 0 and %d.\n", progress_value, max_value);
    is_progress_allowed = false;
  }
} | %empty;

radioButton_count: RADIOBUTTON_COUNT POSINTEGER_VALUE {
  radioButton_count_input = $2;
}

%%

void yyerror(const char *errmsg) {
  printf("ERROR encountered at line %d (%s).", yylineno, errmsg);
}

void print_program(FILE *file) {
  // Print the entire program
  int ch;
  while ((ch = fgetc(yyin)) != EOF) {
      putchar(ch);
  }

  // Reset the file pointer back to the beginning
  rewind(yyin);
}

int main(int argc, char **argv) {
  int token;

  if (argc > 1) {
    // Open the file for reading
    yyin = fopen(argv[1], "r");

    if (yyin == NULL) {
      perror("ERROR opening file!");
      return -1;
    }
  }

  print_program(yyin);

  printf("\n\n");

  int result = yyparse();

  bool radioButtonsMatchCount = (numRadioButtons == radioButton_count_input);

  if (!radioButtonsMatchCount) {
    printf("ERROR: The number of radio buttons (%d) does not match the expected count (%d).\n", numRadioButtons, radioButton_count_input);
  }

  if (!has_duplicate_IDs && is_width_allowed && is_height_allowed && is_padding_positive && is_progress_allowed && radioButtonsMatchCount && result == 0){
    printf("The program was executed successfully!");
  } else {
    printf("The program was not executed successfully!");
  }

  // Close the file
  fclose(yyin);

  return 0;
}