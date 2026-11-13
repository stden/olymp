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

#define MAXN 30
#define MAXT 50

int n, m, p, source, nr;
int g[MAXN][MAXN], ways[MAXN][MAXN];
int ra[MAXT], rb[MAXT];
int d[MAXN];
int answer[MAXN], answer1[MAXN];
int mx[MAXN][MAXN], tmp[MAXN][MAXN];

void mul(int ma[MAXN][MAXN], int mb[MAXN][MAXN]) {
	ZERO(tmp);
	REPN(i, m) REPN(j, m) REPN(k, m)
		tmp[i][j] = (tmp[i][j] + LL(ma[i][k]) * mb[k][j]) % p;
	REPN(i, m) REPN(j, m) ma[i][j] = tmp[i][j];
}

void power(int my[MAXN][MAXN], int z) {
	ZERO(mx);
	REPN(i, m) mx[i][i] = 1;
	while (z) if (z % 2) {
		mul(mx, my);
		z--;
	}
	else {
		mul(my, my);
		z /= 2;
	}
	REPN(i, m) REPN(j, m) my[i][j] = mx[i][j];
}

int main() {
	freopen("restore.in", "rt", stdin);
	freopen("restore.out", "wt", stdout);
	scanf("%d%d%d", &n, &m, &p);
	if (!p) {
		printf("%d\n", 0);
		return 0;
	}
	ZERO(g);
	REPN(i, m) {
		int a, b;
		scanf("%d%d", &a, &b);
		a--, b--;
		g[a][b]++;
		g[b][a]++;
	}
	scanf("%d%d", &source, &nr);
	source--;
	REPN(i, nr) scanf("%d%d", &ra[i], &rb[i]);
	memset(d, 63, sizeof(d));
	d[source] = 0;
	queue<int> q;
	q.push(source);
	while (!q.empty()) {
		int cnode = q.front();
		q.pop();
		REPN(i, n) if (g[cnode][i] && d[cnode] + 1 < d[i]) {
			d[i] = d[cnode] + 1;
			q.push(i);
		}
	}
	REPN(i, nr) {
		bool found = false;
		REPN(j, n) if (d[j] == ra[i]) {
			found = true;
			break;
		}
		if (!found) {
			printf("%d\n", 0);
			return 0;
		}
		if (i && abs(ra[i] - ra[i - 1]) > 1) {
			printf("%d\n", 0);
			return 0;
		}
	}
	ZERO(answer);
	REPN(i, n) if (d[i] == ra[0]) answer[i] = 1;
	REPN(i, nr) {
		VI layer;
		REPN(j, n) if (d[j] == ra[i]) layer.PB(j);
		m = SZ(layer);
		ZERO(ways);
		REPN(j, m) REPN(k, m) ways[j][k] = g[layer[j]][layer[k]] % p;
		power(ways, rb[i] - 1);
		ZERO(answer1);
		REPN(j, m) REPN(k, m)
			answer1[layer[k]] = (answer1[layer[k]] + LL(answer[layer[j]]) * ways[j][k]) % p;
		REPN(j, n) answer[j] = answer1[j];
		if (i != nr - 1) {
			ZERO(answer1);
			REPN(j, n) REPN(k, n)
				if (g[j][k] && d[j] == ra[i] && d[k] == ra[i + 1]) {
					answer1[k] += answer[j];
					answer1[k] %= p;
				}
			REPN(j, n) answer[j] = answer1[j];
		}
	}
	int sum = 0;
	REPN(i, n) {
		sum += answer[i];
		sum %= p;
	}
	printf("%d\n", sum);
	return 0;
}
