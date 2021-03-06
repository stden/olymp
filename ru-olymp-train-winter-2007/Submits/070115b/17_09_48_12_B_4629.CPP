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

#define MAXN 1000

LL n, m, bound;
VPII e;
LL cc[MAXN][MAXN], ff[MAXN][MAXN];
bool was[MAXN];
VI w;

bool dfs(int x) {
	if (was[x]) return false;
	was[x] = true;
	if (x == n - 1) return true;
	REPN(i, n) if (cc[x][i] - ff[x][i] >= bound && dfs(i)) {
		ff[x][i] += bound;
		ff[i][x] -= bound;
		return true;
	}
	return false;
}

void dfs1(int x) {
	was[x] = true;
	REPN(i, n) if (cc[x][i] - ff[x][i] > 0 && !was[i]) dfs1(i);
}

int main() {
	freopen("cut.in", "rt", stdin);
	freopen("cut.out", "wt", stdout);
	cin >> n >> m;
	ZERO(cc), ZERO(ff);
	REPN(i, n) {
		int a, b, c;
		cin >> a >> b >> c;
		a--, b--;
		cc[a][b] += c;
		cc[b][a] += c;
		e.PB(MP(a, b));
		w.PB(c);
	}
	bound = LL(1e9);
	LL flow = 0;
	for (;;) {
		if (!bound) break;
		ZERO(was);
		if (dfs(0)) flow += bound;
		else bound /= 2;
	}
	ZERO(was);
	dfs1(0);
	VI ans;
	LL check = 0;
	REPS(i, e) if (was[e[i].F] != was[e[i].S]) ans.PB(i + 1), check += w[i];
	cout << SZ(ans) << " " << flow << "\n";
	REPS(i, ans) cout << ans[i] << " ";
	cout << "\n";
	return 0;
}
