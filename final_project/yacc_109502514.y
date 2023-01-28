%{
    #include <stdio.h>
    #include <string.h>
    #include <stdlib.h>
    void yyerror(const char *message);
    typedef struct var{
	char* name;
        int value;
    }Var;
    Var vararr[100];
    Var funarr[100];
    int valnum=0;
    int funnum=0;
    int equal=1;
    int valcmp(char* valname){
        int i;
	for(i=0;i<valnum;i++){
		
		if( (strcmp(vararr[i].name,valname)) ==0){
			return vararr[i].value;
		}
	    }
    }
%}
%union{
    int ival;
    unsigned int torf;
    char* identify;
}

%token LP RP PRINTNUM PRINTBOOL
%token Plus_t Minus_t Multiply_t Divide_t
%token Greater_t Smaller_t Equal_t
%token Mod Or And Not FUN_t DEF_t IF_t
%token<torf> BOOL_t
%token<ival>  NUM_t
%token<identify> ID_t
%type<identify> VARIABLE

%%
PROGRAM : STMTS
  	;
STMTS : STMT STMTS | STMT;
STMT : EXP | DEF-STMT | PRINT-STMT;
PRINT-STMT : LP PRINTNUM EXP RP {printf("%d\n",$<ival>3);}
          | LP PRINTBOOL EXP RP {if($<torf>3==1){printf("#t\n");} else{printf("#f\n");}}
	   ;
EXP : BOOL_t 
     | NUM_t  
     | VARIABLE {
	    $<ival>$=valcmp($<identify>1);
	}
     | NUM-OP | LOGICAL-OP 
     | FUN-EXP | FUN-CALL | IF-EXP ;

NUM-OP : PLUS | MINUS | MULTIPLY | DIVIDE | MODULUS | GREATER
       | SMALLER | EQUAL;

PLUS : LP Plus_t EXP PEXPS RP {$<ival>$=$<ival>3+$<ival>4;};
PEXPS : EXP PEXPS {$<ival>$=$<ival>1+$<ival>2;}
      | EXP {$<ival>$=$<ival>1;}
      ;
MINUS : LP Minus_t EXP EXP RP {$<ival>$=$<ival>3-$<ival>4;};
MULTIPLY : LP Multiply_t EXP MEXPS RP {$<ival>$=$<ival>3*$<ival>4;};
MEXPS : EXP MEXPS {$<ival>$=$<ival>1*$<ival>2;}
      | EXP {$<ival>$=$<ival>1;}
      ;
DIVIDE : LP Divide_t EXP EXP RP {$<ival>$=$<ival>3/$<ival>4;};
MODULUS : LP Mod EXP EXP RP {$<ival>$=$<ival>3%$<ival>4;};
GREATER : LP Greater_t EXP EXP RP {
		if($<ival>3 > $<ival>4){$<torf>$=1;}
		else{$<torf>$=0;}
		};
SMALLER : LP Smaller_t EXP EXP RP {
		if($<ival>3 < $<ival>4){$<torf>$=1;}
		else{$<torf>$=0;}
		};
EQUAL : LP Equal_t EXP EEXPS RP {
		if(($<ival>3 == $<ival>4)&&equal==1){$<torf>$=1;}
		else{$<torf>$=0;}
		equal=1;
		};
EEXPS : EXP EEXPS {
	    if($<ival>1!=$<ival>2){equal=0;}
	}
      | EXP
      ;
LOGICAL-OP : AND-OP | OR-OP | NOT-OP;
AND-OP : LP And EXP AEXPS RP {
	    if($<torf>3==1 && $<torf>4==1){$<torf>$=1;}
	    else{$<torf>$=0;}
	    
	}
	;
AEXPS : EXP AEXPS {
	    if($<torf>1==1 && $<torf>2==1){$<torf>$=1;}
	    else{$<torf>$=0;}
	}
	|EXP {$<torf>$=$<torf>1;}
	;

OR-OP : LP Or EXP OEXPS RP {
	    if($<torf>3==1 || $<torf>4==1){$<torf>$=1;}
	    else{$<torf>$=0;}
	    
	}
	;
OEXPS : EXP OEXPS {
	    if($<torf>1==1 || $<torf>2==1){$<torf>$=1;}
	    else{$<torf>$=0;}
	}
	| EXP {$<torf>$=$<torf>1;}
	;
NOT-OP : LP Not EXP RP {
	    if($<torf>3==0){$<torf>$=1;}
	    else{$<torf>$=0;}
	}
	;

DEF-STMT: LP DEF_t VARIABLE EXP RP{
		vararr[valnum].name = $<identify>3;
		vararr[valnum].value = $<ival>4;
		valnum++;
	  }
	;
VARIABLE : ID_t {$<identify>$=$<identify>1;}
	  ;

FUN-EXP:LP FUN_t FUN_IDs FUN-BODY RP{
           funarr[funnum].name=$<identify>3;
	   funarr[funnum].value=$<ival>4;
	   funnum++;
       }
       ;
FUN_IDs:LP IDs RP;
IDs : ID_t IDs {$<identify>$=$<identify>1;}
     | {$<identify>$="";}
     ;
FUN-BODY : EXP;
FUN-CALL:LP FUN-EXP PARAMS RP
	|LP FUN-NAME PARAMS RP;
PARAMS : PARAM PARAMS
       |
       ;
PARAM:EXP
     ;
FUN-NAME : ID_t;

IF-EXP : LP IF_t TEST-EXP THAN-EXP ELSE-EXP RP{
	    if($<torf>3==1){$<ival>$=$<ival>4;}
	    else{$<ival>$=$<ival>5;}
	}
	;
TEST-EXP:EXP;
THAN-EXP:EXP;
ELSE-EXP:EXP;

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

