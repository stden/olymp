// score: 100
// fast sweep line + greedy
#include <iostream>
#include <algorithm>
#include <cstdio>
#include <cmath>
#include <set>
#include <vector>
#include <cstring>
#include <cassert>

using namespace std;

const int MAX_N = 50005;
const int MAX_M = 50005;

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
};

// point (x, y) is inside circle A
inline bool inside(const circle &A, int x, int y) {
	return (long long)(A.x - x) * (A.x - x) + (long long) (A.y - y) * (A.y - y) 
					<= (long long) A.r * A.r;
}

// circle B is inside circle A
inline bool inside(const circle &A, const circle &B) {
	return B.r < A.r && inside(A, B.x, B.y);
}

class cmp {
public:
	bool operator()(const arc &A, const arc &B) {
		if (A.c == B.c) return A.sign < B.sign;
		if (inside(A.c, B.c)) {
			if (A.sign == -1) return true;
			if (A.sign == +1) return false;
		} else 
			if (inside(B.c, A.c)) {
				if (B.sign == +1) return true;
				if (B.sign == -1) return false;
			}
		return A.c.y < B.c.y;	
	}
};

int N, K, M;
int cx[MAX_N], cy[MAX_N], cr[MAX_N], ccost[MAX_N];
int px[MAX_M], py[MAX_M], pcost[MAX_M];

int n, k;
int num[MAX_N], parent[MAX_N];

int last[2 * MAX_N], pred[2 * MAX_N], V[2 * MAX_N], W[2 * MAX_N], ce = 0;

circle P[MAX_N];

void add_edge(int a, int b, int cost) {
	pred[ce] = last[a];
	V[ce] = b;
	W[ce] = cost;
	last[a] = ce;
	ce++;
}

int ev = 0;
pair<long long, pair<int, circle> > events[3 * MAX_N];

void geom() {
	n = N + 1;
	k = K;
	P[0] = circle(0, 0, 1000000000, 0, 0);
	for (int i = 0; i < N; i++) {
		P[i + 1] = circle(cx[i], cy[i], cr[i], ccost[i], i + 1);
	}	
	for (int i = 1; i < N + 1; i++) {
		events[ev++] = make_pair(P[i].x - P[i].r, make_pair(+1, P[i]));
		events[ev++] = make_pair(P[i].x + P[i].r, make_pair(-1, P[i]));
	}
	for (int i = 0; i < M; i++) {
		circle c(px[i], py[i], 0, pcost[i], i);
		events[ev++] = make_pair(c.x, make_pair(0, c));
	}
	sort(events, events + ev);
	set<arc, cmp> s;
	s.insert(arc(P[0], +1));
	s.insert(arc(P[0], -1));
	memset(parent, -1, sizeof(parent));

	memset(last, -1, sizeof(last));
	for (int i = 0; i < ev; i++) {
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
				if (inside(P[parent[it->c.id]], c)) {
					id = parent[it->c.id];
				}
				parent[c.id] = id;
				add_edge(id, c.id, c.cost);
				add_edge(c.id, id, c.cost);				
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
			if (inside(P[parent[it->c.id]], c)) {
				id = parent[it->c.id];
			}
			num[id] += c.cost;
		}
	}
}

long long totdown[MAX_N];
long long tot;
long long dfs1(int u, int pr = -1) {
	for (int i = last[u]; i >= 0; i = pred[i]) 
		if (V[i] != pr) {
  			totdown[u] += dfs1(V[i], u);
  		}
  	totdown[u] += num[u];
  	tot += num[u];
  	return totdown[u];
}

long long edges[MAX_N];
int cedges = 0;
void gen(int u, int pr = -1) {
	for (int i = last[u]; i >= 0; i = pred[i])
		if (V[i] != pr) {
			edges[cedges++] = min(tot - totdown[V[i]], totdown[V[i]]) * W[i];
	  		gen(V[i], u);
  		}
}

long long solve() {
	tot = 0;
	dfs1(0);
	gen(0);
	sort(edges, edges + cedges);
	long long res = 0;
	for (int i = 0; i < cedges - k; i++) res += edges[i];
	return res;
}

int main() {
	#ifndef SHTRIX
		freopen("camelot.dat", "rt", stdin);
		freopen("camelot.sol", "wt", stdout);
	#endif
	scanf("%d%d%d", &N, &M, &K);
	for (int i = 0; i < N; i++) {
		scanf("%d%d%d%d", &cx[i], &cy[i], &cr[i], &ccost[i]);
	}
	for (int i = 0; i < M; i++) {
		scanf("%d%d%d", &px[i], &py[i], &pcost[i]);
	}
	#ifdef SHTRIX
		cout << "INPUT DONE: " << double(clock()) / CLOCKS_PER_SEC << endl;
	#endif
	geom();
	#ifdef SHTRIX
		cout << "GEOM DONE: " << double(clock()) / CLOCKS_PER_SEC << endl;
	#endif
	cout << solve() << endl;
	#ifdef SHTRIX
		cout << "DONE: " << double(clock()) / CLOCKS_PER_SEC << endl;
	#endif
	return 0;
}
