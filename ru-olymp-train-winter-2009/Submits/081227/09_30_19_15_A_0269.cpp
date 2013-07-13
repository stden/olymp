#include<iostream>
#include<vector>
#include<string>
#include<cstring>
#include<algorithm>
#include<set>
#include<map>
#include<queue>
#include<deque>

using namespace std;

typedef long long int64;
typedef long double real;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back
#define mp make_pair
#define task "help"

const int smax=6;
int should=10;

char zn[smax]={'+','=','-','*','/'};

int inf=(int)1e4;
int md=50;
vector<string> a;
string s;

void answer(string s){
  printf("%s\n",s.data());
  exit(0);
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  
  int bad=0;
  
  while(cin>>s)a.pb(s);
  if(a.size()>inf)bad+=100;//answer("NO");
  bool find_const=false;
  forn(i,a.size()){
    if(a[i]=="const")find_const=true;
    if(a[i]=="integer")bad+=100;//answer("NO");
    if(a[i].length()>md)bad+=200;//answer("NO");
    bool znak=false,other=false;
    forn(j,a[i].size()){
      bool now=false;
      forn(k,smax)
        if(a[i][j]==zn[k])now=true;
      if(now)znak=true;else  
        if(a[i][j]!=':')other=true;
      }
    if(other && znak){
      //cout<<a[i]<<endl;
      //answer("NO");
      bad+=150;
      }
    }
  if(!find_const)bad+=100;//answer("NO");    
 // cout<<bad<<" "<<a.size()<<endl;
  if(bad > should*a.size())answer("NO");  
  answer("YES");  
  return 0;
};
