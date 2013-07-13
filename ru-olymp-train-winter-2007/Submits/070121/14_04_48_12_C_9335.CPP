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

#define MAXN 300000

int n, x[MAXN], y[MAXN];
VI ind;

LL abs(LL x) {
	if (x > 0) return x;
	return -x;
}

LL vect(LL x1, LL y1, LL x2, LL y2) {
	return x1 * y2 - x2 * y1;
}

void doit(VI &ind, LL s0) {
	int m = SZ(ind);
	if (m == 3) {
		printf("%d %d %d\n", ind[0] + 1, ind[1] + 1, ind[2] + 1);
		return;
	}
	int p, q;
	LL s1, s2;
	for (;;) {
		p = rand() % m;
		q = rand() % m;
		if (p == q) continue;
		int cur = p;
		s1 = 0;
		while (cur != q) {
			int nx = (cur + 1) % m;
			s1 += vect(x[ind[cur]], y[ind[cur]], x[ind[nx]], y[ind[nx]]);
			cur = nx;
		}
		s1 += vect(x[ind[q]], y[ind[q]], x[ind[p]], y[ind[p]]);
		s1 = abs(s1);
		s2 = 0;
		cur = q;
		while (cur != p) {
			int nx = (cur + 1) % m;
			s2 += vect(x[ind[cur]], y[ind[cur]], x[ind[nx]], y[ind[nx]]);
			cur = nx;
		}
		s2 += vect(x[ind[p]], y[ind[p]], x[ind[q]], y[ind[q]]);
		s2 = abs(s2);
		if (!s1) continue;
		if (!s2) continue;
		if (s1 + s2 != s0) continue;
		break;
	}
	VI ind1, ind2;
	int cur = p;
	while (cur != q) {
		ind1.PB(ind[cur]);
		cur = (cur + 1) % m;
	}
	ind1.PB(ind[q]);
	cur = q;
	while (cur != p) {
		ind2.PB(ind[cur]);
		cur = (cur + 1) % m;
	}
	ind2.PB(ind[p]);
	doit(ind1, s1);
	doit(ind2, s2);
}

int main() {
	srand(0xdead);
	freopen("tri.in", "rt", stdin);
	freopen("tri.out", "wt", stdout);
	scanf("%d", &n);
	REPN(i, n) scanf("%d%d", &x[i], &y[i]);
	REPN(i, n) ind.PB(i);
	LL s = 0;
	REPN(i, n) s += vect(x[i], y[i], x[(i + 1) % n], y[(i + 1) % n]);
	doit(ind, abs(s));
	return 0;
}
