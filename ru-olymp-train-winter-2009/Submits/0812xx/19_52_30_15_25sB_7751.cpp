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
#define task "modsum"

int a[1<<11];
int t[1<<11];
int n;

int s[1<<11];

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  cin>>n;
  forn(i,n)
    cin>>a[i];
  forn(i,1<<n){
    s[i]=0;
    forn(j,n)
      if(i & (1<<j))s[i]+=a[j];
    }
    
  int64 res=0;
  forn(i,1<<n)
    forn(j,1<<n)
      if(!(i&j) && s[j]!=0)
        res+=s[i]%s[j];
  cout<<res<<endl;
  return 0;
};
