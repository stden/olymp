#include<iostream>
#include<cmath>

using namespace std;

typedef long long int64;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define task "digitsum"

int64 calc(double l,double r){
  r=r*sqrt(2);
  l=(l-1)*sqrt(2);
  int64 res=(int64)r-(int64)l;
  return res;
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);

  int n;
  cin>>n;
  forn(i,n){
    double l,r;
    scanf("%lf%lf",&l,&r);
    printf("%lld\n",calc(l,r));
    }

  return 0;
};
