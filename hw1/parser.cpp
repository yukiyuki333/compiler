#include<iostream>
#include<string>
#include<vector>
#include <regex>
using namespace std;
string input="";
vector<string> ans;
int flag=1;
regex reg("[A-Za-z_][A-Za-z0-9_]*");
void program(int *index);
void stmts(int *index);
void stmt(int *index);
void primary(int *index);
void primary_tail(int *index);
int main(){
    string s;
    int iii=0;
    int *index=&iii;
    while(getline(cin,s)){
        input+=s;
    }
    program(index);
    if(flag==1){
        for(int i=0;i<ans.size();i++){
            cout << ans[i] << endl;
        }
    }
    else{
        cout << "invalid input" << endl;
    }

return 0;}
void primary_tail(int *index){
    if(input[*index]=='.'){
        ans.push_back("DOT .");
        *index=*index+1;
        if(input[*index]==' '){*index=*index+1;}
        string tmp="";
        while(true){
            if(input[*index]=='(' || input[*index]=='.'|| *index==input.size()){
                break;
            }
            else{
                tmp+=input[*index];
                *index=*index+1;
            }
        }
        if(regex_match(tmp,reg)){
            if(tmp!=""){
                tmp="ID "+tmp;
                ans.push_back(tmp);
            }
            primary_tail(index);
        }
        else{
            flag=0;
        }
    }
    else if(input[*index]=='('){

        ans.push_back("LBR (");
        *index=*index+1;
        if(input[*index]==' '){*index=*index+1;}
        stmt(index);
        if(input[*index]==' '){*index=*index+1;}
        if(input[*index]==')'){
            ans.push_back("RBR )");
            *index=*index+1;
        }
        else{flag=0;}
        primary_tail(index);
    }
}
void primary(int *index){
    string tmp="";
    while(true){
        if(input[*index]=='(' || input[*index]=='.'|| *index==input.size()){
            break;
        }
        else{
            tmp+=input[*index];
            *index=*index+1;
        }
    }
    //cout << tmp << endl;
    if(regex_match(tmp,reg)){
        if(tmp!=""){
            tmp="ID "+tmp;
            ans.push_back(tmp);
        }
        primary_tail(index);
    }
    else{
        flag=0;
    }
}
void stmt(int *index){
    if(input[*index]=='"'&& *index!=input.size()){
        string tmp="STRLIT \"";
        *index=*index+1;
        int tmpflag=0;
        while(true){
            if(input[*index]=='"' && *index!=input.size()){
                tmpflag=1;
                break;
            }
            else if(input[*index]=='^'){
                tmpflag=0;
                break;
            }
            else if(*index==input.size()){break;}
            tmp+=input[*index];
            *index=*index+1;
        }
        if(tmpflag==0){
            flag=0;
        }
        else{
            tmp+="\"";
            *index=*index+1;
            //cout << tmp << endl;
            ans.push_back(tmp);
        }
    }
    else if(*index!=input.size() && input[*index]!=')'){
        primary(index);
    }
}
void stmts(int *index){
    if(*index!=input.size()){
        stmt(index);
        stmts(index);
    }
}
void program(int *index){
    stmts(index);
}




/*
print("123" 123")



*/
