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

#define MAXM 500
#define MAXN 500
#define INF int(1e9)

int m, n;
int a[MAXM + 1][MAXN], a1[MAXM + 1][MAXN];
int b[MAXM + 1], b1[MAXM + 1];
int c[MAXN];
int cap[MAXM + 3][MAXM + 3];
int cost[MAXM + 3][MAXM + 3];
int flow[MAXM + 3][MAXM + 3];
int ind[MAXM + 3][MAXM + 3];
int phi[MAXM + 3], dist[MAXM + 3], delta[MAXM + 3], prev[MAXM + 3];
bool mark[MAXM + 3];
int x[MAXN];

void relax(int u, int v, int w) {
	if (dist[u] + w < dist[v]) {
		dist[v] = dist[u] + w;
		prev[v] = u;
		delta[v] = min(delta[u], cap[u][v] - flow[u][v]);
	}	
}

int main() {
	freopen("radio.in", "rt", stdin);
	freopen("radio.out", "wt", stdout);
	scanf("%d%d", &m, &n);
	REPN(i, m) REPN(j, n) scanf("%d", &a[i][j]);
	REPN(j, n) a[m][j] = 0;
	REPN(i, m) scanf("%d", &b[i]);		
	b[m] = 0;
	REPN(i, n) scanf("%d", &c[i]);
	REPN(i, n) a1[0][i] = a[0][i];
	b1[0] = b[0];
	FOR(i, 1, m) REPN(j, n) a1[i][j] = a[i][j] - a[i - 1][j];
	FOR(i, 1, m) b1[i] = b[i] - b[i - 1];
	ZERO(cap);
	ZERO(cost);
	ZERO(flow);
	ZERO(ind);
	REPN(i, n) {
		int p, q;
		REPN(j, m + 1) {
			if (a1[j][i] == -1) p = j;
			if (a1[j][i] == +1) q = j;
		}
		p++, q++;
		if (!cap[p][q]) {
			cap[p][q] = INF;
			cost[p][q] = c[i];
		}
		else cost[p][q] <?= c[i];
		if (cost[p][q] == c[i]) ind[p][q] = i + 1;
		cost[q][p] = -cost[p][q];
	}
	FOR(i, 1, m + 1) {
		if (b1[i - 1] > 0) cap[i][m + 2] = b1[i - 1];
		else cap[0][i] = -b1[i - 1];
	}
	ZERO(phi);
	for (;;) {
		dist[0] = 0;
		FOR(i, 1, m + 2) dist[i] = INF;
		delta[0] = INF;
		ZERO(mark);
		for (;;) {
			int cnode = -1;
			REPN(j, m + 3) if (!mark[j] && (cnode == -1 || dist[j] < dist[cnode])) cnode = j;
			if (cnode == m + 2) break;
			mark[cnode] = true;
			REPN(j, m + 3) if (cap[cnode][j] > flow[cnode][j])
				relax(cnode, j, cost[cnode][j] + phi[cnode] - phi[j]);
		}
		if (dist[m + 2] == INF) break;
		REPN(i, m + 3) phi[i] += min(dist[i], dist[m + 2]);
		int cnode = m + 2;
		while (cnode != 0) {
			flow[prev[cnode]][cnode] += delta[m + 2];
			flow[cnode][prev[cnode]] -= delta[m + 2];
			cnode = prev[cnode];
		}
	}
	FOR(i, 1, m + 1) if (flow[0][i] != cap[0][i] || flow[i][m + 2] != cap[i][m + 2]) {
		printf("-1\n");
		return 0;
	}
	ZERO(x);
	FOR(i, 1, m + 1) FOR(j, 1, m + 1) if (ind[i][j]) x[ind[i][j] - 1] = flow[i][j];
	LL ans = 0;
	REPN(i, n) ans += LL(c[i]) * x[i];
	printf("%Ld\n", ans);
	REPN(i, n) printf("%d ", x[i]);
	printf("\n");
	return 0;
}
