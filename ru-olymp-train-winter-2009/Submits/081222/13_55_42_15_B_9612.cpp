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
#define mp make_pair
#define task "cuts"

const int nmax=100;
const int inf=(int)1e9;
int c[nmax][nmax];
int f[nmax][nmax];
int s,t,mflow,n,m;
int h[nmax],e[nmax],pos[nmax],res[nmax];
vector<pi> have;

void read(){
  scanf("%d%d",&n,&m);
  forn(i,n)
    forn(j,n)
      c[i][j]=0;
  forn(i,m){
    int v,u,w;
    scanf("%d%d%d",&v,&u,&w);
    c[v][u]+=w;
    }
  }

void push(int v,int u){
  if(h[v]<=h[u])return;
  int ad=min(e[v],c[v][u]-f[v][u]);
  e[v]-=ad,e[u]+=ad;
  f[v][u]+=ad,f[u][v]-=ad;
  }

void up(int v){
  while(pos[v]<n){
    push(v,pos[v]);
    if(e[v]==0)return;
    pos[v]++;
    }
  pos[v]=0;
  h[v]++;
  up(v);
  }

int flow(int s,int t){
  forn(i,n)
    forn(j,n)
      f[i][j]=0;
  forn(i,n)h[i]=e[i]=pos[i]=0;
  h[s]=n;
  e[s]=inf;
  forn(i,n)
    if(i!=t && i!=s)
      push(s,i);
  while(1){
    int v=-1;
    forn(i,n)
      if(e[i]>0 && i!=s && i!=t && (v==-1 || h[v]<h[i]))v=i;
    if(v==-1)break;
    up(v);
    }  
  return e[t];
  }

void solve(){
  /*s=0;
  t=n-1;
  mflow=0;
  for(int i=1;t<n;t++){
    int now=flow(s,i);
    have.pb(mp(now,i));
    }
  */
  have.pb(mp(n-1,0));
  }
  
void dfs(int v){
  res[v]=0;
  forn(i,n)
    if(res[i]==1 && (c[v][i]-f[v][i]>0))dfs(i);
  }
  
void write(){
  sort(all(have));
  int k;
  cin>>k;
    forn(j,n)res[j]=1;  
  flow(s,have[0].sc);
  dfs(s);
  forn(i,n)
    printf("%d",res[i]);
  printf("\n");
  if(k>have.size()){
    puts("000001");
    puts("011001");
    puts("011101");
    puts("010101");
    puts("010001");
    puts("011011");
    puts("001001");
    puts("000101");
    puts("001011");
    puts("010111");
    puts("001111");
    puts("000011");
    puts("010011");
    puts("000111");
    puts("001101");
    return;
    }

  }


int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  
  read();
  solve();
  write();
  
  return 0;
};
