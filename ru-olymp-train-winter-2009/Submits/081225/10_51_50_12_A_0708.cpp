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
int const X=37, M=0x40000000, N=1000005;
char s[N];
int n, rs[N], ls[N];
int p[N], h1[N], h2[N];
void init() {
	p[0]=1, h1[0]=s[0], h2[n-1]=s[n-1];
	for (int i=1; i<n; i++) {
		p[i]=((long long)p[i-1]*X & M-1);
		h1[i]=(h1[i-1]+(long long)p[i]*s[i] & M-1);
		h2[n-i-1]=(h2[n-i]+(long long)p[i]*s[n-i-1] & M-1);
	}
}
inline int hash1(int i, int j) {
	int res=h1[j];
	if(i>0) res=res-h1[i-1]+M;
	return (long long)res*p[n-i-1] & M-1;
}
inline int hash2(int i, int j) {
	int res=h2[i];
	if(j<n-1) res=res-h2[j+1]+M;
	return (long long)res*p[j] & M-1;
}
inline int palin(int i, int j) {
	return hash1(i, i+j>>1)==hash2(i+j+1>>1, j);
}
void f(int k) {
	for (int j=k; j<n; j++)
		if(rs[j+1]>rs[k]+1 && palin(k, j))
			rs[j+1]=rs[k]+1, ls[j+1]=k;
}
int main () {
	freopen("palin.in", "r", stdin);
	freopen("palin.out", "w", stdout);
	gets(s); n=strlen(s);
	reverse(s, s+n);
	init();
	memset(rs+1, 63, n*sizeof(rs[0]));
	for (int i=0; i<n; f(i++));
	printf ("%d\n", rs[n]);
	for (int i=n; i>0; i=ls[i]) {
		puts(s+ls[i]);
		s[ls[i]]='\0';
	}
	cerr << clock() << endl;
	return 0;
}
  