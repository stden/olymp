#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>
#include <ctime>
#include <iostream>

using namespace std;

const int maxkkk = 10000;

int start;
int ans, amask;
int n, m;
int q[30];
int v[30][30];
int n2;
int nn;
int p[30], pp[30];
int kkk;
int fin;

int calc (int i, int mask, int a, int b, int c) {
//  printf ("%d %d %d %d %d\n", i, mask, a, b, c);
  kkk++;
  if (kkk == maxkkk) {
    if (clock () - start > 5500000) {
      fin = 1;
      return 0;
    }
    kkk = 0;
  }
  if (i == n) {
    ans = c;
    amask = mask;
    return 0;
  }
  if (a < n2 && b < n2) {
    int s0 = 0;
    int s1 = 0;
    for (int j = 0; j < q[i]; j++)
      if ((mask >> v[i][j]) & 1) s1++; else s0++;
    if (c + s1 < ans) calc (i + 1, mask, a + 1, b, c + s1);
    if (fin) return 0;
    if (c + s0 < ans) calc (i + 1, mask + (1 << i), a, b + 1, c + s0);
    if (fin) return 0;
    return 0;
  }
  if (a < n2) {
    int s1 = 0;
    for (int k = i; k < n; k++)
      for (int j = 0; j < q[k] && v[k][j] < i; j++)
	if ((mask >> v[k][j]) & 1) {
	  s1++;
	  if (c + s1 >= ans) return 0;
	}
    ans = c + s1;
    amask = mask;
    return 0;
  }
  int s1 = 0;
  for (int k = i; k < n; k++)
    for (int j = 0; j < q[k] && v[k][j] < i; j++)
      if (((mask >> v[k][j]) & 1) == 0) {
	s1++;
	if (c + s1 >= ans) return 0;
      }
  ans = c + s1;
  amask = mask + nn - (1 << i);
  return 0;
}   

int main () {
  start = clock ();
//  cerr << clock () << endl;
  freopen ("half.in", "rt", stdin);
  freopen ("half.out", "wt", stdout);
  scanf ("%d %d\n", &n, &m);
  n2 = n / 2;
  nn = 1 << n;
  for (int i = 0; i < n; i++) p[i] = i;
/*  for (int i = 0; i < n; i++) {
    int t = rand () % (n - i) + i;
    int tmp = p[i];
    p[i] = p[t];
    p[t] = tmp;
  }*/
  //for (int i = 0; i < n; i++) printf ("%d %d\n", p[i], pp[i]);*/
  memset (q, 0, sizeof (q));
  for (int i = 0; i < m; i++) {
    int a, b;
    scanf ("%d%d", &a, &b); a--; b--;
    a = p[a]; b = p[b];
    if (a < b) {
      v[b][q[b]] = a;
      q[b]++;
    } else {
      v[a][q[a]] = b;
      q[a]++;
    }
  }
  for (int i = 0; i < n; i++)
    for (int j = 0; j < q[i]; j++)
      for (int k = j + 1; k < q[i]; k++)
	if (v[i][j] > v[i][k]) {
	  int tmp = v[i][j];
	  v[i][j] = v[i][k];
	  v[i][k] = tmp;
	}
  
  ans = m + 1;
  calc (1, 0, 1, 0, 0);
//  printf ("%d\n", ans);
  for (int i = 0; i < n; i++)
    if (((amask >> p[i]) & 1) == ((amask >> p[0]) & 1))
      printf ("%d ", i + 1);
  printf ("\n");
//  cerr << clock () << endl;  
}