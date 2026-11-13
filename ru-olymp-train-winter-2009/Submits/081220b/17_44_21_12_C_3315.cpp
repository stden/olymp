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
int const N=105;
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
void shift(int *b, int *a, int k) {
  if (k>0) {
    for (int i=1; i<=a[0]; i++)
      b[i+k]=a[i];
    for (int i=1; i<=k; i++)
      b[i]=0;
    b[0]=a[0]+k;
  }
  else {
    b[1]=0;
    for (int i=1-k; i<=a[0]; i++)
      b[i+k]=a[i];
    b[0]=max(1, a[0]+k);      
  }
}
int a[N], b[N];
int res[N], sb[10][N], aa[N], c[N];
  
int main () {
  freopen("division.in", "r", stdin);
  freopen("division.out", "w", stdout);
  get(a);
  get(b);
  if (cmp(a, b)<0) {
    put(a);
    printf (" |");
    put(b);
    printf ("\n");
    for (int i=0; i<=a[0]; i++)
      printf (" ");
    printf("+");
    for (int i=0; i<b[0]; i++)
      printf ("-");
    printf ("\n");
    for (int i=0; i<=a[0]; i++)
      printf (" ");
    printf ("|0");
    printf ("\n");
    return 0;
  }
  sb[0][0]=1;
  for(int i=1; i<10; i++) {
    memcpy(sb[i], sb[i-1], sizeof sb[i-1]);
    sum(sb[i], b);
  }  
  memcpy(aa, a, sizeof a);
  for (int k=a[0]-b[0]; k>=0; k--) {
    shift(c, aa, -k);
    for (res[k]=0; res[k]<9 && cmp(c, sb[res[k]+1])>=0; res[k]++);
    shift(c, sb[res[k]], k);
    sub(aa, c);
  } 
  memcpy(aa, a, sizeof a);
  put(a);
  printf (" |");
  put(b);
  printf ("\n");
  int k, kkk; for (k=a[0]-b[0]; !res[k]; k--);
  kkk=k;
  int x=0;
  x=a[0]-k-sb[res[k]][0];
  for (int i=0; i<x; i++)
    printf (" ");
  for (int i=sb[res[k]][0]; i>0; i--)
    printf ("%d", sb[res[k]][i]);
  for (int i=0; i<=k; i++)
    printf (" ");
  printf ("+");
  for(int i=0; i<b[0] || i<=k; i++)
    printf("-");
  printf ("\n");
  shift(c, sb[res[k]], k);
  sub(aa, c);
  for (--k; k>=0 && !res[k]; k--);
  for (int i=0; i<a[0]-max(0, k); i++)
    printf ("-");
  for (int i=0; i<=max(0, k); i++)
    printf (" ");
  printf ("|");
  for (int i=kkk; i>=0; i--)
    printf ("%d", res[i]);
  printf ("\n");
  while(k>=0) {
    for (int i=0; i<a[0]-aa[0]; i++)
      printf (" ");
    for (int i=aa[0]; i>k; i--)
      printf ("%d", aa[i]);
    printf ("\n");
    x=a[0]-k-sb[res[k]][0];
    for (int i=0; i<x; i++)
	printf (" ");
    for (int i=sb[res[k]][0]; i>0; i--)
      printf ("%d", sb[res[k]][i]);
    int ddd=a[0]-aa[0];
    printf ("\n");
    shift(c, sb[res[k]], k);
    sub(aa, c);
    for (--k; k>=0 && !res[k]; k--);
    for (int i=0; i<ddd; i++)
      printf (" ");
    for (int i=ddd; i<a[0]-max(0, k); i++)
      printf ("-");
    printf ("\n");
  }
  for (int i=0; i<a[0]-aa[0]; i++)
      printf (" ");
  for (int i=aa[0]; i>0; i--)
    printf ("%d", aa[i]);
  printf ("\n");
  return 0;
}
  