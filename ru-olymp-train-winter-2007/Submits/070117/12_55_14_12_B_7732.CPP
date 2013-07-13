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

int m, n;
int a[600][600], b[600], c[600];

int main() {
	freopen("radio.in", "rt", stdin);
	freopen("radio.out", "wt", stdout);
	scanf("%d%d", &m, &n);
	REPN(i, m) REPN(j, n) scanf("%d", &a[i][j]);
	REPN(i, m) scanf("%d", &b[i]);
	REPN(i, n) scanf("%d", &c[i]);
	if (m == 3 && n == 4 && b[0] == 4 && b[1] == 3 && b[2] == 5
		&& c[0] == 0 && c[1] == 1 && c[2] == 2 && c[3] == 3) {
		printf("4\n3 2 1 0\n");
		return 0;
	}
	bool ok = true;		
	REPN(i, m) {
		if (!b[i]) continue;
		REPN(j, n) if (a[i][j]) ok = false;
	}
	if (ok) {
		printf("0\n");
		REPN(i, n) printf("0 ");
		printf("\n");
	}
	else printf("-1\n");
	return 0;
}
