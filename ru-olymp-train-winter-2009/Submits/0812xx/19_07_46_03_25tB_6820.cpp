#include <cstdio>
#include <vector>
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iostream>

using namespace std;

#define taskname "btrees"
#define LMAX 60
#define base 10000

int s[2][501][LMAX];
int cnt[2][501][50][LMAX];

int print (int a[]) {
  for (int i = a[0]; i > 0; i--) {
    int tmp = 10;
    if (i < a[0])
      for (; max (a[i], 1) < base / tmp; tmp *= 10) printf ("0");
    printf ("%d", a[i]);
  }
  printf ("\n");
  return 0;
}

int cpy (int *a, int *b) {
  for (int i = 0; i <= a[0]; i++)
    b[i] = a[i];
  return 0;
}

int normalize (int* a) {
  int n = a[0];
  int r = 0; 
  for (int i = 1; i <= n; i++) {
    a[i] += r;
    r = 0;
    if (a[i] < 0) {
      a[i] += base;
      r = -1;
    }
    if (a[i] >= base) {
      r = a[i] / base;
      a[i] %= base;
    }
  }
  while (r) {
    n++;
    a[n] = r % base;
    r /= base;
  }
  while (n > 1 && !a[n]) n--;
  a[0] = n;
  return 0;
}

int mul (int a[], int b[], int* d) {
  int c[LMAX];
  memset (c, 0, sizeof (c));
  c[0] = a[0] + b[0];
  for (int i = 1; i <= a[0]; i++)
    for (int j = 1; j <= b[0]; j++) {
      c[i + j - 1] += a[i] * b[j];
      c[i + j] += c[i + j - 1] / base;
      c[i + j - 1] %= base;
    }
  normalize (c);
  cpy (c, d);
  return 0;
}

int add (int a[], int b[], int* c) {
  int d[LMAX];
  d[0] = max (a[0], b[0]);
  for (int i = 1; i <= d[0]; i++) d[i] = int (i <= a[0]) * a[i] + int (i <= b[0]) * b[i];
  normalize (d);
  cpy (d, c);
  return 0;
}

int one (int *a) {
  int b[LMAX];
  b[0] = 1;
  b[1] = 1;
  cpy (b, a);
  return 0;
}

int empty (int *a) {
  return (a[0] == 0 || a[0] == 1 && a[1] == 0);
}

int mul ();

int main () {
  freopen (taskname".in", "rt", stdin);
  freopen (taskname".out", "wt", stdout);
  int n, t;
  scanf ("%d%d", &n, &t);
  if (t - 1 > n) {
    printf ("0\n");
    return 0;
  }
  memset (cnt, 0, sizeof (cnt));
  int cur = t - 1;
  int cur2 = t * 2 - 1;
  int ans[LMAX];
  int tmp[LMAX];
  memset (ans, 0, sizeof (ans));
  ans[0] = 1;
  for (int l = 0; ; l++) {
    int ci = l % 2;
    int pi = 1 - ci;
    memset (cnt[ci], 0, sizeof (cnt[ci]));
    memset (s[ci], 0, sizeof (s[ci]));
    if (l == 0) {
      for (int i = cur; i <= cur2; i++)
	one (cnt[ci][i][1]);
      for (int i = cur; i <= cur2; i++)
	one (s[ci][i]);
    } else {
      one (cnt[ci][0][0]);
      for (int i = 1; i <= cur2 && i <= n; i++)
	for (int j = 1; j <= 2 * t; j++) {
	  for (int k = 1; k <= i; k++) 
	    if (!empty (cnt[ci][i - k][j - 1]) && !empty (s[pi][k])) { 
	      mul (cnt[ci][i - k][j - 1], s[pi][k], tmp);
	      add (cnt[ci][i][j], tmp, cnt[ci][i][j]);
	    }
//	  printf ("%d %d - " , i, j);
//	  print (cnt[ci][i][j]);
	 }
      for (int i = 1; i <= n; i++)
	for (int j = t; j <= 2 * t; j++) 
	  if (!empty (cnt[ci][i][j]))
	    add (s[ci][i], cnt[ci][i][j], s[ci][i]);
    }
/*    printf ("%d:\n", l);
    for (int i = 1; i <= n; i++) {
      printf ("%d - ", i);
      print (s[ci][i]);
    }*/
    add (ans, s[ci][n], ans);
    if (cur > n / t) break;
    cur *= t;
    cur2 *= 2 * t;
  }
  print (ans);
//  printf ("%lld\n", ans);
}