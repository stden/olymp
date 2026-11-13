// score: 10
// square geometry + linear K = 0 solution
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
	cout << solveK0() << endl;
	return 0;
}