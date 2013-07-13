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
#include <cmath>
using namespace std;
set<int> res;
int ls(int *x, int *y) {
	return *x<*y;
}
int mul(int a, int b, int p) {
	return (long long)a*b%p;
}
int pow(int x, int k, int p) {
	if (!k) return 1;
	int res=x, l=k;
	while(l&l-1) l&=l-1;
	for (l>>=1; l; l>>=1) {
		res=mul(res, res, p);
		if (k&l)
			res=mul(x, res, p);
	}
	return res;
}
int pk(int p) {
	int x=p-1, z[100]; z[0]=0;
	for (int i=2; i*i<=x; i++)
		if (x%i==0) {
			z[++z[0]]=i;
			for (x/=i; x%i==0; x/=i);
		}
	if (x>1) z[++z[0]]=x;
	for (int i=1;;i++) {
		int f=1;
		for (int j=1; j<=z[0]; j++)
			if (pow(i, (p-1)/z[j], p)==1) {
				f=0; break;
			}
		if (f) 
			return i;
	}
}
int log(int a, int b, int p) {
	int d=sqrt(p)+1;
	int *f=new int[d], *g=new int[d];
	int **ff=new int*[d], **gg=new int*[d];
	f[0]=pow(a, d, p); ff[0]=f;
	for (int i=1; i<d; i++) {
		f[i]=mul(f[i-1], f[0], p);
		ff[i]=f+i;
	}
	g[0]=b; gg[0]=g;
	for (int i=1; i<d; i++) {
		g[i]=mul(g[i-1], a, p);
		gg[i]=g+i;
	}
	sort(ff, ff+d, ls);
	sort(gg, gg+d, ls);
	int i=0, j=0;
	while(i<d && j<d) {
		if (ff[i][0]<gg[j][0]) i++;
		else if (ff[i][0]>gg[j][0]) j++;
		else return ((ff[i]-f+1)*d-(gg[j]-g))%p;
	}
	return -1;
}
int main () {
	freopen("roots.in", "r", stdin);
	freopen("roots.out", "w", stdout);
	int p, k, a; 
	scanf ("%d%d%d", &p, &k, &a);
	k%=p-1;
	if (a==0) {
		printf ("1\n0");
		return 0;
	}
	int x=pk(p);
	long long y=log(x, a, p);
	if (y>=0) {
		for (int i=0; i<k; i++) {
			long long z=(long long)(p-1)*i+y;
			if (z%k==0)
				res.insert(pow(x, z/k, p));
		}
	}
	printf ("%d\n", res.size());
	for (set<int>::iterator i=res.begin(); i!=res.end(); i++)
		printf ("%d ", *i);
	return 0;
}
  