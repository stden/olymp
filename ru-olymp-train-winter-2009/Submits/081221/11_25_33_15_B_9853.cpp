#include<treeunit.h>
#include<iostream>
#include<vector>
#include<string>
#include<algorithm>
#include<set>
#include<map>
#include<queue>
#include<deque>

using namespace std;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back

/*
vector<int> g[nmax];
int n,m;

void read(){
  init();
  n=getN();
  m=n;
  forn(i,n){
    int v=getA(i+1),u=getB(i+1);
    v--,u--;
    g[v].pb(u);
    g[u].pb(v);
    }
  };
  
int calc(int v){
  used[v]=0;
  s[v]=0;
  forn(i,g[v].size())
    if(!used[g[v][i]]){
      s[v]+=calc(g[v][i])+1;
      p[g[v][i]]=v;
      };
  return s[v];
  }
  
void solve(){
  int step=0;
  int root=rand()%n;
  forn(i,n)used[i]=false;
  calc(root);
  while(m>0){
    if(step==99)report(root);
    int id=root;
    forn(i,n)
      if(abs(m-s[id])>abs(m-s[i]))i=id;
    
      
*/
  
    

int main(){
  init();
  report(3);
  
  return 0;
};
