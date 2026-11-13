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

#define MAXN 200

int n, m, p, ncomp, ncc;
VI e[MAXN];
VB c[MAXN];
VI q;
int comp[MAXN];
bool was[MAXN];
int nv[MAXN], ne[MAXN];

void dfs1(int x) {
	was[x] = true;
	REPS(i, e[x]) if (!was[e[x][i]]) {
		c[x][i] = false;
		dfs1(e[x][i]);
	}
	q.PB(x);
}

void dfs2(int x) {
	comp[x] = ncomp;
	REPS(i, e[x]) if (comp[e[x][i]] == -1 && c[x][i]) dfs2(e[x][i]);
}

int main() {
	freopen("optimum.in", "rt", stdin);
	freopen("optimum.out", "wt", stdout);
	scanf("%d%d%d", &n, &m, &p);
	REPN(i, m) {
		int a, b;
		scanf("%d%d", &a, &b);
		a--, b--;
		e[a].PB(b);
		e[b].PB(a);
		c[a].PB(true);
		c[b].PB(true);
	}
	ZERO(was);
	ncc = 0;
	REPN(i, n) if (!was[i]) {
		dfs1(i);
		ncc++;
	}
	if (ncc > 1) {
		printf("0\n");
		return 0;
	}
	ncomp = 0;
	memset(comp, 255, sizeof(comp));
	REPSD(i, q) if (comp[q[i]] == -1) {
		dfs2(q[i]);
		ncomp++;
	}
	ZERO(nv);
	ZERO(ne);
	REPN(i, n) nv[comp[i]]++;
	REPN(i, n) REPS(j, e[i]) if (comp[i] == comp[e[i][j]]) ne[comp[i]]++;
	int ans = 1;
	REPN(i, ncomp) {
		ne[i] /= 2;
		if (nv[i] == 1) continue;
		ans = (ans * ne[i]) % p;
	}
	printf("%d\n", ans);
	return 0;
}
