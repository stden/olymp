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
#define TASKNAME "processing"

const int maxs = (1 << 16) + 1, maxl = 20;
char tmp[2][maxl][maxs];

void go1(int k, int l, int r, char *s, int ittmp) {
	assert(k >= 0 && k < maxl);
	if (l + 1 == r) {
		tmp[ittmp][k][l] = s[l];
		return;
	}
	int m = (l + r) / 2;
	go1(k - 1, l, m, s, ittmp);
	go1(k - 1, m, r, s, ittmp);
	bool needrev = 0;
	for (int i = l; i < m; i++)
		if (s[i] != s[i + (m - l)]) {
			needrev = s[i] > s[i + (m - l)];
			break;
		}
	if (needrev)
		for (int i = l; i < m; i++)
			swap(s[i], s[i + (m - l)]);		
	for (int i = l; i < r; i++)
		tmp[ittmp][k][i] = s[i];
}

char s[maxs], q[maxs];
char s1[maxs], q1[maxs];

int res[maxs - 1];

void want(int k, int l1, int r1, int l2, int r2, int li, int ri) {
	assert(k >= 0);
	if (l1 + 1 == r1)
		return;
	//eprintf("want(k = %d, s:[%d..%d)  q: [%d..%d)   res:[%d..%d))\n", k, l1, r1, l2, r2, li, ri);
	int m1 = (l1 + r1) / 2, m2 = (l2 + r2) / 2, mi = (li + ri - 1) / 2;
	int norotate = 1;
	for (int j = l1; j < m1; j++)
		if (tmp[0][k - 1][j] != tmp[1][k - 1][l2 + j - l1]) {
			norotate = 0;
			break;
		}
	//eprintf("norotate = %d\n", norotate);
	if (norotate) {		
		want(k - 1, l1, m1, l2, m2, li, mi);
		want(k - 1, m1, r1, m2, r2, mi, ri - 1);
	} else {
		want(k - 1, l1, m1, m2, r2, li, mi);
		want(k - 1, m1, r1, l2, m2, mi, ri - 1);
	}
	res[ri - 1] = !norotate;
}

void solve() {
  assert(scanf("%s%s", s, q) == 2);
  int n = strlen(s);
  int k;
  for (k = 0; (1 << k) < n; k++) ;

  memcpy(s1, s, sizeof(s[0]) * n);
  memcpy(q1, q, sizeof(q[0]) * n);
  go1(k, 0, n, s1, 0);
  go1(k, 0, n, q1, 1);
	//eprintf("%s %s\n", s, q);
	//eprintf("%s %s\n", s1, q1);
	/*
	for (int iter = 0; iter < 2; iter++) {
		for (int it = 0; it <= k; it++) {
			printf("%s\n", tmp[iter]);
		}
	} */
  if (strcmp(s1, q1)) {
  	printf("No\n");
  	return;
  }
  printf("Yes\n");
  want(k, 0, n, 0, n, 0, n - 1);	
  for (int i = 0; i < n - 1; i++)
  	printf("%d%c", res[i], " \n"[i == n - 2]);
}

int main() {
	freopen(TASKNAME".in", "r", stdin);
	freopen(TASKNAME".out", "w", stdout);

	int maxt;
	while (scanf("%d", &maxt) >= 1) {
		for (; maxt; maxt--) {
			solve();
		}
		//break;
	}
	return 0;
}
