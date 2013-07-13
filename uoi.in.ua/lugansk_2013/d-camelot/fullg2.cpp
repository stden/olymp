// score: 35
// square geometry + square optimization
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
vector<vector<int> > G;
vector<vector<int> > cost;
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

vector<long long> totdown, edges;
vector<int> p;
long long dfs1(int u, int pr = -1) {
	p[u] = pr;
	for (int i = 0; i < G[u].size(); i++) 
		if (G[u][i] != pr) {
			totdown[u] += dfs1(G[u][i], u);
		}
	totdown[u] += num[u];
	return totdown[u];
}
void dfs2(int u, int pr = -1) {
	for (int i = 0; i < G[u].size(); i++) 
		if (G[u][i] != pr) {
			edges.push_back(totdown[G[u][i]] * cost[u][i]);
			dfs2(G[u][i], u);
	}
}
long long brute() {
	long long res = 9000000000000000000LL;
	for (int u = 0; u < n; u++) {
		totdown.assign(n, 0);
		edges.clear();
		p.assign(n, -1);
		dfs1(u);
		dfs2(u);
		sort(edges.begin(), edges.end());
		reverse(edges.begin(), edges.end());
		long long tot = 0;
		for (int i = k; i < n - 1; i++) tot += edges[i];
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
	GSolve();
	cout << brute() << endl;
	return 0;
}