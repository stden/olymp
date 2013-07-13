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
#define task "sum"
#define list botva

const int nmax=100000;
const int kmax=6;

struct list{
  int a[kmax];
  int k;
  list(){
    forn(i,kmax)a[i]=0;
    a[0]=1;
    k=0;
    };
  };
  
int n,k,m;
int lmax=1;
list tree[4*nmax];

void build(){
  while(lmax<n)lmax*=2;
  forn(i,lmax){
    tree[i+lmax]=list();
    if(i>=n)tree[i+lmax].a[0]=0;
    }
  ford(i,lmax){
    tree[i]=list();
    tree[i].a[0]=tree[i*2].a[0]+tree[i*2+1].a[0];
    }    
  }
  
int sum(int v){
  int res=0;
  forn(i,k)
    res+=tree[v].a[i]*i;
  return res;
  }

void calc(int v,int d){
  d%=k;
  int b[kmax];
  forn(i,k)
    b[(i+d)%k]=tree[v].a[i];
  forn(i,k)
    tree[v].a[i]=b[i];
  }

void recalc(int v){
  if(v>=lmax)return;
  forn(i,k)
    tree[v].a[i]=tree[v*2].a[i]+tree[v*2+1].a[i];
  }

void push(int v){
  if(!tree[v].k)return;
  int s1=v*2,s2=v*2+1;
  if(s1<lmax*2){
    tree[s1].k+=tree[v].k;
    calc(s1,tree[v].k);
    }
  if(s2<lmax*2){
    tree[s2].k+=tree[v].k;
    calc(s2,tree[v].k);
    }
  tree[v].k=0;
  }

void update(int v,int l,int r,int l1,int r1){
  push(v);
  if(r1<l || l1>r)return;
  if(l1<=l && r<=r1){
    tree[v].k++;
    calc(v,1);
    return;
    }
  int m=(l+r)/2;
  update(v*2,l,m,l1,r1);
  update(v*2+1,m+1,r,l1,r1);
  recalc(v);
  }
  
int calc(int v,int l,int r,int l1,int r1){
  push(v);
  if(r1<l || l1>r)return 0;
  if(l1<=l && r<=r1)return sum(v);
  int m=(l+r)/2;
  return calc(v*2,l,m,l1,r1)+calc(v*2+1,m+1,r,l1,r1);
  } 

void print_tree(){
  for(int i=1;i<lmax*2;i++){
    //push(i);
    printf("вершина %d :\n",i);
    forn(j,k)
      printf("	комнат с %d людьми ровно %d\n",j,tree[i].a[j]);
    printf("	при этом к = %d\n",tree[i].k); 
    };
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);

  scanf("%d%d%d",&n,&k,&m);
  build();
  
  //print_tree();
  
  forn(i,m){
    int c,l,r;
    scanf("%d%d%d",&c,&l,&r);
    if(c==1)update(1,1,lmax,l,r);
    if(c==2){
      int res=calc(1,1,lmax,l,r);
      printf("%d\n",res);
      }
    //print_tree();
    }
  return 0;
};
