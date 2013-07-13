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
int const X=37, M=0x40000000, N=3000005;
char s[N];
int n, rs[N];
long long p[N];
int h1[N], h2[N];
int wh[N];
void init() {
	p[0]=1, h1[0]=s[0], h2[n-1]=s[n-1];
	for (int i=1; i<n; i++) {
		p[i]=(p[i-1]*X & M-1);
		h1[i]=(h1[i-1]+p[i]*s[i] & M-1);
		h2[n-i-1]=(h2[n-i]+p[i]*s[n-i-1] & M-1);
	}
}
int hash1(int i, int j) {
	int res=h1[j];
	if(i>0) res=res-h1[i-1]+M;
	return res*p[n-i-1] & M-1;
}
int hash2(int i, int j) {
	int res=h2[i];
	if(j<n-1) res=res-h2[j+1]+M;
	return res*p[j] & M-1;
}
int palin(int i, int j) {
	return hash1(i, i+j>>1)==hash2(i+j+1>>1, j);
}
int rec(int k) {
	if (rs[k]) return rs[k];
	if (k==n) return 0;
	rs[k]=N;
	for (int j=k; j<n; j++)
		if(palin(k, j) && rs[k]>rec(j+1)+1) {
			rs[k]=rec(j+1)+1;
			wh[k]=j+1;
		}
	return rs[k];
}
int main () {
	freopen("palin.in", "r", stdin);
	freopen("palin.out", "w", stdout);
	scanf("%s", s);
	n=strlen(s);
	init();
	printf ("%d\n", rec(0));
	for (int i=0; i<n; i=wh[i]) {
		char t=s[wh[i]];
		s[wh[i]]='\0';
		puts(s+i);
		s[wh[i]]=t;
	}
	cerr << clock() << endl;
	return 0;
}
  