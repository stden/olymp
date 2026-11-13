#include <iostream>
#include <algorithm>
#include <iomanip>
#include <functional>
#include <sstream>
#include <set>
#include <map>
#include <queue>
#include <memory.h>
#include <list>
using namespace std;
int const N=31;
int a[N][N], f[N], n, res=1000000, rmsk, xxx;
void out() {
	for (int i=0; i<n; i++)
		if (rmsk>>i&1)
			printf ("%d ", i+1);
	exit(0);
}
void rec(int cur, int i=0, int msk=1, int p=n/2-1) {
	if (!p) {
		if (res>cur) 
			res=cur, rmsk=msk;
		return;
	}
	if (!(++xxx&1023) && clock()>5.9*CLOCKS_PER_SEC) 
		out();
	for (i++; i+p<=n; i++) {
		int c=cur;
		for (int j=0; j<n; j++)
			if (a[f[i]][j])
				((msk>>j&1) ? c-- : c++);
		rec(c, i, msk|1<<f[i], p-1);
	}
}
int main () {
	freopen("half.in", "r", stdin);
	freopen("half.out", "w", stdout);
	int m; scanf ("%d%d", &n, &m);
	for (int i=0; i<m; i++) {
		int p, q; scanf ("%d%d", &p, &q);
		a[p-1][q-1]=a[q-1][p-1]=1;
	}
	int fst=0;
	for (int i=1; i<n; i++)
		fst+=a[0][i], f[i]=i;
	srand(747294103);
	random_shuffle(f+1, f+n);
	rec(fst);
	out();
}
  