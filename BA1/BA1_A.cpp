#include<iostream>
#include<string>
#include<vector>
using namespace std;
int main(){
    string s;
    while(getline(cin,s)){
        vector<string> ans;
        string tmp="";
        int flag=1;
        for(int i=0;i<s.size();i++){
            if(s[i]==' '){continue;}
            else if(s[i]=='+' || s[i]=='-' || s[i]=='*'
                    || s[i]=='/' || s[i]=='='){
                        tmp="OP ";
                        tmp+=s[i];
                        ans.push_back(tmp);
                        tmp="";
            }
            else if(s[i]=='('){
                tmp="LPR ";
                ans.push_back(tmp);
                tmp="";
            }
            else if(s[i]==')'){
                tmp="RPR ";
                ans.push_back(tmp);
                tmp="";
            }
            else if((s[i]>='A' && s[i]<='Z')||(s[i]>='a' && s[i]<='z')){
                tmp="ID ";
                while((s[i]>='A' && s[i]<='Z')||(s[i]>='a' && s[i]<='z')&&i<s.size()){
                    tmp+=s[i];
                    i++;
                }
                if(s[i]!=' '){
                    if((s[i+1]>='A' && s[i+1]<='Z')||(s[i+1]>='a' && s[i+1]<='z')&&i+1<s.size()){
                        flag=0;
                    }
                }
                i--;
                ans.push_back(tmp);
                tmp="";
            }
            else if(s[i]=='0' || (s[i]>='1' && s[i]<='9')){
                tmp="NUM ";
                if(s[i]!='0'){
                    while(s[i]>='0' && s[i]<='9' && i<s.size()){
                        tmp+=s[i];
                        i++;
                    }
                    i--;
                }
                else if(s[i]=='0' && (s[i+1]>='0' && s[i+1]<='9')&& i+1<s.size()){
                    flag=0;
                }
                ans.push_back(tmp);
                tmp="";

            }
            else{flag=0;}

        }
        if(flag==1){
            for(int i=0;i<ans.size();i++){
                cout << ans[i] << endl;
            }
        }
        else{
            cout << "invalid output" << endl;
        }






    }



return 0;}
