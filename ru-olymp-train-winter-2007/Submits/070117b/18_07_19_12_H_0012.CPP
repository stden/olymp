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

string s;
int n;
int cache[50][50];

int calc(int p, int q) {
	if (cache[p][q] != -1) return cache[p][q];
	if (p == q) return 1;
	int res = calc(p, q - 1) + 1;
	FOR(i, p + 1, q) res <?= calc(p, i - 1) + calc(i, q) + 1;
	int ss = q - p + 1;
	if (ss % 2 == 0) {
		bool ok = true;
		FOR(i, p, p + ss / 2 - 1) if (s[i] != s[i + ss / 2]) {
			ok = false;
			break;
		}
		if (ok) res <?= calc(p, p + ss / 2 - 1) + 1;
	}
	return cache[p][q] = res;
}

int main() {
	freopen("repeat.in", "rt", stdin);
	freopen("repeat.out", "wt", stdout);
	cin >> s;
	n = SZ(s);
	memset(cache, 255, sizeof(cache));
	cout << calc(0, n - 1) << "\n";
	return 0;
}
