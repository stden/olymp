#define _CRT_SECURE_NO_DEPRECATE
#pragma comment (linker, "/STACK:30000000")
#include <iostream>
#include <cstdio>

using namespace std;

#include "binsearch.h"


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

int ans;
SostAr d, p;
int gn, gl, gr, first;
int sn;
bool galreadyLie;

void outdata() {
}

void newState(int n, int l, int r, bool alreadyLie) {
	gn = n;
	gl = l;
	gr = r;
	galreadyLie = alreadyLie;
}

int find(int n, int l, int r, bool alreadyLie) {
	if (r <= 0) {
		return find(n - l, 0, n - l, true);
	}
	if (l >= n) {
		return find(r, 0, r, true);
	}
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

static void makeAnswer(int n, int l, int r, bool alreadyLie, int i, bool ans) {
	if (r <= 0) {
		first += l;
		makeAnswer(n - l, 0, n - l, true, i, ans);
		return ;
	}
	if (l >= n) {
		makeAnswer(r, 0, r, true, i, ans);
		return ;
	}
	if (n <= 1) {
		newState(n, l, r, alreadyLie);
		return ;
	}
	if (alreadyLie) {
   		if (ans) {
			newState(i, 0, i, true);
			return ;
   		} else {
   			first += i;
			newState(n - i, 0, n - i, true);
			return ;
   		}
	} else {
   		if (i <= min(l, r)) {
   			if (ans) {
   				newState(r, l, i, false);
   				return ;
   			} else {
   				first += i;
   				newState(n - i, l - i, r - i, false);
   				return ;
   			}
   		}
   		if (i >= max(l, r)) {
   			if (ans) {
   				newState(i, l, r, false);
   				return ;
   			} else {
   				first += l;
   				newState(n - l, i - l, r - l, false);
   				return ;
   			}
   		}
   		if (l < i && i < r) {
   			if (ans) {
				newState(r, l, i, false);
				return ;
   			} else {
   				first += l;
   				newState(n - l, i - l, r - l, false);
   				return ;
   			}
   		}
   		if (r <= i && i <= l) {
   			if (ans) {
   				newState(r, 0, r, true);
				return ;
   			} else {
   				first += l;
   				newState(n - l, 0, n - l, true);
				return ;
   			}
   		}
	}
}

void normalize() {
	if (gr <= 0) {
		first += gl;
		newState(gn - gl, 0, gn - gl, true);
	}
	if (gl >= gn) {
		newState(gr, 0, gr, true);
	}
}

void solve() {
	sn++;
	gn = sn;
	gl = 0;
	gr = sn;
	first = 0;
	galreadyLie = false;
	memset(d, 255, sizeof(d));
	memset(p, 255, sizeof(p));
	while (gn > 1) {
		normalize();
		printf("=== %d %d %d %d %d\n", gn, gl, gr, galreadyLie, first);
		ans = find(gn, gl, gr, galreadyLie);
		int i = p[gn][gl][gr][false] + first;
		printf("%d %d\n", ans, i);
        makeAnswer(gn, gl, gr, galreadyLie, i - first, query(i));
	}
	answer(first + 1);
}

void readdata() {
	sn = getN();
}

int main() {
        readdata();
        solve();
        outdata();
        return 0;
}

