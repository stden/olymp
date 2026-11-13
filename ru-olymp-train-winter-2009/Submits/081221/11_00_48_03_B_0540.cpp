#include <cstdio>
#include <iostream>
#include <cstring>
#include <cmath>
#include "treeunit.h"

using namespace std;

int was[200200], ee[400400], next[400400], first[200200], en[400400];
int tt, ans, x, y;
int anc[200200], use[200200], a[200200], b[200200];

int get (int i, int l, int ni) {
  if (l % 100 == 0) printf ("%d %d\n", i, l);
  anc[l] = ni;
  if (l > ans) {
    ans = l;
    x = i;
    y = anc[(l + 1) / 2];
  }
  was[i] = tt;
  int j = first[i];
  while (j) {
    if (was[ee[j]] < tt && !use[ee[j]])
      get (ee[j], l + 1, en[j]);
    j = next[j];
  }
  return 0;
}

int getstack (int a, int b, int c) {
  if (a == 0) return 0;
  int d[10];
  memset (d, 255, sizeof (d));
  getstack (a - 1, b + 1, c + b / 100);
  return 0;
}

int main () {
  getstack (200000, 0, 0);
  init ();
  int n = getN ();
  int o = 0;
  for (int i = 1; i < n; i++) {
    a[i] = getA (i);
    b[i] = getB (i);
    o++;
    ee[o] = b[i];
    en[o] = i;
    next[o] = first[a[i]];
    first[a[i]] = o;
    o++;
    ee[o] = a[i];
    en[o] = i;
    next[o] = first[b[i]];
    first[b[i]] = o;
  }
  memset (was, 0, sizeof (was));
  memset (use, 0, sizeof (use));
  int cur = 1;
  while (1) {
    tt++;
    ans = 0;
    x = 0;
    get (cur, 0, 0);
    if (ans == 0) break;
    cur = x;
    tt++;
    ans = 0;
    get (cur, 0, 0);
    if (query (y) == 0) {
      use[b[y]] = 1;
      cur = a[y];
    } else {
      use[a[y]] = 1;
      cur = b[y];
    }
  }
  report (cur);
}