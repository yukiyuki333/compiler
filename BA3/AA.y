%{
    #include<stdio.h>
    void yyerror(const char *message);
    int ans=0;
    int tmp1,tmp2,tmp3;
    int permutation(int num1,int num2){
	    tmp1=1;tmp2=1;
            int i;
	    for(i=2;i<=num1;i++){
	        tmp1*=i;
	    }
	    for(i=2;i<=(num1-num2);i++){
	        tmp2*=i;
	    }
	    return tmp1/tmp2;
	}
    int combine(int num1,int num2){
	    tmp1=1;tmp2=1;tmp3=1;
	    int i;
	    for(i=2;i<=num1;i++){
	        tmp1*=i;
	    }
	    for(i=2;i<=(num1-num2);i++){
	        tmp2*=i;
	    }
	    for(i=2;i<=num2;i++){
	        tmp3*=i;
	    }
	    tmp2=tmp2*tmp3;
	    return tmp1/tmp2;
	}
%}
%union{
    int ival;
}
%token ADD SUB
%token PER COM
%token<ival> NUM
%type<ival> expr
%left ADD
%left SUB
%left PER
%left COM
%%
lines : line{printf("%d\n",ans);}
    ;
line : expr line
       | expr
     ;
expr : expr ADD expr {$$=$1+$3; ans=$$;}
     | expr SUB expr {$$=$1-$3; ans=$$;}
     | PER NUM NUM {
			if($2<$3 || $2>12 || $3>12){printf("Wrong Formula\n");return(0);}
			$$= permutation($2,$3); ans=$$;
                   }
     | COM NUM NUM {
			if($2<$3 || $2>12 || $3>12){printf("Wrong Formula\n");return(0);}
			$$=combine($2,$3); ans=$$;
		   }
     | PER ADD {printf("Wrong Formula\n");return(0);}
     | COM ADD {printf("Wrong Formula\n");return(0);}
     | NUM
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