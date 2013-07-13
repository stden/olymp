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
#define TASKNAME "vikings"

int main() {
	freopen(TASKNAME".in", "r", stdin);
	freopen(TASKNAME".out", "w", stdout);

	double R, L;
	while (scanf("%lf%lf", &R, &L) >= 1) {
		double cosa = max(-1.0, 1.0 - L * L / 2 / R / R);
		printf("%.18lf %.18lf\n%.18lf %.18lf\n", R, 0.0, R * cosa, R * sqrt(max(0.0, 1 - cosa * cosa)));
		//break;
	}
	return 0;
}
