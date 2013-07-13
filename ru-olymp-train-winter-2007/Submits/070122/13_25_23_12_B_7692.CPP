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

#define MAXN 200
#define INF int(1e9)

int n;
int r[MAXN], c[MAXN], a[MAXN], w[MAXN], sumw[MAXN];
VI e[MAXN];
int dp[MAXN][510], dp1[MAXN][510];

int get(int x, int w) {
	if (w < 0 || w > sumw[x]) return 0;
	return dp[x][w];
}

void doit(int x) {
	REPS(i, e[x]) doit(e[x][i]);
	int m = SZ(e[x]);
	ZERO(dp1);
	REPN(i, m) {
		REPN(j, 502) {
			dp1[i + 1][j] = dp1[i][j];
			if (j > 0) dp1[i + 1][j] >?= dp1[i][j - 1];
			REPN(k, min(j, 501) + 1) {
				dp1[i + 1][j] >?= dp1[i][j - k] + dp[e[x][i]][k];
			}
		}
	}
	REPN(j, 502) {
		if (j >= w[x]) dp[x][j] >?= dp1[m][j - w[x]] + a[x];
		if (dp1[m][j] + a[x] > c[x]) dp[x][j] >?= dp1[m][j] + a[x];
	}
}

int main() {
	freopen("system.in", "rt", stdin);
	freopen("system.out", "wt", stdout);
	scanf("%d", &n);
	REPN(i, n) {
		scanf("%d%d%d%d", &r[i], &c[i], &a[i], &w[i]);
		r[i]--;
		if (r[i] != -1) e[r[i]].PB(i);
	}
	ZERO(dp);
	doit(0);
	REPN(i, 502) {
		if (dp[0][i] > 0) {
			printf("%d\n", i);
			return 0;
		}
	}
	return 0;
}
