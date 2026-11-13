#include<iostream>
#include<cmath>

using namespace std;

typedef long long int64;

#define forn(i,n) for(int i=0;i<(int)n;i++)
#define task "digitsum"

const long double ad=sqrt(2);
const long double eps=0.00000747;

int64 calc(int64 x){
  if(x==0)return 0;
  if(x==1)return 1;
  long double now=ad*x;
  int64 res=now;
  if(now-res<eps)res--;
  return res;
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
