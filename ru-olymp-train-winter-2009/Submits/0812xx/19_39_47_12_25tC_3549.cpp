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
int const SN=500, N=800000/SN+1;
int n, k[N], f[N], ff[N][SN], uu[N][SN];
void add(int x, int c) {
	int i, j=0;
	while(j<n && x>k[f[j]]) 
		x-=k[f[j++]];
	if (j==n) n++;
	if (k[f[j]]==SN) {
		int t=f[n];
		for (int i=n; i>j+1; i--)
			f[i]=f[i-1];
		f[j+1]=t;
		n++;
		k[f[j]]=k[f[j+1]]=SN/2;
		for (int i=0; i<k[f[j]]; i++) {
			ff[f[j+1]][i]=ff[f[j]][i+k[f[j]]];
			uu[f[j]][i]=ff[f[j]][i];
			uu[f[j+1]][i]=ff[f[j+1]][i];
		}
		sort(uu[f[j]], uu[f[j]]+k[f[j]]);
		sort(uu[f[j+1]], uu[f[j+1]]+k[f[j+1]]);
		if(x>k[f[j]]) 
			x-=k[f[j++]];
	}
	for (i=k[f[j]]; i>x; i--)
		ff[f[j]][i]=ff[f[j]][i-1];
	ff[f[j]][i]=c;
	for (i=k[f[j]]; i>0 && uu[f[j]][i-1]>c; i--)
		uu[f[j]][i]=uu[f[j]][i-1];
	uu[f[j]][i]=c;
	k[f[j]]++;
}
void rep(int x, int c) {
	int i, j=0;
	while(x>=k[f[j]]) 
		x-=k[f[j++]];
	for (i=k[f[j]]; uu[f[j]][i-1]>ff[f[j]][x]; i--);
	for (; i<k[f[j]]; i++)
		uu[f[j]][i-1]=uu[f[j]][i];
	for (i=k[f[j]]-1; i>0 && uu[f[j]][i-1]>c; i--)
		uu[f[j]][i]=uu[f[j]][i-1];
	ff[f[j]][x]=uu[f[j]][i]=c;
}
int sum(int x, int y, int p) {
	int i, j=0, res=0;
	while(x>=k[f[j]])
		x-=k[f[j]], y-=k[f[j++]];
	if (y<k[f[j]]) {
		for (i=x; i<=y; i++)
			res+=(ff[f[j]][i]<=p);
		return res;
	}
	for (i=x; i<k[f[j]]; i++)
		res+=(ff[f[j]][i]<=p);
	for(y-=k[f[j++]]; y>=k[f[j]]; y-=k[f[j++]])
		res+=upper_bound(uu[f[j]], uu[f[j]]+k[f[j]], p)-uu[f[j]];
	for (i=0; i<=y; i++)
		res+=(ff[f[j]][i]<=p);
	return res;
}
int main () {
	freopen("dynarray.in", "r", stdin);
	freopen("dynarray.out", "w", stdout);
	int n, m;
	scanf ("%d%d", &n, &m);
	for (int i=0; i<N; i++)
		f[i]=i;
	for (int i=0; i<n; i++) {
		int c; scanf ("%d", &c);
		add(i, c);
	}
	for (int i=0; i<m; i++) {
		int c, u, v, p;
		scanf ("%d", &c);
		if (c==1) {
			scanf ("%d%d", &u, &p);
			rep(u-1, p);
		}
		else if (c==2) {
			scanf ("%d%d", &u, &p);
			add(u, p);
		}
		else if (c==3) {
			scanf("%d%d%d", &u, &v, &p);
			printf ("%d\n", sum(u-1, v-1, p));
		}
	}
	return 0;
}
  