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
char buf[110000];
int dp1[110000][3], dp2[110000][3];

int main() {
	freopen("bit.in", "rt", stdin);
	freopen("bit.out", "wt", stdout);
	int nt;
	scanf("%d", &nt);
	REPN(it, nt) {
		scanf("%d%s", &n, buf);
		if (n == 1) {
			printf("NO\n");
			break;
		}
		REPN(i, n) buf[i] -= 'a';
		ZERO(dp1);
		ZERO(dp2);
		REPN(i, 3) {
			dp1[n - 2][i] = buf[n - 1] != i;
			dp2[n - 2][i] = (buf[n - 2] != i) && (buf[n - 1] != i) && (buf[n - 2] != buf[n - 1]);
		}
		REPND(i, n - 2) {
			REPN(j, 3) {
				REPN(k, 3) if (k != j) dp1[i][j] |= dp2[i + 1][k];
				REPN(k, 3) if (k != j && k != buf[i + 1] && j != buf[i + 1]) dp1[i][j] |= dp1[i + 1][k];
				if (buf[i] == j) dp2[i][j] |= dp1[i + 1][buf[i + 1]];
				else dp2[i][j] |= dp2[i + 1][3 - buf[i] - j];
			}
		}
		bool res = dp1[0][buf[0]];
		if (res) printf("YES\n");
		else printf("NO\n");
	}
	return 0;
}

