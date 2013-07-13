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
int const N=501, bs=100000000, K=51;
int n, t;
void sum(int *z, int *a) {
	if (z[0]<a[0]) {
		for (int i=1; i<=z[0]; i++) 
			z[i]+=a[i];
		for (int i=z[0]+1; i<=a[0]; i++) 
			z[i]=a[i];
		z[0]=a[0];
	}
	else
		for (int i=1; i<=a[0]; i++) 
			z[i]+=a[i];
	for (int i=1; i<z[0]; i++)
		if (z[i]>=bs)
			z[i]-=bs, z[i+1]++;
	if (z[z[0]]>=bs)
		z[z[0]]-=bs, z[++z[0]]=1;
}
void mullong(int *r, int *z, int *a) {
	long long t[K];
	if (!z[0] || !a[0]) {
		r[0]=0; return;
	}
	memset(t, 0, (z[0]+a[0])*sizeof(t[0]));
	for (int i=1; i<=z[0]; i++)
		for (int j=1; j<=a[0]; j++)
			t[i+j-2]+=(long long)z[i]*a[j];
	r[0]=z[0]+a[0]-1;
	for (int i=0; i<r[0]; i++) {
		int p=t[i]/bs; t[i+1]+=p;
		r[i+1]=t[i]-(long long)p*bs;
	}
	if (t[r[0]])
		r[r[0]+1]=t[r[0]], r[0]++;
}
void put(int *a) {
	printf ("%d", a[a[0]]);
	for (int i=a[0]-1; i>0; i--)
		printf ("%08d", a[i]);
}
int a[N][K], b[N][N][K], res[K];
int main () {
	freopen("btrees.in", "r", stdin);
	freopen("btrees.out", "w", stdout);
	scanf ("%d%d", &n, &t);
	if (n<t-1) {
		printf ("0");
		return 0;
	}
	for (int i=t-1; i<=t+t-1 && i<=n; i++)
		a[i][0]=a[i][1]=1;
	sum(res, a[n]);
	for (int k=1; k<10; k++) {
		for (int i=1; i<=n; i++) {
			memcpy(b[i][1], a[i], (a[i][0]+1)*sizeof(a[i][0]));
			for (int j=2; j<=t+t && j<=i; j++) {
				b[i][j][0]=0;
				for (int k=1; k<i && i-k>=j-1; k++) {
					int t[K]; 
					mullong(t, b[i-k][j-1], a[k]);
					sum(b[i][j], t);
				}
			}
		}
		for (int i=1; i<=n; i++) {
			a[i][0]=0;
			for (int j=t; j<=t+t && j<=i; j++)
				sum(a[i], b[i][j]);
		}
		sum(res, a[n]);
	}
	put(res);
	fprintf (stderr, "%d\n", clock());
	return 0;
}
  