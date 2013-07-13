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
int const N=205;
int a[N], b[N], one[]={1, 1}, three[]={1, 3};
void get(int *a) {
  char s[N];
  scanf("%s", s);
  int n=strlen(s);
  a[0]=n;
  for (int i=1; i<=n; i++)
    a[i]=s[n-i]-'0';
}
void put(int *a) {
  for (int i=a[0]; i>0; i--)
    printf ("%d", a[i]);
}
void sub(int *a, int *b) {
  for (int i=1; i<=b[0]; i++)
    a[i]-=b[i];
  for (int i=1; i<=a[0]; i++)
    if (a[i]<0)
      a[i]+=10, a[i+1]--;
  while(a[0]>1 && !a[a[0]]) 
    a[0]--;
}
void sum(int *a, int *b) {
  for (int i=1; i<=b[0]; i++)
    a[i]+=b[i];
  if (b[0]>a[0]) 
    a[0]=b[0];
  for (int i=1; i<=a[0]; i++)
    if (a[i]>=10)
      a[i]-=10, a[i+1]++;
  if (a[a[0]+1])
    ++a[0];
}
int div(int *a, int b) {
	int k=0;
	for (int i=a[0]; i>0; i--) {
		k=k*10+a[i];
		a[i]=k/b;
		k%=b;
	}
	if (a[0]>1 && !a[a[0]])
		a[0]--;
	return k;
}
void mullong(int *a, int *b) {
	int c[N];
	memset(c, 0, sizeof c);
	c[0]=a[0]+b[0];
	for (int i=1; i<=a[0]; i++)
		for (int j=1; j<=b[0]; j++)
			c[i+j-1]+=a[i]*b[j];
	for(int i=1; i<=c[0]; i++) {
		a[i]=c[i]%10;
		c[i+1]+=c[i]/10;
	}
	a[0]=c[0];
	if (a[0]>1 && !a[a[0]])
		--a[0];
}
int main () {
	freopen("room.in", "r", stdin);
	freopen("room.out", "w", stdout);
	get(a);
	sub(a, one);
	int z=div(a, 3);
	memcpy(b, a, sizeof a);
	sum(a, one);
	mullong(a, b);
	mullong(a, three);
	sum(a, one);
	sum(b, b);
	while(z) {
		sum(b, one);
		sum(a, b);
		z--;
	}
	put(a);
	return 0;
}
  