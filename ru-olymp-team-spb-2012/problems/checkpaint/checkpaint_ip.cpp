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

typedef pair<int, int> pii;
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
#define TASKNAME "checkpaint"


int main() {
	freopen(TASKNAME".in", "r", stdin);
	freopen(TASKNAME".out", "w", stdout);

	int n, m;
	while (scanf("%d%d", &m, &n) >= 1) {
		vector<pii> ps(n);
		for (int i = 0; i < n; i++)
			scanf("%d%d", &ps[i].first, &ps[i].second), ps[i].first--;
		sort(ps.begin(), ps.end());
		
		int S = 0, last = 0;
		for (int i = 0; i < n; i++) {
			S += max(0, ps[i].second - max(ps[i].first, last));
			last = max(last, ps[i].second);
		}
		printf(S == m ? "YES\n" : "NO\n");
		//break;
	}
	return 0;
}
