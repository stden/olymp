#define _CRT_SECURE_NO_DEPRECATE
#pragma comment (linker, "/STACK:30000000")
#include <iostream>
#include <cstdio>

using namespace std;

#include "binsearch.h"

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

int n;

void outdata() {
}

void solve() {
	memset(d, 255, sizeof(d));
	memset(p, 255, sizeof(p));
	//find(100, 1, 1, false);
	int l = 1, r = n, k = 0;
	while (l < r) {
		cerr << l << " " << r << " " << k << endl;
		int mid = (l + r) / 2;
		if (r - l <= 5) answer(mid);
		bool res = query(mid);
		if (k > 0) {
			if (res) r = mid; else l = mid + 1;
		} else {
			bool res1 = query(mid);
			if (res == res1) {
				if (res) r = mid; else l = mid + 1;
			} else {
				++k;
				res = query(mid);
				if (res) r = mid; else l = mid + 1;
			}
		}
	}
	answer(l);
}

void readdata() {
	//scanf("%d", &n);
	n = getN();
	++n;
}

int main() {
        readdata();
        solve();
        outdata();
        return 0;
}

