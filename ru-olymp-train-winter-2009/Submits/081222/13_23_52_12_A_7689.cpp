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
int const N=1<<17, K=6;
int a[N+N][K], p[N+N];
int k;
void init(int c=1) {
	if (c>=N) a[c][0]=1;
	else {
		init(c+c); init(c+c+1);
		a[c][0]=a[c+c][0]+a[c+c+1][0];
	}
}
inline void shift(int c, int s) {
	for (int x=0, y=k-1; x<y; x++, y--) swap(a[c][x], a[c][y]);
	for (int x=0, y=s-1; x<y; x++, y--) swap(a[c][x], a[c][y]);
	for (int x=s, y=k-1; x<y; x++, y--) swap(a[c][x], a[c][y]);
}
void inc(int x, int y, int L=0, int R=N-1, int c=1) {
	if (x>R || y<L) 
		return;
	if (x<=L && y>=R) {
		if (++p[c]==k) p[c]=0;
		shift(c, 1);
		return;
	}
	inc(x, y, L, L+R-1>>1, c+c);
	inc(x, y, L+R+1>>1, R, c+c+1);
	for (int i=0; i<k; i++)
		a[c][i]=a[c+c][i]+a[c+c+1][i];
	shift(c, p[c]);
}
int sum(int x, int y, int L=0, int R=N-1, int c=1) {
	int res=0;
	if (x>R || y<L) 
		return res;
	if (x<=L && y>=R) {
		for (int i=0; i<k; i++)
			res+=i*a[c][i];
		return res;
	}
	if ((p[c+c]+=p[c])>=k) p[c+c]-=k;
	if ((p[c+c+1]+=p[c])>=k) p[c+c+1]-=k;
	shift(c+c, p[c]);
	shift(c+c+1, p[c]);
	p[c]=0;
	res+=sum(x, y, L, L+R-1>>1, c+c);
	res+=sum(x, y, L+R+1>>1, R, c+c+1);
	return res;
}
int main () {
	freopen("sum.in", "r", stdin);
	freopen("sum.out", "w", stdout);
	int n, m;
	scanf ("%d%d%d", &n, &k, &m);
	if (double(n)*m<=2e8) {
		for (int i=0; i<m; i++) {
			int t, x, y;
			scanf ("%d%d%d", &t, &x, &y);
			if (t==1)
				for (int i=x; i<=y; i++)
					if (++p[i]==k) p[i]=0;
			else {
				int res=0;
				for (int i=x; i<=y; i++)
					res+=p[i];
				printf ("%d\n", res);
			}
		}
		return 0;
	}
	init();
	for (int i=0; i<m; i++) {
		int t, x, y;
		scanf ("%d%d%d", &t, &x, &y);
		if (t==1) inc(x, y);
		else printf ("%d\n", sum(x, y));
	}
	return 0;
}