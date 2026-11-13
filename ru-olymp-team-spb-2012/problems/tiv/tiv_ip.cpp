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
#define TASKNAME "tiv"

int perm[10];

const int maxn = 10;
char s[maxn][10];
int lens[maxn];

int main() {
	freopen(TASKNAME".in", "r", stdin);
	freopen(TASKNAME".out", "w", stdout);

	int n;
	while (scanf("%d", &n) >= 1) {
		assert(n <= maxn);
		for (int i = 0; i < n; i++) {
			scanf("%s", s[i]);
			lens[i] = strlen(s[i]);
			assert(lens[i] <= 9);
		}

		for (int i = 0; i < 10; i++)
			perm[i] = i;
		
		bool found = 0;
		do {
			bool ok = 1;
			int last = -1;
		  for (int i = 0; i < n; i++) {
		  	int cur = 0;
		  	for (int j = 0; j < lens[i]; j++)
		  		cur = 10 * cur + perm[s[i][j] - 'a'];

		  	if (lens[i] > 1 && !perm[s[i][0] - 'a']) {
		  		ok = 0;
		  		break;
		  	}
		  	if (cur <= last) {
		  		ok = 0;
		  		break;
		  	}
		  	last = cur;
		  }

		  if (ok) {
		  	found = 1;
		  	printf("Yes\n");
		  	for (int i = 0; i < 10; i++)
		  		printf("%d%c", perm[i], " \n"[i == 9]);
		  	break;
		  }
		} while(next_permutation(perm, perm + 10));
		
		if (!found)
			printf("No\n");
		//break;
	}
	return 0;
}
