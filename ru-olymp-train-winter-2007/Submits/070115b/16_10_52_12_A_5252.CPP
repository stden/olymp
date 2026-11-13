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

#define MAXN 30000

int n, m;
VI e[MAXN];
VB can[MAXN];
bool was[MAXN];
VI q;
int comp[MAXN];
int ncomp;
VPII reb;

void dfs1(int x) {
	was[x] = true;
	REPS(i, e[x]) if (!was[e[x][i]]) {
		can[x][i] = false;
		dfs1(e[x][i]);
	}
	q.PB(x);
}

void dfs2(int x) {
	comp[x] = ncomp;
	REPS(i, e[x]) if (can[x][i] && !comp[e[x][i]]) {
		dfs2(e[x][i]);
	}
}

int main() {
	freopen("bridges.in", "rt", stdin);
	freopen("bridges.out", "wt", stdout);
	scanf("%d%d", &n, &m);
	REPN(i, m) {
		int a, b;
		scanf("%d%d", &a, &b);
		a--, b--;
		e[a].PB(b);
		e[b].PB(a);
		can[a].PB(true);
		can[b].PB(true);
		reb.PB(MP(a, b));
	}
	ZERO(was);
	REPN(i, n) if (!was[i]) dfs1(i);
	ZERO(comp);
	REPSD(i, q) if (!comp[q[i]]) {
		ncomp++;
		dfs2(q[i]);
	}
	VI ans;
	REPS(i, reb) if (comp[reb[i].F] != comp[reb[i].S]) ans.PB(i + 1);
	cout << SZ(ans) << "\n";
	REPS(i, ans) cout << ans[i] << "\n";
	return 0;
}
