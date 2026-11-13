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

#define MAXN 100000

int n, m, ncomp, ncc;
VI e[MAXN];
bool was[MAXN], is_source[MAXN], is_sink[MAXN];
VI q;
VI et[MAXN];
int comp[MAXN], smb[MAXN], in_deg[MAXN], out_deg[MAXN], cc[MAXN], some_source[MAXN], some_sink[MAXN];
VI cond[MAXN];
VI un_cond[MAXN];
VI sources, sinks;
VPII ans;

void dfs1(int x) {
	was[x] = true;
	REPS(i, e[x]) if (!was[e[x][i]]) dfs1(e[x][i]);
	q.PB(x);
}

void dfs2(int x) {
	comp[x] = ncomp;
	REPS(i, et[x]) if (comp[et[x][i]] == -1) dfs2(et[x][i]);
}

void dfs3(int x) {
	cc[x] = ncc;
	REPS(i, un_cond[x]) if (cc[un_cond[x][i]] == -1) dfs3(un_cond[x][i]);
}

void add_sink_source(int sink, int source) {
	ans.PB(MP(smb[sink], smb[source]));
	out_deg[sink]++;
	in_deg[source]++;
}

bool compare1(int x, int y) {
	return out_deg[y] < out_deg[x];
}

bool compare2(int x, int y) {
	return in_deg[y] < in_deg[x];
}

int main() {
	freopen("republic.in", "rt", stdin);
	freopen("republic.out", "wt", stdout);
	scanf("%d%d", &n, &m);
	REPN(i, m) {
		int a, b;
		scanf("%d%d", &a, &b);
		a--, b--;
		e[a].PB(b);
	}
	ZERO(was);
	REPN(i, n) if (!was[i]) dfs1(i);
	REPN(i, n) REPS(j, e[i]) et[e[i][j]].PB(i);
	ncomp = 0;
	memset(comp, 255, sizeof(comp));
	REPSD(i, q) if (comp[q[i]] == -1) {
		dfs2(q[i]);
		ncomp++;
	}
	REPN(i, n) smb[comp[i]] = i + 1;
	REPN(i, n) REPS(j, e[i]) if (comp[i] != comp[e[i][j]]) cond[comp[i]].PB(comp[e[i][j]]);
	if (ncomp == 1) {
		printf("0\n");
		return 0;
	}
	ZERO(in_deg);
	ZERO(out_deg);
	REPN(i, ncomp) REPS(j, cond[i]) {
		out_deg[i]++;
		in_deg[cond[i][j]]++;
	}
	REPN(i, ncomp) REPS(j, cond[i]) {
		un_cond[i].PB(cond[i][j]);
		un_cond[cond[i][j]].PB(i);
	}
	ncc = 0;
	memset(cc, 255, sizeof(cc));
	REPN(i, ncomp) if (cc[i] == -1) {
		dfs3(i);
		ncc++;
	}
	ZERO(is_source);
	ZERO(is_sink);
	REPN(i, ncomp) {
		if (!in_deg[i]) {
			is_source[i] = true;
			some_source[cc[i]] = i;
		}
		if (!out_deg[i]) {
			is_sink[i] = true;
			some_sink[cc[i]] = i;
		}
	}
	if (ncc > 1) {
		REPN(i, ncc) add_sink_source(some_sink[i], some_source[(i + 1) % ncc]);
	}
	REPN(i, ncomp) {
		if (!in_deg[i]) sources.PB(i);
		if (!out_deg[i]) sinks.PB(i);
	}
	sort(ALL(sources), compare1);
	sort(ALL(sinks), compare2);
	REPN(i, min(SZ(sources), SZ(sinks))) {
		add_sink_source(sinks[i], sources[i]);
	}
	int some_source, some_sink;
	REPN(i, ncomp) if (is_source[i]) some_source = i;
	REPN(i, ncomp) if (is_sink[i]) some_sink = i;
	if (SZ(sources) > SZ(sinks)) {
		FOR(i, SZ(sinks), SZ(sources) - 1) {
			add_sink_source(some_sink, sources[i]);
		}
	}
	if (SZ(sinks) > SZ(sources)) {
		FOR(i, SZ(sources), SZ(sinks) - 1) {
			add_sink_source(sinks[i], some_source);
		}
	}
	printf("%d\n", SZ(ans));
	REPS(i, ans) printf("%d %d\n", ans[i].F, ans[i].S);
	return 0;
}
