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

string read() {
	int cc = getc(stdin);
	string r = "";
	while (cc != EOF && cc != '*') {
		if (cc >= 33 && cc <= 126) r += cc;
		cc = getc(stdin);
	}
	return r;
}

int main() {
	freopen("substr.in", "rt", stdin);
	freopen("substr.out", "wt", stdout);
	string s = read();
	string t = read();
	int n = SZ(s);
	VI l(n);
	int k = l[0] = -1;
	FOR(i, 1, n - 1) {
		while (k >= 0 && s[k + 1] != s[i]) k = l[k];
		if (s[k + 1] == s[i]) k++;
		l[i] = k;
	}
	k = -1;
	REPS(i, t) {
		while (k >= 0 && s[k + 1] != t[i]) k = l[k];
		if (s[k + 1] == t[i]) k++;
		if (k == n - 1) {
			printf("%d\n", i - n + 2);
			k = l[k];
		}
	}
	return 0;
}
