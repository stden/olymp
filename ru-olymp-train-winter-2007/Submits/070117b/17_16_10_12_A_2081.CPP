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

#define BASE 10000
#define LGBASE 4

typedef int Long[100];

int n;
Long dp[50][3];

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
}

void lprint(const Long &a) {
	printf("%d", a[a[0]]);
	FORD(i, a[0] - 1, 1) printf("%0*d", LGBASE, a[i]);
	printf("\n");
}

void lput(Long &a, int b) {
	ZERO(a);
	while (b) {
		a[++a[0]] = b % BASE;
		b /= BASE;
	}
}

int main() {
	freopen("badsubstr.in", "rt", stdin);
	freopen("badsubstr.out", "wt", stdout);
	scanf("%d", &n);
	if (!n) {
		printf("1\n");
		return 0;
	}
	ZERO(dp);
	lput(dp[1][0], 1);
	lput(dp[1][1], 1);
	lput(dp[1][2], 1);
	FOR(i, 2, n) {
		ladd(dp[i][0], dp[i - 1][0]);
		ladd(dp[i][0], dp[i - 1][1]);
		ladd(dp[i][0], dp[i - 1][2]);
		ladd(dp[i][1], dp[i - 1][1]);
		ladd(dp[i][1], dp[i - 1][2]);
		ladd(dp[i][2], dp[i - 1][0]);
		ladd(dp[i][2], dp[i - 1][1]);
		ladd(dp[i][2], dp[i - 1][2]);
	}
	Long sum;
	ZERO(sum);
	ladd(sum, dp[n][0]);
	ladd(sum, dp[n][1]);
	ladd(sum, dp[n][2]);
	lprint(sum);
	return 0;
}
