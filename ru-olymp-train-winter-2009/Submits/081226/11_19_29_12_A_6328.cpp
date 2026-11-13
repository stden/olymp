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
long long a[100], b[100], xa[100], xb[100];
int x;
int xrec(int k, int r);
int rec(int k, int r) {
	if (r<=0) return 0;
	if (a[k]+b[k]<=r) return a[k]+b[k]+b[k];
	int res=0, xr=r;
	res+=rec(k-1, xr);
	xr-=a[k-1]+b[k-1];
	res+=rec(k-1, xr);
	xr-=a[k-1]+b[k-1];
	res+=xrec(k-1, xr);
	xr-=xa[k-1]+xb[k-1];
	res+=rec(k-1, xr);
	xr-=a[k-1]+b[k-1];
	res+=xrec(k-1, xr);
	xr-=xa[k-1]+xb[k-1];
	return res;
}
int xrec(int k, int r) {
	if (r<=0) return 0;
	if (xa[k]+xb[k]<=r) return xa[k]+xb[k]+xb[k];
	int res=0, xr=r;
	res+=rec(k-1, xr);
	xr-=a[k-1]+b[k-1];
	res+=rec(k-1, xr);
	xr-=a[k-1]+b[k-1];
	res+=xrec(k-1, xr);
	xr-=xa[k-1]+xb[k-1];
	res+=rec(k-1, xr);
	xr-=a[k-1]+b[k-1];
	res+=xrec(k-1, xr);
	xr-=xa[k-1]+xb[k-1];
	res+=rec(k-1, xr);
	xr-=a[k-1]+b[k-1];
	res+=xrec(k-1, xr);
	xr-=xa[k-1]+xb[k-1];
	return res;
}
int main () {
	freopen("digitsum.in", "r", stdin);
	freopen("digitsum.out", "w", stdout);
	a[0]=1, b[0]=0;
	xa[0]=0, xb[0]=1;
	for (x=0; a[x]+b[x]<1000000000; x++) {
		a[x+1]=3*a[x]+2*xa[x];
		b[x+1]=3*b[x]+2*xb[x];
		xa[x+1]=4*a[x]+3*xa[x];
		xb[x+1]=4*b[x]+3*xb[x];
	}
	int n; scanf ("%d", &n);
	for (int i=0; i<n; i++) {
		int l, r; scanf ("%d%d", &l, &r);
		printf ("%d\n", rec(x, r)-rec(x, l-1));
	}
	return 0;
}
  