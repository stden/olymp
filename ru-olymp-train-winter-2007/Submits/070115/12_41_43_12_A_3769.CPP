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

#define MAXN 10
#define HMOD1 17
#define HMOD2 97
#define HMOD3 239
#define HMOD4 997
#define HMOD 170239

int n;
string orient[MAXN], type[MAXN];
int x[MAXN], y[MAXN];

struct Position {

	char orient[MAXN], type[MAXN];
	int x[MAXN], y[MAXN];
	int target;
	int dist;

	bool compare1(int p, int q) {
		if (orient[p] != orient[q]) return orient[p] < orient[q];
		if (type[p] != type[q]) return type[p] < type[q];
		if (x[p] != x[q]) return x[p] < x[q];
		if (y[p] != y[q]) return y[p] < y[q];
		return false;
	}

	void clone(Position &r) {
		REPN(i, n) {
			r.orient[i] = orient[i];
			r.type[i] = type[i];
			r.x[i] = x[i];
			r.y[i] = y[i];
		}
		r.target = target;
	}

	void canonize() {
		int ind[MAXN];
		REPN(i, n) ind[i] = i;
		REPN(i, n - 1) FOR(j, i + 1, n - 1) if (compare1(ind[j], ind[i]))
			swap(ind[i], ind[j]);
		char orient1[MAXN], type1[MAXN];
		int x1[MAXN], y1[MAXN];
		int target1;
		REPN(i, n) {
			orient1[i] = orient[ind[i]];
			type1[i] = type[ind[i]];
			x1[i] = x[ind[i]];
			y1[i] = y[ind[i]];
			if (ind[i] == target) target1 = i;
		}
		target = target1;
		REPN(i, n) {
			orient[i] = orient1[i];
			type[i] = type1[i];
			x[i] = x1[i];
			y[i] = y1[i];
		}
	}

	bool equals(const Position &p) {
		REPN(i, n) {
			if (orient[i] != p.orient[i]) return false;
			if (type[i] != p.type[i]) return false;
			if (x[i] != p.x[i]) return false;
			if (y[i] != p.y[i]) return false;
		}
		return true;
	}

	int hash_code() {
		int r = 0;
		REPN(i, n) {
			r = (r * HMOD1 + orient[i]) % HMOD;
			r = (r * HMOD2 + type[i]) % HMOD;
			r = (r * HMOD3 + x[i]) % HMOD;
			r = (r * HMOD4 + y[i]) % HMOD;
		}
		return r;
	}

};

Position start;
queue<Position> q;
vector<Position> ht[HMOD];

void put(Position &p) {
	p.canonize();
	int hc = p.hash_code();
	REPS(i, ht[hc]) if (p.equals(ht[hc][i])) return;
	ht[hc].PB(p);
	q.push(p);
}

int main() {
	freopen("cars.in", "rt", stdin);
	freopen("cars.out", "wt", stdout);
	cin >> n;
	REPN(i, n) cin >> orient[i] >> x[i] >> y[i] >> type[i];
	REPN(i, n) {
		start.orient[i] = orient[i][0];
		start.type[i] = type[i][0];
		start.x[i] = x[i];
		start.y[i] = y[i];
	}
	start.target = 0;
	start.dist = 0;
	put(start);
	while (!q.empty()) {
		Position cpos = q.front();
		q.pop();
		if (cpos.y[cpos.target] == 5) {
			cout << cpos.dist << "\n";
			return 0;
		}
		int field[7][7];
		ZERO(field);
		REPN(i, n) {
			int x1 = cpos.x[i];
			int y1 = cpos.y[i];
			int len = 1;
			if (cpos.type[i] == 't') len++;
			int x2 = x1, y2 = y1;
			if (cpos.orient[i] == 'h') y2 += len;
			else x2 += len;
			FOR(j, x1, x2) FOR(k, y1, y2) field[j][k] = 1;
		}
		REPN(i, n) {
			Position next;
			int x1 = cpos.x[i];
			int y1 = cpos.y[i];
			int len = 1;
			if (cpos.type[i] == 't') len++;
			int x2 = x1, y2 = y1;
			if (cpos.orient[i] == 'h') y2 += len;
			else x2 += len;
			if (cpos.orient[i] == 'h') {
				int left = y1 - 1;
				while (left && !field[x1][left]) left--;
				int right = y2 + 1;
				while (right <= 6 && !field[x1][right]) right++;
				while (left + 1 < y1) {
					cpos.clone(next);
					next.y[i] = left + 1;
					next.dist = cpos.dist + 1;
					put(next);
					left++;
				}
				while (right - len - 1 > y1) {
					cpos.clone(next);
					next.y[i] = right - len - 1;
					next.dist = cpos.dist + 1;
					put(next);
					right--;
				}
			}
			else {
				int up = x1 - 1;
				while (up && !field[up][y1]) up--;
				int down = x2 + 1;
				while (down <= 6 && !field[down][y1]) down++;
				while (up + 1 < x1) {
					cpos.clone(next);
					next.x[i] = up + 1;
					next.dist = cpos.dist + 1;
					put(next);
					up++;
				}
				while (down - len - 1 > x1) {
					cpos.clone(next);
					next.x[i] = down - len - 1;
					next.dist = cpos.dist + 1;
					put(next);
					down--;
				}
			}
		}
	}
	cout << "-1\n";
	return 0;
}
