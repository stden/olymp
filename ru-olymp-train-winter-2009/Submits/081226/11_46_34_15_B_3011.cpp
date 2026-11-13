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
  while(next_permutation(all(a))) {
    int now=0;
    forn(j,m){
      int u=e[j].fs,v=e[j].sc;
      if(a[u]!=a[v])now++;
      }
    if(now<res){
      res=now;
      best=a;
      }
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
  cin>>n>>m;
  forn(i,m)
    scanf("%d%d",&e[i].fs,&e[i].sc);
    
  if((1<<n)*m < (1e7)) good_solve();  
    
  vector<int> b(n);
  forn(i,n)b[i]=i;
  random_shuffle(all(b));
  //forn(i,1<<n){
    
  
  
  return 0;
}