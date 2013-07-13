#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <map>
#include <set>
#include <deque>

using namespace std;

typedef long long int64;
typedef vector<int> tlong;

#define forn(i, n) for (int i = 0; i < (int)(n); i++)
#define ford(i, n) for (int i = (int)(n) - 1; i >= 0; i--)
#define pb push_back
#define all(a) a.begin(), a.end()
#define task "btrees" 

int64 n,t;

const int base = 1000*1000*1000;

void norm(tlong &a){
  while (a.size() > 1 && a.back() == 0)
    a.pop_back();
}

void print(tlong a){
  printf ("%d", a.empty() ? 0 : a.back());
  for (int i=(int)a.size()-2; i>=0; --i)
    printf ("%09d", a[i]);
  printf("\n");
}

tlong sum(tlong a,tlong b){
  int carry = 0;
  for (size_t i=0; i<max(a.size(),b.size()) || carry; ++i) {
    if (i == a.size())a.push_back (0);
    a[i] += carry + (i < b.size() ? b[i] : 0);
    carry = a[i] >= base;
    if (carry)  a[i] -= base;
    }
  return a;
}

tlong mul(tlong a,tlong b){
  tlong c (a.size()+b.size());
  forn(i,a.size())
    for (int j=0, carry=0; j<(int)b.size() || carry; ++j) {
      int64 now=0;
      if(j<b.size())now=b[j];
      int64 cur = c[i+j] + a[i]*1ll*now + carry;
      c[i+j] = int (cur % base);
      carry = int (cur / base);
      }
  norm(c);
  return c;
}

const int nmax=505;
const int mmax=60;
const int hmax=30;

tlong dp[nmax][mmax][hmax];
int64 md[hmax];
int64 mn[hmax];
tlong res;
  
void calc(int n,int m,int h){
  res.clear();
  res.pb(0);
  if(m==1){
    if(h>1){
      for(int i=t;i<=min(md[h-1],2*t);i++)
        res=sum(res,dp[n][i][h-1]);
      }else{
      res=sum(res,dp[n][1][h-1]);
      }
    }else{
    for(int i=mn[h];i<n;i++)
      res=sum(res, mul(dp[n-i][m-1][h],dp[i][1][h]) );
    }
  dp[n][m][h]=res;
  }

int main(){
  freopen(task".in","rt",stdin);
  freopen(task".out","wt",stdout);
   
  //scanf("%lld%lld",&n,&t);
  n=490;
  t=2;
  if((t-1)>n){
    cout<<0<<endl;
    return 0;
    }
  if(t*(t-1)>n){
    cout<<1<<endl;
    return 0;
    }
  for(int i=t-1;i<2*t;i++)
    dp[i][1][0].pb(1);
  tlong res;
  int64 now=1;
  int hm=1;
  while(now<n){
    hm++;
    now*=t;
    }  
  md[0]=n;
  md[1]=n/(t-1);
  for(int i=2;i<=hm;i++)
    md[i]=md[i-1]/t;
  mn[0]=1;
  mn[1]=(t-1);
  for(int i=2;i<=hm;i++)
    mn[i]=mn[i-1]*t;
  for(int h=1;h<=hm;h++){
    for(int i=1;i<=min(2*t,md[h]);i++)
      for(int j=mn[h];j<=n;j++){
        calc(j,i,h);
        }
    res=sum(res,dp[n][1][h]);
    }
  print(res);
  return 0;
  };