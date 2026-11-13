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
#define task "linear"

const int nmax=30;
const real eps=1e-8;


real a[nmax][nmax];
real p[nmax];
real x[nmax];
real x1[nmax];
int n;
int r[nmax];

real abs(real a){
  if(a>eps)return a;else return -a;
  }

void read(){
  cin>>n;
  forn(i,n){
    forn(j,n)
      cin>>a[i][j];
    cin>>p[i];
    }
}

void solve(){
  forn(i,n)r[i]=i;
  forn(i,n){
    int x=i,y=i;
    for(int j=i;j<n;j++)
      for(int k=i;k<n;k++)
        if(abs(a[j][k])>abs(a[x][y])+eps)x=j,y=k;
    forn(j,n)
      swap(a[i][j],a[x][j]);
    swap(p[i],p[x]);
    forn(j,n)
      swap(a[j][i],a[j][y]);
    swap(r[i],r[y]);
    if(abs(a[i][i])<eps){
      for(int k=i;k<n;k++){
        bool imp=true;
        forn(j,n)
	if(abs(a[k][j])>eps)imp=false;
        if(imp && abs(p[k])>eps){
	puts("impossible\n");
	exit(0);
	}
        }     
      puts("infinity\n");
      exit(0);
      }
    for(int j=i+1;j<n;j++){
      real d=a[j][i]/a[i][i];
      forn(k,n)
        a[j][k]-=a[i][k]*d;
      p[j]-=p[i]*d;
      }
    };
  x[n-1]=p[n-1]/a[n-1][n-1];
  for(int i=n-2;i>=0;i--){
    x[i]=p[i];
    for(int j=i+1;j<n;j++)
      x[i]-=a[i][j]*x[j];
    x[i]/=a[i][i];
    }
  }

void write(){
  forn(i,n)x1[i]=x[i];
  forn(i,n)x[r[i]]=x1[i];
  printf("single\n");
  forn(i,n)
    printf("%0.6lf ",(double)x[i]);
};  

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  
  read();
  solve();
  write();
  
  return 0;
};
