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

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back

const int inf=(int)1e9;
const int nmax=60;

int g[nmax][nmax];
pi c[nmax][nmax];
int dp[nmax][1<<8];
int t[1<<8][nmax];
int n,m,k,v,res;

void read(){
  scanf("%d%d%d%d",&n,&m,&k,&v);
  v--;
  forn(i,n)
    forn(j,n)
      g[i][j]=inf;
  forn(i,n)
    forn(j,k){
      scanf("%d%d",&c[i][j].fs,&c[i][j].sc);
      if(c[i][j].fs==0)c[i][j].fs=inf;
      }

  forn(i,m){
    int v,u,w;
    scanf("%d%d%d",&v,&u,&w);
    v--,u--;
    g[v][u]=min(g[v][u],w);
    g[u][v]=g[v][u];
    }
  }
  
void floid(){
  forn(i,n)
    g[i][i]=0;
  forn(k,n)
    forn(i,n)
      forn(j,n)
        g[i][j]=min(g[i][j],g[i][k]+g[k][j]);
  }
  
void calc(int d){	
    forn(i,1<<k)
      dp[d][i]=inf;
    dp[d][0]=0;
    forn(i,1<<k)
      if(dp[d][i]<inf){
      int now=0;
      forn(j,k)
        if(i & (1<<j))now+=c[d][j].sc;  
      forn(j,k)
        if(c[d][j].fs<inf && ((i & (1<<j))==0))
	dp[d][i | (1<<j)]=min(dp[d][i | (1<<j)],dp[d][i]+c[d][j].fs*(100-now)/100);
      };
    } 
    
void pre_calc(){
  forn(i,n)
    calc(i);
  };
  
void solve(){
  floid();
  pre_calc();
  forn(i,1<<k)
    forn(j,n)
    t[i][j]=inf;
  t[0][v]=0;
  forn(j,1<<k)
    forn(i,n)
      forn(u,n)
      if(t[j][u]<inf){
      int now=g[u][i];
      forn(l,1<<k)
        if((l & j) ==0)
	t[j|l][i]=min(t[j|l][i],t[j][u]+dp[i][l]+now);
    };
  res=inf;
  forn(i,n)
    res=min(res,t[(1<<k)-1][i] + g[v][i]);
  if(res>=inf)res=-1;
  };
  
void write(){
  printf("%d\n",res);
  } 

int main(){
  freopen("armor.in","rt",stdin);
  freopen("armor.out","wt",stdout);
  read();
  solve();
  write();
  
  return 0;
};
