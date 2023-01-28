#include<bits/stdc++.h>
using namespace std;
vector<string> ans;
int main(){
    string input;
    while(getline(cin,input)){
        string tmp="NUM ";
        for(int i=0;i<input.size();i++){
            if(input[i]=='+'){
                ans.push_back("PLUS");
            }
            else if(input[i]=='-'){
                ans.push_back("MINUS");
            }
            else if(input[i]=='*'){
                ans.push_back("MUL");
            }
            else if(input[i]=='/'){
                ans.push_back("DIV");
            }
            else if(input[i]=='('){
                ans.push_back("LPR");
            }
            else if(input[i]==')'){

                ans.push_back("RPR");
            }
            else if(input[i]==' '){continue;}
            else{
                tmp+=input[i];
                if((input[i+1]<'0' || input[i+1]>'9') && i<=input.size()-1){
                    ans.push_back(tmp);
                    tmp="NUM ";
                }

            }
        }
    }
    for(int i=0;i<ans.size();i++){
        cout << ans[i] << endl;
    }
return 0;}
