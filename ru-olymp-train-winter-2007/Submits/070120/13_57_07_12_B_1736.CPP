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

#define MAXN 20
#define INF LL(3e17)

int n, m;
LL k;
int c[MAXN];
LL my[MAXN][MAXN], mx[MAXN][MAXN], tmp[MAXN][MAXN];

void mult(LL mx[MAXN][MAXN], LL my[MAXN][MAXN]) {
	REPN(i, n) REPN(j, n) {
		tmp[i][j] = -INF;
		REPN(k, n) tmp[i][j] >?= mx[i][k] + my[k][j];
		if (tmp[i][j] < 0) tmp[i][j] = -INF;
	}
	REPN(i, n) REPN(j, n) mx[i][j] = tmp[i][j];
}

int main() {
	freopen("maxsum.in", "rt", stdin);
	freopen("maxsum.out", "wt", stdout);
	scanf("%d%d%Ld", &n, &m, &k);
	REPN(i, n) scanf("%d", &c[i]);
	REPN(i, n) REPN(j, n) my[i][j] = -INF;
	REPN(i, m) {
		int u, v;
		scanf("%d%d", &u, &v);
		u--, v--;
		my[u][v] = c[v];
	}
	REPN(i, n) REPN(j, n) mx[i][j] = -INF;
	REPN(i, n) mx[i][i] = 0;
	while (k) if (k % 2) {
		mult(mx, my);
		k--;
	}
	else {
		mult(my, my);
		k /= 2;
	}
	LL ans = -INF;
	REPN(i, n) ans >?= mx[0][i];
	ans += c[0];
	printf("%Ld\n", ans);
	return 0;
}
