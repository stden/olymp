// score: 100
// fast sweepline + map
#include <iostream>
#include <algorithm>
#include <cstdio>
#include <cmath>
#include <set>
#include <vector>
#include <cstring>
#include <cassert>
#include <map>

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

class CMap {
  public:
	int k;
	map<long long, int> data;
	void ADD(long long key) {
		data[key]++;
	}
	void DEL(long long key) {
		map<long long, int>::iterator it = data.find(key);
		assert(it != data.end());
		it->second--;
		if (it->second == 0) {
			data.erase(it);
		}
	}
	long long kvalue, numPredKvalue, SUM;
	CMap() {}
	void assign(int _k, vector<long long> initvals) {
		k = _k;
		sort(initvals.begin(), initvals.end());
		kvalue = initvals[k - 1];
		for (int i = 0; i < initvals.size(); i++) ADD(initvals[i]);
		SUM = 0;
		for (int i = 0; i < k; i++) SUM += initvals[i];
		numPredKvalue = 0;
		for (map<long long, int>::iterator it = data.begin(); it != data.end(); it++)
			if (it->first < kvalue)
				numPredKvalue += it->second;
	}
	long long sum() { 
		return SUM; 
	}
	void add(long long x) {
		ADD(x);
		if (x < kvalue) {
			SUM = SUM - kvalue + x;
			if (numPredKvalue == k - 1) {
				map<long long, int>::iterator it = data.find(kvalue);
				it--;
				kvalue = it->first;
				numPredKvalue = k - it->second;
			} else {
				numPredKvalue++;
			}
		}
	}
	void erase(long long x) {
		if (x > kvalue) {
			DEL(x); return;
		}
		if (x < kvalue) {
			if (numPredKvalue - 1 + data[kvalue] < k) {
				map<long long, int>::iterator it = data.find(kvalue);
				it++;
				kvalue = it->first;
				SUM = SUM - x + kvalue;
				numPredKvalue = k - 1;
			} else {
				numPredKvalue--;
				SUM = SUM - x + kvalue;
			}
			DEL(x); return;
		}
		if (x == kvalue) {
			if (numPredKvalue + data[kvalue] - 1 < k) {
				map<long long, int>::iterator it = data.find(kvalue);
				it++;
				kvalue = it->first;
				numPredKvalue = k - 1;
				SUM = SUM - x + kvalue;
			} else {
				// DO NOTHING
			}

			DEL(x); return;
		} 
	}
};

long long res, tot;
vector<long long> down, initvals;
CMap m;
void upd(long long cnt) {
	if (res > cnt) res = cnt;
}
long long dfs0(int u, int pr = -1) {
	long long cur = num[u];
	for (int i = last[u]; i >= 0; i = pred[i]) 
		if (V[i] != pr) {
			long long d = dfs0(V[i], u);
			initvals.push_back(d * W[i]);
			cur += d;
		}
	return down[u] = cur;
}
void dfs(int u, int pr = -1) {
	upd(m.sum());
	for (int i = last[u]; i >= 0; i = pred[i])
		if (V[i] != pr) {
			long long cur_cost = W[i] * down[V[i]]; 
			long long new_cost = W[i] * (tot - down[V[i]]);
			m.add(new_cost);
			m.erase(cur_cost);
			dfs(V[i], u);
			m.add(cur_cost);
			m.erase(new_cost);
		}
}
long long solve() {
	down.assign(n, 0);
	dfs0(0);
	tot = down[0];

	m.assign(n - 1 - k, initvals);
	res = m.sum();
	if (k == n - 1) return res;
	dfs(0);
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
