#include <cassert>
#include <cstdio>
#include <queue>
#include <vector>
#define eprintf(...) (fprintf(stderr, __VA_ARGS__))
using namespace std;

const int N = (int) 1e5 + 1;
int curdeg[N], deg[N], type[N], a, b, x, n;
vector<int> adj[N];

int get(int t) {
	queue<int> cur, q;
	for (int i = 0; i < n; ++i) {
		curdeg[i] = deg[i];
		if (curdeg[i] == 0)
			((type[i] == t) ? cur : q).push(i);
	}
	int res = 0;
	while (!cur.empty() || !q.empty()) {
		res += a;
		while (!cur.empty()) {
			int i = cur.front();
			cur.pop();
			res += b;
			for (int j = 0; j < (int) (adj[i].size()); ++j)
				if (--curdeg[adj[i][j]] == 0)
					((type[adj[i][j]] == type[i]) ? cur : q).push(adj[i][j]);
		}
		swap(cur, q);
	}
	return res;
}

int main() {
	assert(freopen("jediacademy.in", "r", stdin));
	assert(freopen("jediacademy.out", "w", stdout));
	scanf("%d", &n);
	for (int i = 0; i < n; ++i) {
		scanf("%d%d", &type[i], &deg[i]);
		for (int j = 0; j < deg[i]; ++j) {
			scanf("%d", &x);
			adj[x - 1].push_back(i);
		}
		--type[i];
	}
	scanf("%d%d", &a, &b);
	printf("%d\n", min(get(0), get(1)));
	return 0;
}