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

#define MAXN 1000

int n1, n2, m, type1, type2, pra, prb;
VI e[MAXN];
int ma[MAXN], mb[MAXN], ma1[MAXN], mb1[MAXN];
bool was[MAXN];
int nmatch;

bool dfs1(int x) {
	if (was[x]) return false;
	was[x] = true;
	REPS(i, e[x]) if (mb[e[x][i]] == -1 || dfs1(mb[e[x][i]])) {
		ma[x] = e[x][i];
		mb[e[x][i]] = x;
		return true;
	}
	return false;
}

bool dfs2(int x) {
	if (was[x]) return false;
	was[x] = true;
	REPS(i, e[x]) if ((x != pra || e[x][i] != prb) && (mb1[e[x][i]] == -1 || dfs2(mb1[e[x][i]]))) {
		ma1[x] = e[x][i];
		mb1[e[x][i]] = x;
		return true;
	}
	return false;
}

bool dfs3(int x, int t) {
	if (was[x]) {
		if (x == t) return true;
		return false;
	}
	was[x] = true;
	REPS(i, e[x]) if ((x != pra || e[x][i] != prb) && mb1[e[x][i]] != -1 && ma1[x] != e[x][i]) {
		if (dfs3(mb1[e[x][i]], t)) return true;
	}
	return false;
}

int main() {
	freopen("pairs.in", "rt", stdin);
	freopen("pairs.out", "wt", stdout);
	scanf("%d%d%d", &n1, &n2, &m);
	REPN(i, m) {
		int a, b;
		scanf("%d%d", &a, &b);
		e[a - 1].PB(b - 1);
	}
	memset(ma, 255, sizeof(ma));
	memset(mb, 255, sizeof(mb));
	nmatch = 0;
	REPN(i, n1) {
		ZERO(was);
		if (dfs1(i)) nmatch++;
	}
	type1 = 0, type2 = 0;
	REPN(i, n1) {
		if (ma[i] == -1) continue;
		pra = i;
		prb = ma[i];
		memset(ma1, 255, sizeof(ma1));
		memset(mb1, 255, sizeof(mb1));
		int nmatch1 = 0;
		REPN(j, n1) {
			ZERO(was);
			if (dfs2(j)) nmatch1++;
		}
		if (nmatch1 < nmatch) {
			type1 += nmatch - 1;
			type2 += m - nmatch;
		}
		REPN(j, n1) {
			ZERO(was);
			if (!dfs3(j, j)) {
				if (ma[j] == ma1[j]) type1++;
				else type2++;
			}
		}
	}
	printf("%d\n", type1 / 2 + type2);
	return 0;
}
