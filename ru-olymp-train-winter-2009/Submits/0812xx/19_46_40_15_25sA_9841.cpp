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
#define task "cube"

int a[1<<11];
int t[1<<11];
int n;

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
  cin>>n;
  forn(i,1<<n)
    cin>>a[i];
  t[0]=a[0];
  forn(i,1<<n)
    forn(j,n)
      if(!(i & (1<<j)))
        t[ i | (1<<j)]=max(t[i | (1<<j)],t[i]+a[i | (1<<j)]);
  cout<<t[(1<<n)-1]<<endl;  
  return 0;
};
