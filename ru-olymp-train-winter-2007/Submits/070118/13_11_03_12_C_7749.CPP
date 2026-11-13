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

#define MAXD 150
#define MAXM 300
#define MAXK 26
#define BASE 10000
#define LGBASE 4

typedef int Long[MAXD];

int k, n, m;
string w;
int dka[MAXM + 1][MAXK];
int suf[MAXM + 1];
bool done[MAXM + 1][MAXM + 1];
Long cache[MAXM + 1][MAXM + 1];
Long s, s1;

void lcopy(Long &a, const Long &b) {
	FOR(i, 0, b[0]) a[i] = b[i];
}

void ladd(Long &a, const Long &b) {
	a[0] >?= b[0];
	int rem = 0;
	FOR(i, 1, a[0]) {
		int tmp = a[i] + b[i] + rem;
		a[i] = tmp % BASE;
		rem = tmp / BASE;
	}
	while (rem) {
		a[++a[0]] = rem % BASE;
		rem /= BASE;
	}
	while (a[0] && !a[a[0]]) a[0]--;
}

void linc(Long &a, int b) {
	if (!a[0]) a[0] = 1;
	a[1] += b;
	int rem = 0;
	FOR(i, 1, a[0]) {
		int tmp = a[i] + rem;
		a[i] = tmp % BASE;
		rem = tmp / BASE;
	}
	while (rem) {
		a[++a[0]] = rem % BASE;
		rem /= BASE;
	}
	while (a[0] && !a[a[0]]) a[0]--;
}

void calc(int state1, int state2) {
	if (done[state1][state2]) return;
	done[state1][state2] = true;
	if (state1 == state2) {
		ZERO(cache[state1][state2]);
		return;
	}
	calc(state1 + 1, state2);
	lcopy(cache[state1][state2], cache[state1 + 1][state2]);
	REPN(i, k) if (w[state1] - 'a' != i) {
		calc(dka[state1][i], state1);
		ladd(cache[state1][state2], cache[dka[state1][i]][state1]);
	}
	linc(cache[state1][state2], 1);
}

void lprint(const Long &a) {
	printf("%d", a[a[0]]);
	FORD(i, a[0] - 1, 1) printf("%0*d", LGBASE, a[i]);
}

void lmul(Long &a, int b) {
	LL rem = 0;
	FOR(i, 1, a[0]) {
		LL tmp = LL(a[i]) * b + rem;
		a[i] = tmp % BASE;
		rem = tmp / BASE;
	}
	while (rem) {
		a[++a[0]] = rem % BASE;
		rem /= BASE;
	}
	while (a[0] && !a[a[0]]) a[0]--;
}

int main() {
	freopen("wordgame.in", "rt", stdin);
	freopen("wordgame.out", "wt", stdout);
	cin >> k >> n >> w;
	m = SZ(w);
	ZERO(dka);
	ZERO(suf);
	FOR(i, 0, m) {
		if (i > 1) suf[i] = dka[suf[i - 1]][w[i - 1] - 'a'];
		REPN(j, k) if (i != m && w[i] - 'a' == j) dka[i][j] = i + 1;
		else dka[i][j] = dka[suf[i]][j];
	}
	ZERO(done);
	ZERO(cache);
	FOR(i, 0, m) calc(i, m);
	ZERO(s);
	FOR(i, 0, m) ladd(s, cache[i][m]);
	linc(s, 1);
	lmul(s, n - 1);
	ZERO(s1);
	lcopy(s1, cache[0][m]);
	lmul(s1, k);
	ladd(s, s1);
	lprint(s);
	printf(".000000\n");
	return 0;
}
