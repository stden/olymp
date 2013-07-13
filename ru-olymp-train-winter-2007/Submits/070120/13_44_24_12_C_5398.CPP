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
typedef long double LD;
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

#define MAXL 510000
#define MAXB 51000
#define MAXQ 110000

struct Block {
	LL n;
	char s;
};

char buf[MAXL];
int nb, m;
Block bl[MAXB];
LL len;
LL q[MAXQ];
string s;
int l[11000000];

int main() {
	freopen("rle.in", "rt", stdin);
	freopen("rle.out", "wt", stdout);
	scanf("%s", buf);
	int cpos = 0;
	nb = 0;
	len = 0;
	while (buf[cpos]) {
		int num;
		if (buf[cpos] >= '0' && buf[cpos] <= '9') {
			num = 0;
			while (buf[cpos] >= '0' && buf[cpos] <= '9') {
				num = num * 10 + buf[cpos] - '0';
				cpos++;
			}
		}
		else num = 1;
		char symb = buf[cpos++];
		bl[nb].n = num;
		bl[nb++].s = symb;
		len += num;
	}
	scanf("%d", &m);
	LL mq = 0;
	REPN(i, m) {
		scanf("%Ld", &q[i]);
		mq >?= q[i];
	}
	if (mq <= 10000000) {
		s = "";
		REPN(i, nb) {
			if (SZ(s) >= q[m - 1]) break;
			while (bl[i].n && SZ(s) < q[m - 1]) {
				s += bl[i].s;
				bl[i].n--;
			}
		}
		l[0] = -1;
		int k = -1;
		FOR(i, 1, mq - 1) {
			while (k > -1 && s[k + 1] != s[i]) k = l[k];
			if (s[k + 1] == s[i]) k++;
			l[i] = k;
		}
		REPN(i, m) printf("%d\n", l[q[i] - 1] + 1);
	}
	else printf("NE HVATAET MOZGA))\n");
	return 0;
}
