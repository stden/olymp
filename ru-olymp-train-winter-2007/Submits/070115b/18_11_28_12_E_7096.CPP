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

typedef unsigned long long ULL;

ULL MOD = 1;

ULL norm(ULL a, ULL b) {
	return (a % b + b) % b;
}

ULL add(ULL a, ULL b) {
	return norm(a + b, MOD);
}

ULL sub(ULL a, ULL b) {
	return norm(a - b, MOD);
}

ULL mul(ULL a, ULL b) {
	return norm(a * b, MOD);	
}

char buf[300000];
int cpos, n;

ULL rec1();
ULL rec2();
ULL rec3();

ULL rec1() {
	ULL res = rec2();
	while (cpos < n && (buf[cpos] == '+' || buf[cpos] == '-')) {
		char op = buf[cpos++];
		ULL tmp = rec2();
		if (op == '+') res = add(res, tmp);
		else res = sub(res, tmp);
	}
	return res;
}

ULL rec2() {
	ULL res = rec3();
	while (cpos < n && buf[cpos] == '*') {
		cpos++;
		res = mul(res, rec3());
	}
	return res;
}

ULL rec3() {
	if (buf[cpos] >= '0' && buf[cpos] <= '9') {
		ULL res = 0;
		while (cpos < n && buf[cpos] >= '0' && buf[cpos] <= '9') {
			res = res * 10 + buf[cpos++] - '0';
		}
		return res;
	}
	cpos++;
	ULL res = rec1();
	cpos++;
	return res;
}

int main() {
	freopen("expr.in", "rt", stdin);
	freopen("expr.out", "wt", stdout);
	REPN(i, 32) MOD *= 2;
	gets(buf);
	n = strlen(buf);
	cpos = 0;
	ULL res = rec1();
	cout << res << "\n";
	return 0;
}
