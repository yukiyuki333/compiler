#include<bits/stdc++.h>
using namespace std;
vector<string> rule;
vector<string> first;
vector<int> has_found;
void Sort(int index){
    for(int i=1;i<first[index].size();i++){
        for(int j=i+1;j<first[index].size();j++){
            if(first[index][i]>first[index][j]){
                swap(first[index][i],first[index][j]);
            }
        }
    }

}
int Find(char nont){
    //找這個 Nonterminal 在哪一項
    int i;
    for(int j=0;j<rule.size();j++){
        if(rule[j][0]==nont){
            i=j; break;
        }
    }
    if(has_found[i]==1){return i;}
    int ruleCount=2;
    int ruleend=2;
    int this_has_end=0;
    while(ruleCount<rule[i].size()){
        while(rule[i][ruleend]!='|' && ruleend<rule[i].size()){
            ruleend++;
        }
        ruleend--;
        int tmp=ruleCount;
        int hasend=0;//決定 set 要不要補 ';'
        for(int num=tmp;num<=ruleend;num++){
            if(rule[i][ruleCount]>='A' && rule[i][ruleCount]<='Z'){
                hasend=0;
                //如果這項是 Nonterminal，先找這個 Nonterminal 的 first，Find 回傳該 Nonterminal index
                int index=Find(rule[i][ruleCount]);
                //first[index] 要加入到 first[i] 內，加之前先檢查有無重複
                //順便檢查 first[index] 有沒有 ;
                for(int j=1;j<first[index].size();j++){
                    if(first[index][j]==';'){hasend=1;continue;}
                    int flag=0;
                    for(int k=1;k<first[i].size();k++){
                        if(first[i][k]==first[index][j]){
                            flag=1;break;
                        }
                    }
                    if(flag==0){
                        first[i]+=first[index][j];
                    }

                }
                ruleCount++;
                if(hasend==0){
                    break;
                }
            }
            //是 terminal，直接加，要檢查重複
            if((rule[i][ruleCount]>='a' && rule[i][ruleCount]<='z') ||
                 rule[i][ruleCount]==';'||rule[i][ruleCount]=='$'){
                hasend=0;
                if(rule[i][ruleCount]==';'){this_has_end=1;}
                int flag=0;
                for(int j=1;j<first[i].size();j++){
                    if(first[i][j]==rule[i][ruleCount]){
                        flag=1;break;
                    }
                }
                if(flag==0){
                    first[i]+=rule[i][ruleCount];
                }
                break;

            }
        }
        if(hasend==1 && this_has_end==0){
            first[i]+=';';
            this_has_end=1;
        }
        ruleend+=2;
        ruleCount=ruleend;
    }
    has_found[i]=1;
    return i;
}
int main(){
    string s;
    while(getline(cin,s)){
        if(s=="END_OF_GRAMMAR"){
            break;
        }
        rule.push_back(s);
        string t="";
        t+=s[0];
        first.push_back(t);
        has_found.push_back(0);
    }
    for(int i=0;i<rule.size();i++){
        Find(rule[i][0]);
    }
    sort(first.begin(),first.end());
    for(int i=0;i<first.size();i++){
        Sort(i);
        cout << first[i][0] << " ";
        for(int j=1;j<first[i].size();j++){
            cout << first[i][j];
        }
        cout << endl;
    }
    cout << "END_OF_FIRST" << endl;

return 0;}




/*

S ACb|BBa
A ;
B ;
C p
END_OF_GRAMMAR



*/
