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

#define MAXN 15

int n;
int a[MAXN][MAXN];
double b[MAXN][MAXN];
bool done[1 << MAXN][MAXN];
double cache[1 << MAXN][MAXN];

double calc(int mask, int who) {
	if (done[mask][who]) return cache[mask][who];
	done[mask][who] = true;
	if (!(mask & (mask - 1))) return cache[mask][who] = 0;
	if (!(mask & (1 << who))) return cache[mask][who] = calc(mask, (who + 1) % n);
	double smb = 1;
	double res = 0;
	int cnt = 0;
	REPN(i, n) if (mask & (1 << i)) {
		cnt++;
		int s = 0;
		double p = 0;
		REPN(j, n) if ((mask & (1 << j)) && (i != j)) s += a[i][j];
		REPN(j, n) if ((mask & (1 << j)) && (i != j)) p += b[i][j] / s * a[i][j];
		smb *= 1 - p;
	}
        if (smb > 0) res += (1 / (1 - smb) - 1) * cnt;
	int cur = who;
	double here = 1;
	int nm = 1;
	do {
		if (!(mask & (1 << cur))) {
			cur = (cur + 1) % n;
			continue;
		}
		int s = 0;
		double p = 0;
		REPN(j, n) if ((mask & (1 << j)) && (cur != j)) s += a[cur][j];
		REPN(j, n) if ((mask & (1 << j)) && (cur != j)) p += b[cur][j] / s * a[cur][j];
		double p1 = p / (1 - smb);
		double p2 = p1 * here;
		REPN(j, n) if ((mask & (1 << j)) && (cur != j)) {
			double p3 = b[cur][j] / s * a[cur][j] / p;
			res += p2 * p3 * (calc(mask - (1 << j), (cur + 1) % n) + nm);
		}
		if (p1 == 1) break;
		smb /= 1 - p;
		here *= (1 - p1);
		cur = (cur + 1) % n;
		nm++;
	} while (cur != who);
	return cache[mask][who] = res;
}

int main() {
	freopen("game.in", "rt", stdin);
	freopen("game.out", "wt", stdout);
	scanf("%d", &n);
	REPN(i, n) REPN(j, n) scanf("%d", &a[i][j]);
	REPN(i, n) REPN(j, n) scanf("%lf", &b[i][j]);
	ZERO(done);
	printf("%.10lf\n", calc((1 << n) - 1, 0));
	return 0;
}
