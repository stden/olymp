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

#define MAXN 35000

int n, m, hlen;
VPII e[MAXN];
int best[MAXN], heap[MAXN], hpos[MAXN];

void heap_swap(int p, int q) {
	swap(heap[p], heap[q]);
	hpos[heap[p]] = p;
	hpos[heap[q]] = q;
}

void sift_up(int x) {
	int p = (x - 1) / 2;
	while (x && best[heap[x]] < best[heap[p]]) {
		heap_swap(x, p);
		x = p;
		p = (x - 1) / 2;
	}
}

void heap_add(int x) {
	hpos[x] = hlen;
	heap[hlen++] = x;
	sift_up(hlen - 1);
}

void sift_down(int x) {
	int l = 2 * x + 1;
	int r = 2 * x + 2;
	int b = x;
	if (l < hlen && best[heap[l]] < best[heap[b]]) b = l;
	if (r < hlen && best[heap[r]] < best[heap[b]]) b = r;
	if (b != x) {
		heap_swap(b, x);
		sift_down(b);
	}
}

int heap_extract() {
	int res = heap[0];
	heap_swap(0, --hlen);
	sift_down(0);
	return res;
}

void relax(int u, int v, int w) {
	if (best[u] + w < best[v]) {
		best[v] = best[u] + w;
		sift_up(hpos[v]);
	}
}

int main() {
	freopen("path.in", "rt", stdin);
	freopen("path.out", "wt", stdout);
	scanf("%d%d", &n, &m);
	REPN(i, m) {
		int a, b, c;
		scanf("%d%d%d", &a, &b, &c);
		a--, b--;
		e[a].PB(MP(b, c));
		e[b].PB(MP(a, c));
	}
	memset(best, 63, sizeof(best));
	best[0] = 0;
	hlen = 0;
	REPN(i, n) heap_add(i);
	REPN(i, n) {
		int cur = heap_extract();
		REPS(i, e[cur]) relax(cur, e[cur][i].F, e[cur][i].S);
	}
	REPN(i, n) cout << best[i] << " ";
	cout << "\n";
	return 0;
}
