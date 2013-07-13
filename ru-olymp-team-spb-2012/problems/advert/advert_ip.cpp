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
#define EPS (1e-12)
#define INF ((int)1e9)
#define TASKNAME "advert"

struct rect {
  int x, y;
};

const int maxn = 100000;
rect a[maxn];

int n, w, h;
	
bool solve(double k) {
	bool last = 0;
 	double x = 0, y = 0;
 	for (int i = 0; i < n; i++) {
 		while ((last && a[i].y != a[i - 1].y) || x + k * a[i].x > w + EPS) {
 			if (!last)
 				return 0;
 			last = 0;
 			y += a[i - 1].y * k;
 			x = 0;
 		}
 		x += k * a[i].x, last = 1;
 	}
 	y += a[n - 1].y * k;
 	x = 0;
 	return y <= h + EPS;
}

int main() {
	freopen(TASKNAME".in", "r", stdin);
	freopen(TASKNAME".out", "w", stdout);

	while (scanf("%d%d%d", &n, &w, &h) >= 1) {
		for (int i = 0; i < n; i++) {
			scanf("%d%d", &a[i].x, &a[i].y);
		}
		double l = 0, r = 2e9;

		for (int iter = 0; iter < 100; iter++) {
			double m = (l + r) / 2;
			if (solve(m))
				l = m;
			else
				r = m;
		}

		printf("%.18lf\n", l);
		//break;
	}
	return 0;
}
