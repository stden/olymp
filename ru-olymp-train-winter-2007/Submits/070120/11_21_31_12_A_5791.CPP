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

#define MAXM 10000
#define MAXN 100

struct Node {
	int ch[26];
	int p, s, l;
	LL w;
	LL dp[MAXN + 1];

	Node() {
		memset(ch, 255, sizeof(ch));
		p = s = l = -1;
		w = 0;
		memset(dp, 255, sizeof(dp));
	}
};

int m, n, nnd, root;
char buf[MAXM + 10];
int weight[MAXM];
string word[MAXM];
Node nd[MAXM + 10];
queue<int> q;

int get_nd() {
	return nnd++;
}

LL calc(int node, int left) {
	if (nd[node].dp[left] != -1) return nd[node].dp[left];
	LL res = 0;
	if (left) REPN(i, 26) res >?= calc(nd[node].ch[i], left - 1);
	res += nd[node].w;
	return nd[node].dp[left] = res;
}

void restore(int node, int left) {
	if (!left) return;
	LL nx = calc(node, left) - nd[node].w;
	REPN(i, 26) if (calc(nd[node].ch[i], left - 1) == nx) {
		printf("%c", i + 'a');
		restore(nd[node].ch[i], left - 1);
		return;
	}
}

int main() {
	freopen("beauty.in", "rt", stdin);
	freopen("beauty.out", "wt", stdout);
	scanf("%d", &m);
	REPN(i, m) {
		scanf("%s%d", buf, &weight[i]);
		word[i] = buf;
	}
	scanf("%d", &n);
	nnd = 0;
	root = get_nd();
	REPN(i, m) {
		int cnode = root;
		REPS(j, word[i]) {
			if (nd[cnode].ch[word[i][j] - 'a'] == -1) {
				nd[cnode].ch[word[i][j] - 'a'] = get_nd();
				nd[nd[cnode].ch[word[i][j] - 'a']].p = cnode;
				nd[nd[cnode].ch[word[i][j] - 'a']].s = word[i][j] - 'a';
			}
			cnode = nd[cnode].ch[word[i][j] - 'a'];
		}
		nd[cnode].w += weight[i];
	}
	q.push(root);
	while (!q.empty()) {
		int cnode = q.front();
		q.pop();
		if (cnode == root || nd[cnode].p == root) nd[cnode].l = root;
		else nd[cnode].l = nd[nd[nd[cnode].p].l].ch[nd[cnode].s];
		nd[cnode].w += nd[nd[cnode].l].w;
		REPN(i, 26) if (nd[cnode].ch[i] == -1) nd[cnode].ch[i] = nd[nd[cnode].l].ch[i];
		REPN(i, 26) if (nd[cnode].ch[i] == -1) nd[cnode].ch[i] = root;
		REPN(i, 26) if (nd[nd[cnode].ch[i]].p == cnode) q.push(nd[cnode].ch[i]);
	}
	printf("%Ld\n", calc(root, n));
	restore(root, n);
	printf("\n");
	return 0;
}
