#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <algorithm>
#include <cstring>
#include <string>
#include <vector>
#include <cassert>
#include <iostream>
#include <set>
#include <map>

using namespace std;

#ifdef WIN32
	#define LLD "%I64d"
#else
	#define LLD "%lld"
#endif

typedef long long ll;
typedef vector<int> vi;
typedef vector<vi> vvi;
typedef vector<bool> vb;
typedef vector<vb> vvb;
typedef vector<ll> vll;
typedef vector<vll> vvll;

#define eprintf(...) fprintf(stderr, __VA_ARGS__)
#define mp make_pair
#define pb push_back
#define sz(x) ((int)(x).size())
#define EPS (1e-9)
#define INF ((int)1e9)
#define TASKNAME "half"

const int maxn = 2001;
bool can[maxn];

int main() {
	freopen(TASKNAME".in", "r", stdin);
	freopen(TASKNAME".out", "w", stdout);

	int n, m;
	while (scanf("%d%d", &n, &m) >= 1) {
		memset(can, 0, sizeof(can));
		can[2 * n] = 1;
		for (int iter = 0; iter < m; iter++) {
			for (int i = 1; i <= 2 * n; i++) {
				if (!can[i])
					continue;
				if (!(i & 1))
					can[i >> 1] = 1;
				can[i - 1] = 1;
				can[i] = 0;
			}	
		}
		vector<double> res;
		for (int i = 0; i <= 2 * n; i++)
			if (can[i])
				res.pb(i / 2.0);
		printf("%d\n", sz(res));
		for (int i = 0; i < sz(res); i++)
			printf("%.1lf%c", res[i], " \n"[i == sz(res) - 1]); 
		//break;
	}
	return 0;
}
