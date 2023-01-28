編譯方法
1.打開編譯器課程給的 linux 環境
2.將 L 檔、Y檔放進家目錄
3.將測資的 txt 檔放進家目錄
4.打開終端機，輸入以下指令編譯 L、Y 檔
bison -d -o y.tab.c yacc_109502514.y
gcc -c -g -I.. y.tab.c
flex -o lex.yy.c lex_109502514.l
gcc -c -g -I.. lex.yy.c
gcc -o yacc_109502514 y.tab.o lex.yy.o -ll

5.輸入以下指令，即可讀入測資
cat input1.txt | ./yacc_109502514
其中 input1 應改成所需讀入測資的檔名

答題範圍
測資1~6
測資7以後的功能未完成