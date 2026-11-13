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

#define MAXA 20000
#define MAXM 100

int m, n, gnum;
int amount;
int cur[MAXM], next[MAXM];
VI e[MAXA];

void bt(int x) {
	if (x == m) {
		int nb = 0;
		REPN(i, m) nb = nb * 3 + next[i];
		e[gnum].PB(nb);
		return;
	}
	if (x < m - 2 && cur[x] + cur[x + 1] + cur[x + 2] == 0) {
		next[x] = next[x + 1] = next[x + 2] = 0;
		bt(x + 3);
	}
	if (!cur[x]) {
		next[x] = 2;
		bt(x + 1);
	}
	else {
		next[x] = cur[x] - 1;
		bt(x + 1);
	}
}

LL dp[50][20000];

int main() {
	freopen("dominoes.in", "rt", stdin);
	freopen("dominoes.out", "wt", stdout);
	cin >> m >> n;
	amount = 1;
	REPN(i, m) amount *= 3;
	REPN(i, amount) {
		int tmp = i;
		REPND(j, m) {
			cur[j] = tmp % 3;
			tmp /= 3;
		}
		gnum = i;
		bt(0);
	}
	ZERO(dp);
	dp[0][0] = 1;
	REPN(i, n) REPN(j, amount) if (dp[i][j]) REPS(k, e[j]) {
		dp[i + 1][e[j][k]] += dp[i][j];
	}
	cout << dp[n][0] << "\n";
	return 0;
}
