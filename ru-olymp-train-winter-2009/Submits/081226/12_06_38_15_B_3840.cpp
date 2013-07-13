#define _CRT_SECURE_NO_DEPRECATE

#include <iostream>
#include <fstream> 
#include <sstream>
#include <string>
#include <vector>
#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <utility>
#include <cmath>
#include <ctime>                      
#include <cctype>
#include <map>
#include <set>
#include <list>
#include <queue>
#include <stack>
#include <deque>

using namespace std;

typedef long long int64;


#define forn(i, n) for (int i = 0; i < (int)(n); i++)
#define ford(i, n) for (int i = (int)(n) - 1; i >= 0; i--)
#define fs first
#define sc second
#define mp make_pair
#define pb push_back
#define pf push_forward
#define last(a) (int)a.size() - 1
#define all(a) a.begin(), a.end()
#define VI vector<int>
#define PII pair<int,int>
#define add botva
#define task "half"

int n,m;
pair<int,int> e[1000];
int res=1000;

vector<int> best;

void good_solve(){
  vector<int> a(n);
  forn(i,n)a[i]=(i>=(n/2) ? 1:0);
  while(1) {
    int now=0;
    forn(j,m){
      int u=e[j].fs,v=e[j].sc;
      if(a[u]!=a[v])now++;
      if(now>res)break;
      }
    if(now<res){
      res=now;
      best=a;
      }
    if(!next_permutation(all(a)))break;
    }
  forn(i,n)
    if(best[i]==best[0])cout<<i+1<<" ";
  cout<<endl;
  exit(0);
  }

void bad_solve(){
  vector<int> a(n);
  forn(i,n)a[i]=(i>=(n/2) ? 1:0);
  while(1) {
    int now=0;
    forn(j,m){
      int u=e[j].fs,v=e[j].sc;
      if(a[u]!=a[v])now++;
      if(now>res)break;
      }
    if(now<res){
      res=now;
      best=a;
      }
    forn(j,rand()%5+1)
      if(!next_permutation(all(a)))break;
    }
  forn(i,n)
    if(best[i]==best[0])cout<<i+1<<" ";
  cout<<endl;
  exit(0);
  }

int main(){
freopen(task".in","rt",stdin);
freopen(task".out","wt",stdout);
srand(time(0));
  n=24;
  m=0;
  forn(i,n)
    forn(j,i){
      e[m++]=mp(i,j);
      }
      //printf("%d %d\n",i+1,j+1);

/*  cin>>n>>m;
  forn(i,m){
    scanf("%d%d",&e[i].fs,&e[i].sc);
    e[i].fs--;
    e[i].sc--;
    }
  */int64 now=1;
  forn(i,n/2)now*=(i+n/2+1)/(i+1);
  cerr<<now*m<<endl;
  if(now*m<8*(1e8))good_solve();  
  bad_solve();
  return 0;
}