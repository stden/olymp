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

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define ford(i,n) for(int i=(int)n-1;i>=0;i--)
#define all(a) a.begin(),a.end()
#define fs first
#define sc second
#define pb push_back
#define mp make_pair
#define task "linear"

const int nmax=30;

double a[nmax][nmax];
double p[nmax];
double x[nmax];
int n;

void read(){
  cin>>n;
  forn(i,n){
    forn(j,n)
      cin>>a[i][j];
    cin>>p[i];
    }
}

void solve(){
  forn(i,n){
    int id=i;
    for(int j=i+1;j<n;j++)
      if(a[j][i]>a[id][i])id=i;
    forn(j,n)
      swap(a[i][j],a[id][j]);
    swap(p[i],p[id]);
    if(a[i][i]==0){
      bool imp=true;
      forn(j,n)
        if(a[i][j]!=0)imp=false;
      if(imp && p[i]!=0)puts("impossible");else puts("infinity");
      exit(0);
      }
    for(int j=i+1;j<n;j++){
      double d=a[j][i]/a[i][i];
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
  printf("single\n");
  forn(i,n)
    printf("%0.4lf ",x[i]);
};  

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  
  read();
  solve();
  write();
  
  return 0;
};
