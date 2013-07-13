#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "words"

const int MaxN = 4096, MaxL = 110, MaxK = 20;

int a [MaxN] [MaxL];
bool b [MaxN], c [MaxN];
int d [MaxN];
int cur [MaxN], ans [MaxN];
int k, l, m, n, p, q, r, z, max, res, lim;

void recur (int x)
{
 int i, j, y;
 if (max == lim) return;

 d[x]++;
 for (i = 0; i < m; i++)
 {
  y = a[x][i];
  d[y]++;
  for (j = 0; j < m; j++)
   d[a[y][j]]++;
 }
 cur[res] = x;
 res++;

 if (max < res)
 {
  max = res;
  memmove (ans, cur, max * sizeof (int));
  fprintf (stderr, "New maximum found: %d!\n", max);
  fflush (stderr);
 }

 for (y = x + 1; y < z; y++) if (b[y])
  if (!d[y]) recur (y);
 
 res--;
 d[x]--;
 for (i = 0; i < m; i++)
 {
  y = a[x][i];
  d[y]--;
  for (j = 0; j < m; j++)
   d[a[y][j]]--;
 }
}

int main (void)
{
 int i, j, t, u, x, y;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d", &k, &l) != EOF)
 {
  assert (k >= 1 && k <= MaxK);
  assert (l >= 1 && l <= MaxK);
  for (p = l; p != ((p ^ (p - 1)) & p); p++) ;
  for (q = 0; (1 << q) < p; q++) ;
  z = 1 << (q * k);
  r = 1;
  for (i = 0; i < k; i++)
   r *= l;
  p--;
  memset (b, 0, sizeof (b));
  if (q)
  {
   m = k * (k + 1);
   if (l == 2) m >>= 1;
   n = 0;
   for (x = 0; x < z; x++)
   {
    for (i = 0; i < k; i++)
     if (((x >> (q * i)) & p) >= l)
      break;
    if (i < k) continue;
    b[x] = true;
    n++;
    u = 0;
    for (i = 0; i < k; i++)
    {
     y = x;
     for (j = i; j < k; j++)
     {
      t = (y >> (q * j)) & p;
      t++; if (t == l) t = 0;
      y = (y & ~(p << (q * j))) + (t << (q * j));
      a[x][u++] = y;
     }
     if (l <= 2) continue;
     y = x;
     for (j = i; j < k; j++)
     {
      t = (y >> (q * j)) & p;
      t--; if (t < 0) t = l - 1;
      y = (y & ~(p << (q * j))) + (t << (q * j));
      a[x][u++] = y;
     }
    }
    assert (u == m);
   }
  }
  else
  {
   m = 0;
   n = 1;
   b[0] = true;
  }
  assert (n == r);
  fprintf (stderr, "k = %2d, l = %2d, p = %2d, q = %2d, z = %4d, r = %4d, \
   m = %4d, n = %4d\n", k, l, p, q, z, r, m, n);
  fflush (stderr);
/*
  for (x = 0; x < z; x++) if (b[x])
  {
   printf ("%03X:", x);
   for (u = 0; u < m; u++)
    printf (" %03X", a[x][u]);
   printf ("\n");
  }
*/
  memset (d, 0, sizeof (d));
  max = 0;
  res = 0;
  lim = n / (m + 1);
  if (!lim) lim++;
  recur (0);
  printf ("%d\n", max);
  for (i = 0; i < max; i++)
  {
   x = ans[i];
   for (j = 0; j < k; j++)
   {
    printf ("%c", char (x & p) + 'A');
    x >>= q;
   }
   printf ("\n");
  }
  fflush (stdout);
 }
 return 0;
}
