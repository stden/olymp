#include <iostream>
#include <algorithm>
#include <iomanip>
#include <functional>
#include <sstream>
#include <set>
#include <map>
#include <queue>
#include <cstring>
using namespace std;
int const N=10005;
int a[N], b[N];
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
int cmp(int *a, int *b) {
  if (a[0]!=b[0])
      return a[0]<b[0] ? -1 : 1;
  for (int i=a[0]; i>0; i--)
    if (a[i]!=b[i])
	return a[i]<b[i] ? -1 : 1;
   return 0;
}
void sub(int *a, int *b) {
  for (int i=1; i<=b[0]; i++)
    a[i]-=b[i];
  for (int i=1; i<=a[0]; i++)
    if (a[i]<0)
      a[i]+=10, a[i+1]--;
  while(a[0]>1 && a[a[0]]==0) 
    a[0]--;
}
int main () {
  freopen("aplusminusb.in", "r", stdin);
  freopen("aplusminusb.out", "w", stdout);
  get(a);
  get(b);
  if (cmp(a, b)<0) {
    printf ("-");
    sub(b, a);
    put(b);
  }
  else {
    sub(a, b);
    put(a);
  }
  return 0;
}
  