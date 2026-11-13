// score: 10
// square geometry + no nested circles greedyness
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

int N, M, K;
vector<int> cx, cy, cr, ccost;
vector<int> px, py, pcost;

int n, k;
vector<vector<int> > G, cost;
vector<int> num;

// point B is inside circle A
bool inside(int xa, int ya, int ra,
			int xb, int yb) {
	return (long long) (xa - xb) * (xa - xb) 
		 + (long long) (ya - yb) * (ya - yb) <= (long long) ra * ra;
}

void GSolve() {
	n = N + 1;
	k = K;
	G.assign(n, vector<int>());
	cost.assign(n, vector<int>());
	num.assign(n, 0);

	for (int i = 0; i < N; i++) {
		int minR = 1000000000, id = -1;
		for (int j = 0; j < N; j++)
			if (cr[i] < cr[j] && 
				inside(cx[j], cy[j], cr[j],
					   cx[i], cy[i])) {
				if (minR > cr[j]) {
					minR = cr[j];
					id = j;
				}
			}

		G[i + 1].push_back(id + 1);
		G[id + 1].push_back(i + 1);
		cost[i + 1].push_back(ccost[i]);
		cost[id + 1].push_back(ccost[i]);
	}
	for (int i = 0; i < M; i++) {
		int minR = 1000000000, id = -1;
		for (int j = 0; j < N; j++) {
			if (inside(cx[j], cy[j], cr[j],
					   px[i], py[i])) {
				if (minR > cr[j]) {
					minR = cr[j];
					id = j;
				}
			}
		}
		num[id + 1] += pcost[i];
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
	GSolve();
	cout << solveNoNested() << endl;
	return 0;
}