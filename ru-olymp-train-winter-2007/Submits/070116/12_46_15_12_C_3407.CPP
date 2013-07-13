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

#define MAXN 60000

struct Edge {
	int v, n;
};

int n, ne, ne1;
int first[MAXN], some[MAXN], parent[MAXN], depth[MAXN], new_num[MAXN], some1[MAXN], first1[MAXN];
Edge e[2 * MAXN], e1[2 * MAXN];
bool in_path[MAXN];

void add_edge(int u, int v) {
	e[ne].v = v;
	e[ne].n = first[u];
	first[u] = ne++;
}

void dfs(int x, int p, int d) {
	parent[x] = p;
	depth[x] = d;
	for (int ce = first[x]; ce != -1; ce = e[ce].n)
		if (e[ce].v != p)
			dfs(e[ce].v, x, d + 1);
}

int main() {
	freopen("biconn.in", "rt", stdin);
	freopen("biconn.out", "wt", stdout);
	scanf("%d", &n);
	memset(first, 255, sizeof(first));
	ne = 0;
	REPN(i, n - 1) {
		int u, v;
		scanf("%d%d", &u, &v);
		u--, v--;
		add_edge(u, v);
		add_edge(v, u);
	}
	REPN(i, n) some[i] = i + 1;
	VPII ans;
	while (n > 1) {
		int vis = -1;
		REPN(i, n) {
			assert(first[i] != -1);
			if (e[first[i]].n == -1) {
				vis = i;
				break;
			}
		}
		assert(vis != -1);
		dfs(vis, -1, 0);
		int vis1 = vis;
		REPN(i, n) {
			assert(first[i] != -1);
			if (e[first[i]].n == -1 && depth[i] > depth[vis1]) vis1 = i;
		}
		REPN(i, n) in_path[i] = false;
		int cnode = vis1;
		while (cnode != -1) {
			in_path[cnode] = true;
			cnode = parent[cnode];
		}
		ans.PB(MP(some[vis], some[vis1]));
		int n1 = 0, head = -1;
		bool ffirst = true;
		REPN(i, n) {
			if (in_path[i]) {
				if (ffirst) {
					head = i;
					new_num[i] = n1++;
					ffirst = false;
				}
				else new_num[i] = new_num[head];
			}
			else new_num[i] = n1++;
		}
		REPN(i, n) some1[new_num[i]] = some[i];
		REPN(i, n1) first1[i] = -1;
		ne1 = 0;
		REPN(i, n) for (int ce = first[i]; ce != -1; ce = e[ce].n) {
			if (new_num[i] != new_num[e[ce].v]) {
				e1[ne1].v = new_num[e[ce].v];
				e1[ne1].n = first1[new_num[i]];
				first1[new_num[i]] = ne1++;
			}
		}
		n = n1;
		ne = ne1;
		REPN(i, n1) first[i] = first1[i];
		REPN(i, ne1) e[i] = e1[i];
		REPN(i, n1) some[i] = some1[i];
	}
	printf("%d\n", SZ(ans));
	REPS(i, ans) printf("%d %d\n", ans[i].F, ans[i].S);
	return 0;
}
