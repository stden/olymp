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
int const N=400005;
int a[N+N], be=N, en=N;
int main () {
	freopen("dynarray.in", "r", stdin);
	freopen("dynarray.out", "w", stdout);
	int n, m;
	scanf ("%d%d", &n, &m);
	for (int i=0; i<n; i++)
		scanf ("%d", a+be+i);
	en=be+n;
	for (int i=0; i<m; i++) {
		int c, u, v, p;
		scanf ("%d", &c);
		if (c==1) {
			scanf ("%d%d", &u, &p);
			a[be+u-1]=p;
		}
		if (c==2) {
			scanf ("%d%d", &u, &p);
			if (u+u<en-be) {
				for (int i=be; i<be+u; i++)
					a[i-1]=a[i];
				be--;
			}
			else {
				for (int i=en; i>be+u; i--)
					a[i]=a[i-1];
				en++;
			}
			a[be+u]=p;
		}
		if (c==3) {
			scanf ("%d%d%d", &u, &v, &p);
			int res=0;
			for (int x=u-1; x<v; x++)
				res+=(a[be+x]<=p);
			printf ("%d\n", res);
		}
	}
	return 0;
}
  