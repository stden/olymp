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

int a,b,c,d,i,j,n,m,k;
set<pii> q, global;
int mn[200002];
int main() {
	freopen("stones.dat","r",stdin);
	freopen("stones.sol","w",stdout);

	scanf("%d%d", &m, &n);
	memset(mn, 63, sizeof(mn));
	rept(i, m) {
		scanf("%d", &a);
		if (a == 1) {
			scanf("%d%d", &b, &c); --b;
			set<pii>::iterator it = q.insert(mp(b, c)).first;
			bool nmin = false;
			if (it != q.begin()) {
				--it;
				if (it->x != b) nmin = 1;
			} else nmin = 1;
			if (nmin) {
				if (mn[b] <= INF) global.erase(global.find(mp(mn[b], b)));
				global.insert(mp(c, b));
				mn[b] = c;
			}
		} else {
			pii t = *global.rbegin();
			printf("%d\n", t.x);
			swap(t.x, t.y);
			set<pii>::iterator it = q.lower_bound(t);
			++it;
			global.erase(--global.end());

			swap(t.x, t.y);
			if (it == q.end() || it->x != t.y) {
				--it;
				q.erase(it);
				mn[t.y] = INF + 1;
				continue;
			}
			mn[t.y] = it->y;
			--it;
			q.erase(it);
			global.insert(mp(mn[t.y], t.y));
		}
	}
}
