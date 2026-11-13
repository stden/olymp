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
pair<long long,long long> solve(int a, int b, int c) {
	if (!b) return make_pair(c, 0);
	pair<long long,long long> pr=solve(b, a%b, c);
	pr.first=(pr.second%b+b)%b;
	pr.second=(c-pr.first*a)/b;
	return pr;
}
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
	if (p==2) {
		for (int i=0; i<p-1; i++)
			if (pow(a, i, p)==b)
				return i;
		exit(1);
	}
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
		if (*ff[i]<*gg[j]) i++;
		else if (*ff[i]>*gg[j]) j++;
		else return ((ff[i]-f+1)*d-(gg[j]-g))%p;
	}
	exit(0);
}
int main () {
	freopen("roots.in", "r", stdin);
	freopen("roots.out", "w", stdout);
	int p, k, a; 
	scanf ("%d%d%d", &p, &k, &a);
	if (a==0) {
		printf ("1\n0\n");
		return 0;
	}
	int x=pk(p), y=log(x, a, p);
	if (pow(x, y, p)!=a)
		return 1;
	if (y>=0) {
		if ((p-1)%k==0) {
			if (y%k==0) {
				int z=solve(1, (p-1)/k, y/k).first;
				for (int i=0; i<k; i++)
					res.insert(pow(x, z+(p-1)/k*i, p));
			}
		}
		else {
			pair<long long,long long> z=solve(k, p-1, y);
			res.insert(pow(x, z.first, p));
		}
	}
	printf ("%d\n", res.size());
	for (set<int>::iterator i=res.begin(); i!=res.end(); i++) 
		printf ("%d ", *i);
	return 0;
}
  