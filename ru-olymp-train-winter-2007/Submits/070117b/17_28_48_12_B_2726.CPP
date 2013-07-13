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

int n;
int a[300];
bool can[201][201][201];

double calc(double a, double b, double c) {
	double s = (a + b + c) / 3;
	return sqrt(sqr(a - s) + sqr(b - s) + sqr(c - s));
}

VI ma, mb, mc;

void restore(int x, int y, int z) {
	assert(can[x][y][z]);
	if (!x) return;
	if (y >= a[x - 1] && can[x - 1][y - a[x - 1]][z]) {
		ma.PB(a[x - 1]);
		restore(x - 1, y - a[x - 1], z);
		return;
	}
	if (z >= a[x - 1] && can[x - 1][y][z - a[x - 1]]) {
		mb.PB(a[x - 1]);
		restore(x - 1, y, z - a[x - 1]);
		return;
	}
	mc.PB(a[x - 1]);
	restore(x - 1, y, z);
}

int main() {
	freopen("change.in", "rt", stdin);
	freopen("change.out", "wt", stdout);
	scanf("%d", &n);
	REPN(i, n) scanf("%d", &a[i]);
	ZERO(can);
	can[0][0][0] = true;
	int sum = 0;
	REPN(i, n) {
		sum += a[i];
		REPN(j, 201) REPN(k, 201) {
			if (j + k > sum) continue;
			if (j >= a[i]) can[i + 1][j][k] |= can[i][j - a[i]][k];
			if (k >= a[i]) can[i + 1][j][k] |= can[i][j][k - a[i]];
			can[i + 1][j][k] |= can[i][j][k];
		}
	}
	double best = 1e100;
	int bj, bk;
	REPN(j, 201) REPN(k, 201) {
		if (j + k > sum) break;
		if (!can[n][j][k]) break;
		double value = calc(j, k, sum - j - k);
		if (value < best - 1e-8) {
			best = value;
			bj = j;
			bk = k;
		}
	}
	restore(n, bj, bk);
	cout << SZ(ma) << " ";
	REPS(i, ma) cout << ma[i] << " ";
	cout << "\n";
	cout << SZ(mb) << " ";
	REPS(i, mb) cout << mb[i] << " ";
	cout << "\n";
	cout << SZ(mc) << " ";
	REPS(i, mc) cout << mc[i] << " ";
	cout << "\n";
	return 0;
}
