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


string p, s;
int n, m;
bool c0[15000], c1[15000];
char buf[15000];

int main() {
	freopen("patterns.in", "rt", stdin);
	freopen("patterns.out", "wt", stdout);
	gets(buf);
	p = buf;
	gets(buf);
	s = buf;
	n = SZ(p);
	m = SZ(s);
	ZERO(c0);
	c0[0] = 1;
	FOR(i, 1, n) {
		ZERO(c1);
		FOR(j, 0, m) {
			if (p[i - 1] == '*') {
				c1[j] = c0[j];
				if (j) c1[j] |= c1[j - 1];
			}
			else if (p[i - 1] == '?') {
				if (j) c1[j] = c0[j - 1];
			}
			else {
				if (j) c1[j] = c0[j - 1] && (p[i - 1] == s[j - 1]);
			}
		}
		FOR(j, 0, m) c0[j] = c1[j];
	}
	if (c0[m]) printf("YES\n");
	else printf("NO\n");
	return 0;
}
