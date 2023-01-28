%{
    #include <stdio.h>
    int Stack[100];
    int top = -1;
    int flag = 1;
    void yyerror(const char *message);
%}
%union
{
    int ival;
}
%token  ADD SUB MUL MOD LOAD
%token  INC DEC
%token  <ival>  INTN
%type   <ival>  expr
%%
lines : line {
		if(flag==1 && top==0){printf("%d\n",Stack[top]);}
		else{printf("Invalid format\n");}
	     }
	;
line : expr line
       |expr
       ;
expr : LOAD INTN{
		    if(top>=-1){
			top++;
			Stack[top]=$2;
		    }
		    else{
			flag=0;
		    }
		
		}
	|ADD {
		if(top>=1){
		    Stack[top-1]+=Stack[top];
		    Stack[top]=0;
		    top--;
		}
		else{flag=0;}
		
	     }
	|SUB {
		if(top>=1){
		    Stack[top-1]=Stack[top]-Stack[top-1];
		    Stack[top]=0;
		    top--;
		}
		else{flag=0;}
	     }
	|MUL {
		if(top>=1){
		    Stack[top-1]=Stack[top]*Stack[top-1];
		    Stack[top]=0;
		    top--;
		}
		else{flag=0;}
	     }
	|MOD {
		if(top>=1){
		    Stack[top-1]=Stack[top]%Stack[top-1];
		    Stack[top]=0;
		    top--;
		}
		else{flag=0;}
	     }
	|INC {
		if(top>=0){
		    Stack[top]++;
		}
		else{flag=0;}
	     }
	|DEC {
		if(top>=0){
		    Stack[top]--;
		}
		else{flag=0;}
	     }
	;
%%
void yyerror (const char *message)
{
    printf("%s\n", message);
}
int main(int argc, char *argv[])
{
    yyparse();
    return(0);
}