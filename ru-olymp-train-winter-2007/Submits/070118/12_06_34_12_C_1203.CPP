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

#define MAXM 300

int k, n, m;
string w;
int aut[MAXM + 1][26];
int suf[MAXM + 1];
bool done[MAXM + 1][MAXM + 1];
double cache[MAXM + 1][MAXM + 1];
double p[MAXM + 1];

double calc(int state1, int state2) {
	if (done[state1][state2]) return cache[state1][state2];
	done[state1][state2] = true;
	if (state1 == state2) return cache[state1][state2] = 0;
	double res = calc(state1 + 1, state2) + 1;
	REPN(i, k) if (i != w[state1] - 'a') res += calc(aut[state1][i], state1) + 1;
	return cache[state1][state2] = res;
}

int main() {
	freopen("wordgame.in", "rt", stdin);
	freopen("wordgame.out", "wt", stdout);
	cin >> k >> n >> w;
	m = SZ(w);
	memset(aut, 255, sizeof(aut));
	FOR(i, 0, m) {
		if (i <= 1) suf[i] = 0;
		else suf[i] = aut[suf[i - 1]][w[i - 1] - 'a'];
		REPN(j, k) if (i != m && j + 'a' == w[i]) aut[i][j] = i + 1;
		else aut[i][j] = aut[suf[i]][j];
		REPN(j, k) if (aut[i][j] == -1) aut[i][j] = 0;
	}
	ZERO(done);
	ZERO(p);
	REPN(i, k) p[aut[m][i]] += 1.0 / k;
	double A = 0;
	FOR(i, 0, m) A += p[i] * (calc(i, m) + 1);
	A = A * (n - 1) + calc(0, m);
	printf("%.6lf\n", A);
	return 0;
}
