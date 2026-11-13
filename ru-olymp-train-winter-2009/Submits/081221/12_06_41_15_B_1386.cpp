#include<iostream>
#include<vector>
#include<string>
#include<algorithm>
#include<set>
#include<map>
#include<queue>
#include<deque>
#include<treeunit.h>

using namespace std;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back
#define mp make_pair

const int nmax=(int)200000;

vector<int> g[nmax];
int s[nmax],p[nmax];
bool used[nmax];
int n,m;

map< pair<int,int>,int > h;

void read(){
  init();
  n=getN();
  m=n;
  forn(i,n){
    int v=getA(i+1),u=getB(i+1);
    v--,u--;
    g[v].pb(u);
    g[u].pb(v);
    h[mp(v,u)]=i+1;
    h[mp(u,v)]=i+1;    
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

int find(int v,int u){
  return h[mp(u,v)];
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
    int now=find(id,p[id]);
    int ans=query(now);
    if( (ans==0 && getA(now)==id) || (ans==1 && getB(now)==id) ){
      root=id;
      m=s[id];
      }else{
      int v=p[id];
      forn(i,g[v].size())
        if(g[v][i]==id)
	swap(g[v][i],g[v][g[v].size()-1]);
      g[v].resize(g[v].size()-1);
      while(v!=root){
        s[v]-=s[id]+1;
        v=p[v];
        }
      m-=s[id]+1;
      }
    }
 report(root);
}
int main(){
  read();
  solve();
  return 0;
};
