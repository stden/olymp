#include <algorithm>
#include <fstream>
#include <iostream>
#include <map>
#include <queue>
#include <set>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

using namespace std;

typedef long long LL;
typedef long double LD;
typedef vector<int> VI;
typedef vector<VI> VVI;
typedef vector<bool> VB;
typedef vector<string> VS;
typedef vector<LL> VLL;
typedef pair<int, int> PII;
typedef vector<PII> VPII;

int _stklen = 30 << 20;

#define F first
#define S second
#define PB push_back
#define MP make_pair

#define ALL(x) (x).begin(), (x).end()
#define SORT(x) sort(ALL(x))
#define SZ(x) (x).size()
#define VAR(x, y) typeof(y) x = (y)
#define ZERO(x) memset(x, 0, sizeof(x))

#define REPN(i, x) for (int i = 0; i < int(x); i++)
#define REPND(i, x) for (int i = int(x) - 1; i >= 0; i--)
#define REPS(i, x) REPN(i, SZ(x))
#define REPSD(i, x) REPND(i, SZ(x))
#define FOR(i, x, y) for (int i = int(x); i <= int(y); i++)
#define FORD(i, x, y) for (int i = int(x); i >= int(y); i--)
#define FORIT(i, x) for (VAR(i, (x).begin()); i != (x).end(); i++)
#define FORITD(i, x) for (VAR(i, (x).rbegin()); i != (x).rend(); i++)

template<class T> T sqr(T x) {
	return x * x;
}

#define MAXN 100000

int n, m, gtime;
int deg[MAXN];
VI e[MAXN];
VI vis;
VI e1[MAXN];
bool was[MAXN];
int enter[MAXN], high[MAXN];

bool dfs(int x, bool root, int p) {
	was[x] = true;
	enter[x] = gtime++;
	high[x] = enter[x];
	VI tmp;
	REPS(i, e[x]) tmp.PB(e[x][i]);
	REPS(i, e1[x]) tmp.PB(e1[x][i]);
	REPS(i, tmp) {
		if (!was[tmp[i]]) {
			bool temp = dfs(tmp[i], false, x);
			if (!temp) return false;
			high[x] <?= high[tmp[i]];
		}
		else if (tmp[i] != p) high[x] <?= enter[tmp[i]];
	}
	return root || high[x] < enter[x];
}

int main() {
	srand(0xdead);
	freopen("biconn.in", "rt", stdin);
	freopen("biconn.out", "wt", stdout);
	scanf("%d", &n);
	ZERO(deg);
	REPN(i, n - 1) {
		int a, b;
		scanf("%d%d", &a, &b);
		a--, b--;
		e[a].PB(b), e[b].PB(a);
		deg[a]++, deg[b]++;
	}
	REPN(i, n) if (deg[i] == 1) vis.PB(i);
	m = SZ(vis);
	for (;;) {
		REPN(i, m) {
			int j = rand() % (i + 1);
			swap(vis[i], vis[j]);
		}
		REPN(i, n) e1[i].clear();
		REPN(i, m / 2) e1[vis[2 * i]].PB(vis[2 * i + 1]), e1[vis[2 * i + 1]].PB(vis[2 * i]);
		if (m % 2) e1[vis[m - 2]].PB(vis[m - 1]), e1[vis[m - 1]].PB(vis[m - 2]);
		ZERO(was);
		bool ok = true;
                gtime = 0;
		REPN(i, n) if (!was[i]) {
			if (!dfs(i, true, -1)) {
				ok = false;
				break;
			}
		}
		if (ok) break;
	}
	printf("%d\n", m - m / 2);
	REPN(i, n) REPS(j, e1[i]) if (i < e1[i][j]) printf("%d %d\n", i + 1, e1[i][j] + 1);
	return 0;
}
