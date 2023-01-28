%{
    #include "AA.tab.h"
%}
%%
\n {}
[ \t]+ {}
"+" {return ADD;}
"-" {return SUB;}
"P"|"p" {return PER;}
"C"|"c" {return COM;}
[0-9]+ {yylval.ival=atoi(yytext); return NUM;}
. {}

%%