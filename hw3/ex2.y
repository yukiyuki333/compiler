%{
    #include <stdio.h>
    void semeticerror(int index);
    void yyerror (const char *message);
%}
%code requires
{
    struct pair{int x,y;};
}
%union{
    int ival;
    int ope;
    struct pair Matrix;
}
%token <ope> ADD
%token <ope> MUL
%token TRA COMMA
%token LM RM
%token L R
%token <ival> NUM
%type <Matrix> matrix

%left ADD
%left MUL
%left TRA
%%
line :matrix{printf("Accepted\n"); return(0);}
     ;
matrix :LM NUM COMMA NUM RM {$$.x=$2; $$.y=$4;}
       |L matrix R {$$.x=$2.x;$$.y=$2.y;}
       |matrix TRA {$$.x=$1.y;$$.y=$1.x;}
       |matrix MUL matrix {
			      if($1.y==$3.x){
				$$.x=$1.x; $$.y=$3.y;
			      }
			      else{semeticerror($2);return(0);}
			      
			  }
       |matrix ADD matrix {
			      if($1.x==$3.x && $1.y==$3.y){
				$$.x=$1.x; $$.y=$1.y;
			      }
			      else{semeticerror($2);return(0);}
			  }
	;
%%
void semeticerror(int index){
    printf("Semantic error on col %d\n", index);
}
void yyerror (const char *message)
{
    printf("%s\n", message);
}
int main(int argc, char *argv[])
{
    yyparse();
    return(0);
}
