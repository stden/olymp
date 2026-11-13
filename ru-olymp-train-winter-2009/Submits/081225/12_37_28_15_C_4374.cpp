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
#define task "dynarray"

const int nmax=200000;

struct zap{
  int t,u,v,p;
  };

zap q[nmax];
int a[2*nmax];
int b[nmax];
int c[2*nmax];
int n,m;


int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
   
  scanf("%d%d",&n,&m);
  forn(i,n){
    scanf("%d",&b[i]);
    a[i]=1;
    }
  forn(i,m){
    zap x;
    scanf("%d%d%d",&x.t,&x.u,&x.v);
    if(x.t==3)scanf("%d",&x.p);
    q[i]=x;
    }
  forn(i,m)
    if(q[i].t==2){
      int now=q[i].u;
      forn(j,n)
        if(a[j]>=now){
	a[j]++;
	break;
	}else now-=a[j];
      }
  int now=0;
  forn(i,n+m)c[i]=-1;
  forn(i,n){
    c[now]=b[i];
    now+=a[i];
    }
  forn(i,n+m)
    if(c[i]==-1)a[i]=0;else a[i]=1;
  
  forn(i,m){
    if(q[i].t==1){
      now=q[i].u;
      forn(j,n+m){
        if(now==1 && a[j]>0){
	c[j]=q[i].v;
	break;
	};
        now-=a[j];
        }
      };
    if(q[i].t==2){
      now=q[i].u;
      forn(j,n+m){
        if(now==0){
	c[j]=q[i].v;
	a[j]=1;
	break;
	}
        now-=a[j];
        }
      };
    if(q[i].t==3){
      int l=q[i].u,r=q[i].v;
      now=0;
      int res=0;
      forn(j,n+m){
        now+=a[j];
        if(now>r)break;
        if(now>=l && c[j]<=q[i].p && a[j]>0){
	res++;
	}
        }
      printf("%d\n",res);
      }
    };
    
  return 0;
};
