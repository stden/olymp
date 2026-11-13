#include<iostream>
#include<cmath>

using namespace std;

typedef long long int64;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define task "digitsum"

int64 calc(int64 x){
  return (int64)((long double)sqrt(2)*x);
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);

  int n;
  cin>>n;
  forn(i,n){
    int64 l,r;
    scanf("%lld%lld",&l,&r);
    printf("%lld\n",calc(r)-calc(l-1));
    }

  return 0;
};
