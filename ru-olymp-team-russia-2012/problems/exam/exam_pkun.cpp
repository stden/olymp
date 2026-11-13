#include <iostream>
#include <fstream>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cmath>
#include <cassert>
#include <ctime>
#include <algorithm>
#include <queue>
#include <memory.h>
#include <stack>
#define mp make_pair
#define pb push_back                     
#define setval(a,v) memset(a,v,sizeof(a))

#if ( _WIN32 || __WIN32__ )
    #define LLD "%I64d"
#else
    #define LLD "%lld"
#endif

using namespace std;

typedef long long ll;
typedef long double ld;

const int MAXN = 110000;

ll a[MAXN];
ll cnt[MAXN];
ll total;
int n;

void solve(){
  total = 0;
  scanf("%d",&n);
  a[0] = a[n+1] = 1LL<<60;
  for (int i = 1; i <= n; i++){
    scanf(LLD,&a[i]);
  	if (i != 1) total += max(0LL,a[i-1] - a[i]);
  }
  n += 2;

  total -= a[1];
  if (total <= 0){
  	printf("0\n");
  	return;
  }

  vector<pair<ll,int> > s;

  for (int i = 0; i < n; i++){
  	while (i && s.back().first < a[i]){
  		int curv = s.back().first;
  		s.pop_back();
  		assert(!s.empty());
      	cnt[i - s.back().second - 1] += min(s.back().first, a[i]) - curv;
	}
	s.push_back(mp(a[i],i));
  }

  ll ans = 0;

  for (int i = 0; i < n; i++){
  	ans += min(cnt[i],total) * i;
	total -= min(cnt[i],total);
	cnt[i] = 0;
  }

  cout << ans << endl;      

}


int main(){
  freopen("exam.in","r",stdin);
  freopen("exam.out","w",stdout);

  int t;
  scanf("%d",&t);

  while (t --> 0)
  	solve();

  return 0;
}