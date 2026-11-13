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
typedef long double LDBL;
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

#define MAXN 600

int m, n;
VI e1[MAXN], e2[MAXN];
int p1[MAXN], p2[MAXN], aaa[MAXN], b[MAXN], ans[MAXN];
char cache[MAXN][MAXN];
bool was[MAXN];

void dfs(VI e[MAXN], int x, int p, int pp[MAXN]) {
	pp[x] = p;
	REPS(i, e[x]) if (e[x][i] != p) dfs(e, e[x][i], x, pp);
}

bool dfs(bool g[MAXN][MAXN], int n, int m, int x) {
	if (was[x]) return false;
	was[x] = true;
	REPN(i, m) if (g[x][i] && (b[i] == -1 || dfs(g, n, m, b[i]))) {
		aaa[x] = i;
		b[i] = x;
		return true;
	}
	return false;
}

bool match(bool g[MAXN][MAXN], int n, int m) {
	memset(aaa, -1, sizeof(aaa));
	memset(b, -1, sizeof(b));
	int ans = 0;
	REPN(i, n) {
		ZERO(was);
		if (!dfs(g, n, m, i)) return false;
	}
	return true;
}

bool can(int a, int b) {
	if (cache[a][b] != 2) return cache[a][b];
	VI c1, c2;
	REPS(i, e1[a]) if (e1[a][i] != p1[a]) c1.PB(e1[a][i]);
	REPS(i, e2[b]) if (e2[b][i] != p2[b]) c2.PB(e2[b][i]);
	bool g[MAXN][MAXN];
	ZERO(g);
	REPS(i, c1) REPS(j, c2) g[i][j] = can(c1[i], c2[j]);
	return cache[a][b] = match(g, SZ(c1), SZ(c2));
}

void restore(int a, int b) {
	VI c1, c2;
	REPS(i, e1[a]) if (e1[a][i] != p1[a]) c1.PB(e1[a][i]);
	REPS(i, e2[b]) if (e2[b][i] != p2[b]) c2.PB(e2[b][i]);
	bool g[MAXN][MAXN];
	ZERO(g);
	REPS(i, c1) REPS(j, c2) g[i][j] = can(c1[i], c2[j]);
	match(g, SZ(c1), SZ(c2));
	int aa[MAXN];
	REPS(i, c1) aa[i] = aaa[i];
	REPS(i, c1) restore(c1[i], c2[aa[i]]);
	ans[a] = b + 1;
}

int main() {
	freopen("map.in", "rt", stdin);
	freopen("map.out", "wt", stdout);
	scanf("%d", &m);
	REPN(i, m - 1) {
		int a, b;
		scanf("%d%d", &a, &b);
		a--, b--;
		e1[a].PB(b);
		e1[b].PB(a);
	}
	scanf("%d", &n);
	REPN(i, n - 1) {
		int a, b;
		scanf("%d%d", &a, &b);
		a--, b--;
		e2[a].PB(b);
		e2[b].PB(a);
	}
	dfs(e2, 0, -1, p2);
	REPN(i, m) {
		dfs(e1, i, -1, p1);
		memset(cache, 2, sizeof(cache));
		REPN(j, n) if (can(i, j)) {
			cout << "YES\n";
			restore(i, j);
			REPN(i, m) cout << ans[i] << " ";
			cout << "\n";
			return 0;
		}
	}
	cout << "NO\n";
	return 0;
}
