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
#define TASKNAME "rebus"

const int maxs = 101;
char s[maxs];

int main() {
	freopen(TASKNAME".in", "r", stdin);
	freopen(TASKNAME".out", "w", stdout);


	while (scanf("%s", s) >= 1) {
		int pos = 0;
		for (int i = 0; s[i]; i++) {
			if ((int)s[i] == 39)
				pos--;
			else {
				if (pos >= 0)
					s[pos] = s[i];
				++pos;
			}
		}
		assert(pos >= 0);
		s[pos] = 0;
		printf("%s", s);
	}
	printf("\n");
	return 0;
}
