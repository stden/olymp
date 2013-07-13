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
int a[N][N], n, res=0x7fffffff, rmsk;
void rec(int i, int msk, int p) {
	if (!p) {
		int cur=0;
		for (int i=0; i<n; i++)
			for(int j=i+1; j<n; j++)
				cur+=(((msk>>i&1)^(msk>>j&1)) && a[i][j]);
		if (res>cur)
			res=cur, rmsk=msk;
		return;
	}
	for (i++; i+p<n; i++)
		rec(i, msk|1<<i, p-1);
}
int main () {
	freopen("half.in", "r", stdin);
	freopen("half.out", "w", stdout);
	int m; scanf ("%d%d", &n, &m);
	for (int i=0; i<m; i++) {
		int p, q; scanf ("%d%d", &p, &q);
		a[p-1][q-1]=a[q-1][p-1]=1;
	}
	rec(0, 1, n/2-1);
	for (int i=0; i<n; i++)
		if (rmsk>>i&1)
			printf ("%d ", i+1);
	return 0;
}
  