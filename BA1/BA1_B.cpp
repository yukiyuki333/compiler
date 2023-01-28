#include<iostream>
#include<string>
#include<vector>
using namespace std;
vector<string> ans;
string s1;
void Proc(int *index,string s);
void Stmt(int *index,string s);
void Class(int *index,string s);
void Func(int *index,string s);
void Args(int *index,string s);
void Arg(int *index,string s);
int flag=1;
int main(){
    string s="";
    while(getline(cin,s1)){
        if(s1==""){break;}
        for(int i=0;i<s1.size();i++){
            if(s1[i]!=' '){
                s+=s1[i];
            }
        }
    }
    int i=0;
    int *index=&i;
    Proc(index,s);
    if(flag==0){
        cout << "Invalid input" << endl;
    }
    else{
        for(int i=0;i<ans.size();i++){
            cout << ans[i] << endl;
        }
    }


return 0;}

void Proc(int *index,string s){
    Stmt(index,s);
}
void Stmt(int *index,string s){
    if(s[*index]>='A'&&s[*index]<='Z'&& *index<s.size()){
        Class(index,s);
    }
    else if(s[*index]=='(' && *index<s.size()){
        Func(index,s);
    }
}
void Class(int *index,string s){
    string tmp="className ";
    if(s[*index]>='A'&& s[*index]<='Z'&& *index<s.size()){
        tmp+=s[*index];
        *index=*index+1;
    }
    ans.push_back(tmp);
    tmp="";
    if(s[*index]!='('){flag=0;}
    else{
        ans.push_back("leftParen (");
        *index=*index+1;
    }
    if(s[*index]!=')'){flag=0;}
    else{
        ans.push_back("rightParen )");
        *index=*index+1;
    }
    Args(index,s);
}
void Func(int *index,string s){
    ans.push_back("leftParen (");
    *index=*index+1;
    string tmp="funcName ";
    if(s[*index]>='a'&& s[*index]<='z' && *index<s.size()){
        tmp+=s[*index];
        *index=*index+1;
    }
    if(tmp!="funcName "){
        ans.push_back(tmp);
        tmp="";
    }
    else{
        flag=0;
    }
    if(s[*index]=='(' && s[*index+1]==')'){flag=0;}
    else{Args(index,s);}
    if(s[*index]!=')'){flag=0;}
    else{
        ans.push_back("rightParen )");
        *index=*index+1;
    }
}
void Args(int *index,string s){
    if(*index<s.size() && s[*index]>='0' && s[*index]<='9'){
        Arg(index,s);
        Args(index,s);
    }
    else if(*index<s.size() && s[*index]=='('){
        Arg(index,s);
        Args(index,s);
    }

}
void Arg(int *index,string s){
    if(s[*index]>='0' && s[*index]<='9' && *index<s.size()){
        string tmp="num ";
        tmp+=s[*index];
        ans.push_back(tmp);
        *index=*index+1;
        if(s[*index]>='0' && s[*index]<='9' && *index<s.size()){
            flag=0;
        }
    }
    else if(s[*index]=='(' && *index<s.size()){
        Func(index,s);

    }

}
