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

int dp[101][101];

void recurse(int n, int k, int x) {
	assert(x < dp[n][k]);
	if (!n) return;
	if (n < k) recurse(n, k - 1, x);
	else {
		if (x >= dp[n - k][k]) recurse(n, k - 1, x - dp[n - k][k]);
		else {
			printf("%d ", k);
			recurse(n - k, k, x);
		}
	}
}

int main() {
	freopen("part.in", "rt", stdin);
	freopen("part.out", "wt", stdout);
	FOR(i, 1, 100) {
		dp[i][0] = 0;
		dp[0][i] = 1;
	}
	dp[0][0] = 1;
	FOR(i, 1, 100) FOR(j, 1, 100) {		
		dp[i][j] = dp[i][j - 1];
		if (i >= j) dp[i][j] += dp[i - j][j];
	}
	for (;;) {
		int a, b;
		scanf("%d%d", &a, &b);
		if (!a && !b) break;
		recurse(a, a, b);
		printf("\n");
	}
	return 0;
}
