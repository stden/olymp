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
ll sm[2002][2002];
ll ds[2002];
bool used[2002];
int main() {
	freopen("olympair.dat","r",stdin);
	freopen("olympair.sol","w",stdout);

	scanf("%d%d", &n, &m);
	memset(sm, 63, sizeof(sm));
	rep(i, m) {
		scanf("%d", &a);
		if (a == 1) {
			scanf("%d%d%d", &a, &b, &c); --a; --b;
			sm[a][b] = min(sm[a][b], (ll)c);
		} else {
			scanf("%d%d%d", &a, &b, &c); --a; --b;
			rept(j, n) {
				sm[b][j] = min(sm[b][j], sm[a][j] + c);
			}
		}
	}
	
	memset(ds, 63, sizeof(ds));
	ds[0] = 0;
	rep(iter, n - 1) {
		ll mn = 4000000000000000000LL;
		int v = -1;
		rept(i, n) {
			if (!used[i] && ds[i] < mn) {
				mn = ds[i];
				v = i;
			}
		}
		if (v == -1) break;
		used[v] = 1;
		rept(i, n) {
			if (ds[i] > ds[v] + sm[v][i]) {
				ds[i] = ds[v] + sm[v][i];
			}
		}
	}


	rep(i, n - 1) {
		if (ds[i] >= 4000000000000000000LL) ds[i] = -1;
		printf("%lld\n", ds[i]);
	}
}
