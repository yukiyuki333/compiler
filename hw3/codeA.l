%{
    #include "ex1.tab.h"
%}
%%
\n {/*donothing*/}
[0-9]+ {yylval.ival=atoi(yytext);return INTN;}
^"add"  { return ADD; }
^"sub"  { return SUB; }
^"mul"  { return MUL; }
^"mod"  { return MOD; }
^"inc"  { return INC; }
^"dec"  { return DEC; }
^"load" { return LOAD;}
. {/*donothing*/}
%%


指令
轉成.c
flex -o lex.yy.c code.l
編譯
gcc -o code lex.yy.c -lfl
餵輸入
cat input1.txt | ./code
./code < input1.txt

掛載
sudo mount -t vboxsf HW2_1 /home/user/Desktop/share


編譯 bison
bison -d -o y.tab.c ex1.y
gcc -c -g -I.. y.tab.c
編譯 flex
flex -o lex.yy.c codeA.l
gcc -c -g -I.. lex.yy.c
編譯與連結
gcc -o ex1 y.tab.o lex.yy.o -ll
餵輸入
cat input1.txt | ./ex1
./ex1 < input1.txt

上傳時若有 compile error，應把 lex 標頭換成 yacc 檔名