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

#define MAXK 5
#define MAXN 200

int n, k;
int f[MAXK][MAXN];
bool g[MAXN][MAXN];
bool was[MAXN];
bool was2[MAXN][MAXN];
VPII e[MAXN][MAXN];

void dfs1(int x) {
	was[x] = true;
	REPN(i, n) if (g[i][x] && !was[i]) dfs1(i);
}

void dfs2(int x, int y) {
	was2[x][y] = true;
	REPS(i, e[x][y]) if (!was2[e[x][y][i].F][e[x][y][i].S]) dfs2(e[x][y][i].F, e[x][y][i].S);
}

int main() {
	freopen("bit2.in", "rt", stdin);
	freopen("bit2.out", "wt", stdout);
	int nt;
	scanf("%d", &nt);
	REPN(it, nt) {
		scanf("%d%d", &n, &k);
		REPN(i, k) REPN(j, n) scanf("%d", &f[i][j]);
		ZERO(g);
		REPN(i, k) REPN(j, n) g[j][f[i][j]] = true;
		ZERO(was);
		dfs1(0);
		bool done = false;
		REPN(i, n) if (!was[i]) {
			printf("NO\n");
			done = true;
			break;
		}
		if (done) continue;
		ZERO(was2);
		REPN(i, n) REPN(j, n) e[i][j].clear();
		REPN(ii, k) REPN(i, n) REPN(j, n) e[f[ii][i]][f[ii][j]].PB(MP(i, j));
		REPN(i, n) if (!was2[i][i]) dfs2(i, i);
		REPN(i, n) {
			REPN(j, n) if (!was2[i][j]) {
				printf("NO\n");
				done = true;
				break;
			}
			if (done) break;
		}
		if (done) continue;
		printf("YES\n");
	}
	return 0;
}
