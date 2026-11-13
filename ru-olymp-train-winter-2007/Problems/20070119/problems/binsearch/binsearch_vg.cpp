#define _CRT_SECURE_NO_DEPRECATE
#pragma comment (linker, "/STACK:30000000")
#include <iostream>
#include <cstdio>

using namespace std;

#define IN_FILE "input.txt"
#define OUT_FILE "output.txt"

#define EPS 1E-8
const int INF = (int)1E+9;

#define forn(i, n) for (int i = 0; i < (int)(n); ++i)
#define forv(i, v) for (int i = 0; i < (int)(v.size()); ++i)
#define fors(i, s) for (int i = 0; i < (int)(s.length()); ++i)
#define all(a) a.begin(), a.end()
#define pb push_back
#define PII pair<int, int>
#define mp make_pair
#define VI vector<int>
#define VS vector<string>

#define NMAX 110

typedef int SostAr[NMAX][NMAX][NMAX][2];

int ans, n;
SostAr d, p;

void outdata() {
}

int find(int n, int l, int r, bool alreadyLie) {
	if (r <= 0) {
		return find(n - l, 0, n - l, true);		
	}
	if (l >= n) {
		return find(r, 0, r, true);		
	}
	r = max(r, 0);
	l = min(l, n);
	int &res = d[n][l][r][alreadyLie];
	int &move = p[n][l][r][alreadyLie];
	if (res > -1) return res;
	if (n <= 1) {
		res = 0;
		move = 1;
		return 0;
	}
	res = INF;
	if (alreadyLie) {
		for(int i = 1; i < n; ++i) {
			int nres = max(find(i, 0, i, true), find(n - i, 0, n - i, true));
			if (res	> nres + 1) {
				res = nres + 1;
				move = i;
			}
		}
	} else {
		for(int i = 1; i < n; ++i) {
			int nres = INF;
			if (i <= min(l, r)) {
				nres = max(find(r, l, i, false), find(n - i, l - i, r - i, false));
			}
			if (i >= max(l, r)) {
				nres = max(find(i, l, r, false), find(n - l, i - l, r - l, false));
			}
			if (r == l) {
				int x = -1;
			}
			if (l < i && i < r) {
				nres = max(find(r, l, i, false), find(n - l, i - l, r - l, false));
			}
			if (r <= i && i <= l) {
				nres = max(find(r, 0, r, true), find(n - l, 0, n - l, true));
			}
			if (res	> nres + 1) {
				res = nres + 1;
				move = i;
			}				
		}
	}
	return res;
}

void solve() {
	memset(d, 255, sizeof(d));
	memset(p, 255, sizeof(p));
	//find(100, 1, 1, false);
	ans = find(n, 0, n, false);
	printf("%d %d\n", ans, p[n][0][n][false]);
}

void readdata() {
	scanf("%d", &n);
}

int main() {
//        freopen(IN_FILE, "rt", stdin);
//        freopen(OUT_FILE, "wt", stdout);
        readdata();
        solve();
        outdata();
        return 0;
}

