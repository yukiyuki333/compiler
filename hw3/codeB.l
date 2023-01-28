%{
    #include "ex2.tab.h"
    int Index=0;
%}
%%
\n {/*do nothing*/}
[ \t]+  { Index += yyleng; }
"+"|"-" {Index+=1;yylval.ope=Index;return ADD;}
"*" {Index+=1;yylval.ope=Index;return MUL;}
"," {Index+=1;return COMMA;}
"[" {Index+=1; return LM;}
"]" {Index+=1; return RM;}
"(" {Index+=1; return L;}
")" {Index+=1; return R;}
"^T" {Index+=2; return TRA;}
[0-9]+ {Index+=yyleng; yylval.ival=atoi(yytext); return NUM;}
. {/*do nothing*/}
%%