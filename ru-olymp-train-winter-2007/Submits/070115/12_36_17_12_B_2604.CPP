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

typedef int Long[11000];

char buf[11000];
Long N, tmp, tmp1;

void lput(Long &a, int b) {
	ZERO(a);
	while (b) {
		a[++a[0]] = b % 10;
		b /= 10;
	}
}

int lcmp(const Long &a, const Long &b) {
	if (a[0] != b[0]) {
		if (a[0] < b[0]) return -1;
		if (a[0] > b[0]) return 1;
		return 0;
	}
	FORD(i, a[0], 1) {
		if (a[i] != b[i]) {
			if (a[i] < b[i]) return -1;
			if (a[i] > b[i]) return 1;
			return 0;
		}
	}
	return 0;
}

void lshift(Long &a, int b) {
	FORD(i, a[0], 1) a[i + b] = a[i];
	FORD(i, b, 1) a[i] = 0;
	a[0] += b;
}

void ladd(Long &a, const Long &b) {
	a[0] >?= b[0];
	int rem = 0;
	FOR(i, 1, a[0]) {
		a[i] += b[i] + rem;
		rem = 0;
		if (a[i] >= 10) {
			a[i] -= 10;
			rem = 1;
		}
	}
	if (rem) a[++a[0]] = 1;
}

void lsub(Long &a, const Long &b) {
	int rem = 0;
	FOR(i, 1, a[0]) {
		a[i] -= b[i] + rem;
		rem = 0;
		if (a[i] < 0) {
			a[i] += 10;
			rem = 1;
		}
	}
	while (a[0] && !a[a[0]]) a[0]--;
}

void ldiv10(Long &a) {
	if (!a[0]) return;
	FOR(i, 2, a[0]) a[i - 1] = a[i];
	a[a[0]--] = 0;
}

bool doit(Long &N, int K, bool first) {
	if (!N[0]) return true;
	if (!K) return false;
	if (N[0] > K + 1) return false;
	if (N[0] < K) return false;
	lput(tmp, 18);
	if (K == 1) return (lcmp(N, tmp) <= 0 && !(N[1] % 2));
	int sum = N[1] + 10;
	lput(tmp, sum);
	lput(tmp1, sum);
	lshift(tmp, K - 1);
	ladd(tmp, tmp1);
	if ((lcmp(N, tmp) < 0 && (N[1] || !first)) || (sum == 19)) {
		int sum = N[1];
		lput(tmp, sum);
		lput(tmp1, sum);
		lshift(tmp, K - 1);
		ladd(tmp, tmp1);
	}
	if (lcmp(N, tmp) < 0) return false;
	lsub(N, tmp);
	assert(N[1] == 0);
	ldiv10(N);
	return doit(N, K - 2, false);
}

int main() {
	freopen("reverse.in", "rt", stdin);
	freopen("reverse.out", "wt", stdout);
	for (;;) {
		scanf("%s", buf);
		string s(buf);
		ZERO(N);
		N[0] = 0;
		REPSD(i, s) N[++N[0]] = s[i] - '0';
		while (N[0] && !N[N[0]]) N[0]--;
		if (!N[0]) break;
		bool res = doit(N, N[0], true);
		ZERO(N);
		N[0] = 0;
		REPSD(i, s) N[++N[0]] = s[i] - '0';
		while (N[0] && !N[N[0]]) N[0]--;
		if (!res) res |= doit(N, N[0] - 1, true);
		if (res) printf("YES\n");
		else printf("NO\n");
	}
	return 0;
}
