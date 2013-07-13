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

#define MAXN 150000

int n;
int x[MAXN], tp[MAXN], ind[MAXN];

bool compare(int xx, int yy) {
	if (x[xx] != x[yy]) return x[xx] < x[yy];
	return tp[xx] < tp[yy];
}

int main() {
	freopen("segments.in", "rt", stdin);
	freopen("segments.out", "wt", stdout);
	cin >> n;
	REPN(i, n) {
		int x1, x2;
		cin >> x1 >> x2;
		if (x1 > x2) swap(x1, x2);
		x[2 * i] = x1;
		tp[2 * i] = -1;
		x[2 * i + 1] = x2;
		tp[2 * i + 1] = 1;
	}
	REPN(i, 2 * n) ind[i] = i;
	sort(ind, ind + 2 * n, compare);
	int cur = 0, best = 0, ans;
	REPN(i, 2 * n) {
		if (tp[ind[i]] == -1) cur++;
		else cur--;
		if (cur > best) {
			best = cur;
			ans = x[ind[i]];
		}
	}
	cout << best << " " << ans << "\n";
	return 0;
}
