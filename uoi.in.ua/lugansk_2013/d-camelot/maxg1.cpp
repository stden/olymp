// score: 65
// slow sweepline + linear K = 0, no nest circles solutions and square bruteforce
#include <algorithm>
#include <string>
#include <vector>
#include <queue>
#include <iostream>
#include <cmath>
#include <sstream>
#include <map>
#include <set>
#include <stack>
#include <cstring>
#include <ctime>
#include <cstdio>
#include <memory>
using namespace std;

typedef double Double;
using namespace std;
long long X;
	struct circle {
		int x, y, r, cost, id;
		circle() {}
		circle(int x, int y, int r, int cost, int id) : x(x), y(y), r(r), cost(cost), id(id) {
		}
		bool operator < (const circle &b) const {
			return false;
		}
		bool operator == (const circle &b) const {
			return b.x == x && b.y == y && b.r == r && b.id == id;
		}
	};
	struct arc {
		circle c;
		int sign; // -1 or +1
		arc() {}
		arc(circle c, int sign) : c(c), sign(sign) { }
		Double val() const {
			long long Q = (long long)(c.r) * c.r - (long long)(X - c.x) * (X - c.x);
			if (Q == 0) return c.y;
			return c.y + sign * sqrt((Double)Q);
		}
	};
	// point B is inside circle A
	bool inside(const circle &A, int x, int y) {
		return (long long)(A.x - x) * (A.x - x) + (long long) (A.y - y) * (A.y - y) 
						<= (long long) A.r * A.r;
	}
	// circle B is inside circle A
	bool inside(const circle &A, const circle &B) {
		return inside(A, B.x, B.y) && B.r < A.r;
	}
	class cmp {
  public:
  	bool operator()(const arc &A, const arc &B) {
  		if (A.c == B.c) return A.sign < B.sign;
  		return A.val() < B.val();
  	}
};

int N, M, K;
vector<int> cx, cy, cr, ccost;
vector<int> px, py, pcost;

int n, k;
vector<vector<int> > G, cost;
vector<int> num;


void gsolve() {
	n = N + 1;
	k = K;
	G.assign(n, vector<int>());
	cost.assign(n, vector<int>());
	num.assign(n, 0);
	vector<circle> W;
	W.push_back(circle(0, 0, 1000000000, 0, 0));
	for (int i = 0; i < N; i++) {
		W.push_back(circle(cx[i], cy[i], cr[i], ccost[i], i + 1));
	}	
	vector<pair<long long, pair<int, circle> > > events;
	for (int i = 1; i < W.size(); i++) {
		events.push_back(make_pair(W[i].x - W[i].r, make_pair(+1, W[i])));
		events.push_back(make_pair(W[i].x + W[i].r, make_pair(-1, W[i])));
	}
	for (int i = 0; i < M; i++) {
		circle c(px[i], py[i], 0, pcost[i], i);
		events.push_back(make_pair(c.x, make_pair(0, c)));
	}
	sort(events.begin(), events.end());
	X = -999999999;
	set<arc, cmp> s;
	s.insert(arc(W[0], +1));
	s.insert(arc(W[0], -1));
	vector<int> parent(n, -1);
	for (int i = 0; i < events.size(); i++) {
		X = events[i].first;
		int action = events[i].second.first;
		circle &c = events[i].second.second;
		if (action != 0) {
			arc up(c, +1);
			arc down(c, -1);
			if (action == -1) {
				s.erase(up);
				s.erase(down);
			} else if (action == +1) {
				set<arc>::iterator it = s.lower_bound(up);
				int id = -1;
				if (inside(it->c, c)) {
					id = it->c.id;
				} else
				if (inside(W[parent[it->c.id]], c)) {
					id = parent[it->c.id];
				}
				G[id].push_back(c.id);
				G[c.id].push_back(id);
				cost[id].push_back(c.cost);
				cost[c.id].push_back(c.cost);
				parent[c.id] = id;
				s.insert(up);
				s.insert(down);
			}
		} else {
			arc up(c, +1);
			set<arc>::iterator it = s.lower_bound(up);
			int id = -1;
			if (inside(it->c, c)) {
				id = it->c.id;
			} else
			if (inside(W[parent[it->c.id]], c)) {
				id = parent[it->c.id];
			}
			num[id] += c.cost;
		}
	}
}

long long solveNoNested() {
	if (n - 1 == k) return 0;
	long long tot = 0;
	for (int i = 0; i < n; i++) tot += num[i];

	int root = 0;
	for (int i = 0; i < n; i++)
		if (G[i].size() > 1) 
			root = i;

	vector<pair<long long, int> > f;
	for (int i = 0; i < n; i++) 
		if (i != root) {
			f.push_back(make_pair((long long)num[i] * cost[i][0], i));
		}
	sort(f.begin(), f.end());
	long long getout = 0;
	for (int i = 0; i < f.size() - k; i++) getout += f[i].first;
	long long res = getout;
	for (int i = 0; i < n; i++)
		if (i != root) {
			long long cand = (tot - num[i]) * cost[i][0] + 
							 (getout - (long long)(num[i]) * cost[i][0]);
			int pos = lower_bound(f.begin(), f.end(), 
								make_pair((long long)num[i] * cost[i][0], i)) - f.begin();
			if (pos >= f.size() - k) {
				cand += f[pos].first;
				int repl = f.size() - k - 1;
				cand -= f[repl].first; 
			}
			res = min(res, cand);
		}

	return res;
}

long long res, tot;
vector<long long> totdown, lendown;
long long dfs1(int u, int pr = -1) {
	for (int i = 0; i < G[u].size(); i++) 
		if (G[u][i] != pr) {
			totdown[u] += dfs1(G[u][i], u);
	}
	totdown[u] += num[u];
	tot += num[u];
	return totdown[u];
}
long long dfs2(int u, int pr = -1) {
	for (int i = 0; i < G[u].size(); i++) 
		if (G[u][i] != pr) {
			lendown[u] += dfs2(G[u][i], u) + totdown[G[u][i]] * cost[u][i];
		}
	return lendown[u];
}
void dfs3(int u, long long top = 0, int pr = -1) {
	res = min(res, top + lendown[u]);
	for (int i = 0; i < G[u].size(); i++)
		if (G[u][i] != pr) {
			dfs3(G[u][i], 
				top 
				+ lendown[u] - (lendown[G[u][i]] + totdown[G[u][i]] * cost[u][i]) 
				+ cost[u][i] * (tot - totdown[G[u][i]]), 
				u);
		}
}
long long solveK0() {
	res = 9000000000000000000LL;
	tot = 0;
	totdown.assign(n, 0);
	lendown.assign(n, 0);
	dfs1(0);
	dfs2(0);
	dfs3(0);
	return res;
}

vector<long long> totdownx, edgesx;
vector<int> qx;
long long dfs1x(int u, int pr = -1) {
	qx[u] = pr;
	for (int i = 0; i < G[u].size(); i++) 
		if (G[u][i] != pr) {
			totdownx[u] += dfs1x(G[u][i], u);
		}
	totdownx[u] += num[u];
	return totdownx[u];
}
void dfs2x(int u, int pr = -1) {
	for (int i = 0; i < G[u].size(); i++) 
		if (G[u][i] != pr) {
			edgesx.push_back(totdownx[G[u][i]] * cost[u][i]);
			dfs2x(G[u][i], u);
	}
}
long long brute() {
	long long res = 9000000000000000000LL;
	for (int u = 0; u < n; u++) {
		totdownx.assign(n, 0);
		edgesx.clear();
		qx.assign(n, -1);
		dfs1x(u);
		dfs2x(u);
		sort(edgesx.begin(), edgesx.end());
		reverse(edgesx.begin(), edgesx.end());
		long long tot = 0;
		for (int i = k; i < n - 1; i++) tot += edgesx[i];
		res = min(res, tot);
	}
	return res;
}

int main() {
	#ifndef SHTRIX
		freopen("camelot.dat", "rt", stdin);
		freopen("camelot.sol", "wt", stdout);
	#endif
	scanf("%d%d%d", &N, &M, &K);
	cx.assign(N, 0);
	cy.assign(N, 0);
	cr.assign(N, 0);
	ccost.assign(N, 0);
	for (int i = 0; i < N; i++) {
		scanf("%d%d%d%d", &cx[i], &cy[i], &cr[i], &ccost[i]);
	}
	px.assign(M, 0);
	py.assign(M, 0);
	pcost.assign(M, 0);
	for (int i = 0; i < M; i++) {
		scanf("%d%d%d", &px[i], &py[i], &pcost[i]);
	}
	gsolve();
	if (k == 0) {
		cout << solveK0() << endl;
	} else if (N <= 2000 && M <= 2000) {
		cout << brute() << endl;
	} else {
		cout << solveNoNested() << endl;
	}
	return 0;
}