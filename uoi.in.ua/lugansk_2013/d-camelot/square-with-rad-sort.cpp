// score: 35
// square geometry with optimizations + linear optimization
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

struct circle {
	int x, y, r, w;
};
inline bool operator <(const circle &a, const circle &b) {
	if (a.r != b.r) return a.r < b.r; else
	if (a.w != b.w) return a.w < b.w; else
	if (a.x != b.x) return a.x < b.x; else
	return a.y < b.y;
}

int a,b,c,d,i,j,n,m,k;
circle cir[50002];
pii pnt[50002];
vector<pii> sm[50002];
int wg[50002];
ll cs[50002], cnt[50002], sum;
ll res[50002];
void dfs(int v) {
	cs[v] = cnt[v];
	rept(i, L(sm[v])) {
		int w = sm[v][i].x;
		dfs(w);
		cs[v] += cs[w];
	}

	rept(i, L(sm[v])) {
		int w = sm[v][i].x;
		res[k++] = (ll)sm[v][i].y * min(sum - cs[sm[v][i].x], cs[sm[v][i].x]);
	}
}
int main() {
	freopen("camelot.dat","r",stdin);
	//freopen("input.txt", "r", stdin);
	freopen("camelot.sol","w",stdout);

	scanf("%d%d%d", &n, &m, &c);
	rept(i, n) {
		scanf("%d%d%d%d", &cir[i].x, &cir[i].y, &cir[i].r, &cir[i].w);
	}
	sort(cir, cir + n);
	rept(i, m) {
		scanf("%d%d%d", &pnt[i].x, &pnt[i].y, &wg[i]);
	}

	sum = 0;

	int t = 0;
	rept(i, n) {
		int p = -1;
		while (t < n && cir[i].r >= cir[t].r) ++t;
		FOR(j, t, n - 1) {
			if (cir[i].r >= cir[j].r) continue;
			ll d = (ll)(cir[i].x - cir[j].x) * (cir[i].x - cir[j].x) + (ll)(cir[i].y - cir[j].y) * (cir[i].y - cir[j].y);
			if (d <= (ll)(cir[i].r + cir[j].r) * (cir[i].r + cir[j].r) && (p == -1 || cir[j].r < cir[p].r)) {
				p = j;
				break;
			}
		}
		sm[p + 1].pb(mp(i + 1, cir[i].w));
	}

	rept(j, m) {
		int p = -1;
		rept(i, n) {
			ll d = (ll)(cir[i].x - pnt[j].x) * (cir[i].x - pnt[j].x) + (ll)(cir[i].y - pnt[j].y) * (cir[i].y - pnt[j].y);
			if (d <= (ll)cir[i].r * cir[i].r && (p == -1 || cir[i].r < cir[p].r)) {
				p = i;
				break;
			}
		}
		cnt[p + 1] += wg[j];
		sum += wg[j];
	}

	dfs(0);
	sort(res, res + k);
	
	c = min(c, n);
	ll ans = 0;
	FORD(i, n - 1, 0) {
		if (c) {
			--c;
			continue;
		}
		ans += res[i];
	}

	cout << ans << endl;
}
