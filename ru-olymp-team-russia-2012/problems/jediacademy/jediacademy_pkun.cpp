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

vector<int> g[MAXN];
int type[MAXN];
int deg[MAXN];


int n,m,a,b;


set<pair<int,int> > s[2];

int solve(){
	int ans = n * b + a;
	int cur = 0;
	for (int i = 0; i < n; i++)
		for (int j = 0; j < (int)g[i].size(); j++)
			deg[g[i][j]]++;
	for (int i = 0; i < n; i++)
		s[type[i]].insert(mp(deg[i],i));

	for (int i = 0; i < n; i++){
		if (s[cur].empty() || s[cur].begin()->first != 0)
			cur = 1-cur, ans += a;
		int v = s[cur].begin()->second;
		s[cur].erase(s[cur].begin());

		for (int j = 0; j < (int)g[v].size(); j++){
			int to = g[v][j];
			s[type[to]].erase(mp(deg[to],to));
			--deg[to];
			s[type[to]].insert(mp(deg[to],to));
		}
	}
	return ans;
}


int main(){
  freopen("jediacademy.in","r",stdin);
  freopen("jediacademy.out","w",stdout);
            
  scanf("%d",&n);

  for (int i = 0; i < n; i++){
  	  int k;
  	  scanf("%d %d",&type[i],&k);
  	  --type[i];
  	  for (int j = 0; j < k; j++){
  	  	int a;
  	  	scanf("%d",&a);
  	  	g[a-1].pb(i);
  	  }
  }

  scanf("%d %d",&a,&b);

  int ans = solve();
  for (int i = 0; i < n; i++)
  	type[i] ^= 1;  
  int ans2 = solve();
  cout << min(ans,ans2) << endl;

      
  return 0;
}