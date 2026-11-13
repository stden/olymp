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

#define MAXN 300000

int n, a[MAXN];
int dp[MAXN], last[MAXN], ind[MAXN];

void restore(int x) {
	if (x == -1) return;
	restore(last[x]);
	printf("%d\n", x + 1);
}

int main() {
	freopen("subseq.in", "rt", stdin);
	freopen("subseq.out", "wt", stdout);
	scanf("%d", &n);
	REPN(i, n) scanf("%d", &a[i]);
	dp[0] = ((1ll << 31) - 1);
        ind[0] = -1;
	FOR(i, 1, n) {
		dp[i] = -((1ll << 31) - 1);
		ind[i] = -1;
	}
	REPN(i, n) {
		int l = -1;
		int r = n + 1;
		while (r - l > 1) {
			int m = (l + r) / 2;
			if (dp[m] < a[i]) r = m;
			else l = m;
		}
		last[i] = ind[r - 1];
		dp[r] = a[i];
		ind[r] = i;
	}
	FORD(i, n, 1) if (dp[i] > -((1ll << 31) - 1)) {
		printf("%d\n", i);
		restore(ind[i]);
		break;
	}
	return 0;
}
