#include<iostream>
#include<vector>
#include<string>
#include<algorithm>
#include<set>
#include<map>
#include<queue>
#include<deque>

using namespace std;

typedef pair<int,int> pi;
typedef vector<int> tlong;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back
#define task "next"

void make(string &s,int x){
  int l=0,last=x;
  for(int i=x;i<s.length();i++,l++){
    if(s[l]==s[i]){
      if(s[i]=='0')last=i;
      if(i==s.length()-1){
        s[last]='1';
        for(int j=last+1;j<s.length();j++)
	s[j]='0';	
        return;
        }
      continue;
      }
    if( s[i]>s[l] ) return;
    s[i]=s[l];
    }
  }
    
string s,res;    
    
void solve(){
  res=s;
  int n=s.length();
  res[n-1]++;
  bool ad=false;
  ford(i,n){
    while(res[i]>='2'){
      res[i]-=2;
      res[i-1]++;
      }
    }
  string now;
  for(int i=1;i<res.size();i++)
    if(res[i]=='0')make(res,i);
 }
   
int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  cin>>s;
  solve();
  printf("%s\n",res.data());    
  return 0;
};
