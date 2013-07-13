#define _CRT_SECURE_NO_DEPRECATE
#include <algorithm>
#include <string>
#include <set>
#include <map>
#include <vector>
#include <queue>
#include <iostream>
#include <iterator>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <sstream>
#include <fstream>
#include <ctime>
#include <cstring>
#include <functional>
#pragma comment(linker, "/STACK:66777216")
using namespace std;
#define pb push_back
#define ppb pop_back
#define pi 3.1415926535897932384626433832795028841971
#define mp make_pair
#define x first
#define y second
#define pii pair<int,int>
#define pdd pair<double,double>
#define INF 1000000000
#define FOR(i,a,b) for (int _n(b), i(a); i <= _n; i++)
#define FORD(i,a,b) for(int i=(a),_b=(b);i>=_b;i--)
#define all(c) (c).begin(), (c).end()
#define SORT(c) sort(all(c))
#define rep(i,n) FOR(i,1,(n))
#define rept(i,n) FOR(i,0,(n)-1)
#define L(s) (int)((s).size())
#define C(a) memset((a),0,sizeof(a))
#define VI vector <int>
#define ll long long

const int N = 300002;
const int M = 400002;
int a,b,c,d,i,j,n,m,k;
int ver[M + 1], nx[M + 1], last[N + 1], active[N + 1];
ll cs[M + 1], ds[N + 1];
inline void add_edge(int a, int b, int c) {
	ver[k] = b; cs[k] = c; nx[k] = last[a]; last[a] = k++;
}

priority_queue<pair<ll, int>, vector<pair<ll, int> >, greater<pair<ll, int> > > q;
void dijkstra() {
	memset(ds, 63, d * sizeof(ll));
	ds[0] = 0;
	q.push(mp(0LL, 0));
	while (!q.empty()) {
		int v = q.top().y;
		ll cd = q.top().x;
		q.pop();
		if (cd != ds[v]) continue;
		for (int w = last[v]; w >= 0; w = nx[w]) {
			if (ds[ver[w]] > ds[v] + cs[w]) {
				ds[ver[w]] = ds[v] + cs[w];
				q.push(mp(ds[ver[w]], ver[w]));
			}
		}
	}
}
int main() {
	freopen("olympair.dat","r",stdin);
	freopen("olympair.sol","w",stdout);

	scanf("%d%d", &n, &m);
	memset(last, -1, (2 * n + m + 1) * sizeof(int));
	rept(i, n) {
		active[i] = i + n;
	}
	
	k = 0;
	d = 2 * n;
	rept(i, m) {
		scanf("%d", &a);
		if (a == 1) {
			scanf("%d%d%d", &a, &b, &c); --a; --b;
			add_edge(active[a], b, c);
		} else {
			scanf("%d%d%d", &a, &b, &c); --a; --b;

			add_edge(active[b], active[a], c);
			add_edge(d, active[a], 0);
			active[a] = d++;
		}
	}

	rept(i, n) {
		add_edge(i, active[i], 0);
	}

	dijkstra();

	rep(i, n - 1) {
		if (ds[i] >= 4000000000000000000LL) ds[i] = -1;
		printf("%lld\n", ds[i]);
	}
}
