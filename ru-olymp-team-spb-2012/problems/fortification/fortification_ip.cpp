#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <algorithm>
#include <cstring>
#include <string>
#include <vector>
#include <cassert>
#include <iostream>
#include <set>
#include <map>

using namespace std;

#ifdef WIN32
	#define LLD "%I64d"
#else
	#define LLD "%lld"
#endif

typedef long long ll;
typedef vector<int> vi;
typedef vector<vi> vvi;
typedef vector<bool> vb;
typedef vector<vb> vvb;
typedef vector<ll> vll;
typedef vector<vll> vvll;

#define eprintf(...) fprintf(stderr, __VA_ARGS__)
#define mp make_pair
#define pb push_back
#define sz(x) ((int)(x).size())
#define EPS (1e-9)
#define INF ((int)1e9)
#define TASKNAME "fortification"

vvi es;

const int MOD = (int)1e9 + 7;

const int maxn = (int)1e5;
int used[maxn];

int cnt, cntedge;
void dfs(int v) {
	used[v] = 1;
	cnt++, cntedge += sz(es[v]);
	for (int it = 0; it < sz(es[v]); it++) {
		int u = es[v][it];
		if (used[u])
			continue;
		dfs(u);
	}
}

int main() {
	freopen(TASKNAME".in", "r", stdin);
	freopen(TASKNAME".out", "w", stdout);

	int n, m;
	while (scanf("%d%d", &n, &m) >= 1) {
		es = vvi(n);
		for (int i = 0; i < m; i++) {
			int s, t;
			scanf("%d%d", &s, &t);
			s--, t--;
			es[s].pb(t), es[t].pb(s);
		}                       

		ll ans = 1;
		memset(used, 0, sizeof(used));
		for (int i = 0; i < n; i++) {
			if (used[i])
				continue;
			cntedge = 0, cnt = 0;
			dfs(i);
			cntedge /= 2;
			assert(cntedge <= cnt);
			if (cntedge == cnt)
				ans = (ll)ans * cnt % MOD;
		}

		printf(LLD"\n", ans);
		//break;
	}
	return 0;
}
