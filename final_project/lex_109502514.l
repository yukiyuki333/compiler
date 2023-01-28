%{
    #include "y.tab.h"
%}
letter [a-z]
number 0|[1-9][0-9]*|-[1-9][0-9]*
id {letter}({letter}|[0-9]|"-")*
%%
[ |\t|\r|\n]+ {}
"(" {return LP;}
")" {return RP;}
"print-num" {return PRINTNUM;}
"print-bool" {return PRINTBOOL;}
"+" {return Plus_t;}
"-" {return Minus_t;}
"*" {return Multiply_t;}
"/" {return Divide_t;}
">" {return Greater_t;}
"<" {return Smaller_t;}
"=" {return Equal_t;}
"mod" {return Mod;}
"and" {return And;}
"or" {return Or;}
"not" {return Not;}
"fun"  {return FUN_t;}
"define" {return DEF_t;}
"if" {return IF_t;}
"#t" {yylval.torf=1; return BOOL_t;}
"#f" {yylval.torf=0; return BOOL_t;}
{number} {yylval.ival=atoi(yytext);return NUM_t;}
{id} {yylval.identify=strdup(yytext);return ID_t;}
. {}
%%