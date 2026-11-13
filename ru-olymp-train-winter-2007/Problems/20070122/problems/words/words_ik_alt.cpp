#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "words"

const int MaxN = 4096, MaxP = 1024, MaxL = 55, MaxZ = 55, MaxK = 20;

int a [MaxP] [MaxZ];
int d [MaxP];
int cur [MaxP], ans [MaxP];

int a0 [MaxN] [MaxL];
int c [MaxN];
bool b [MaxN];

int k, l, m, n, p, q, u, r, z, max, res, lim, num;
int count [MaxN];

inline void add (int t)
{
 if (!d[t]) num--;
 d[t]++;
}

inline void rem (int t)
{
 d[t]--;
 if (!d[t]) num++;
}

void recur (int x)
{
 int i, j, y;
 if (max == lim) return;
 if (max - res >= num) return;

 add (x);
 for (i = u - 1; i >= 0; i--)
  add (a[x][i]);
 cur[res] = x;
 res++;

 if (max < res)
 {
  max = res;
  memmove (ans, cur, max * sizeof (int));
  fprintf (stderr, "New maximum found: %d!\n", max);
  fflush (stderr);
 }

 for (y = 0; y < x; y++) if (!d[y])
 {
  for (j = m - 1; j >= 0; j--)
  {
   i = a[y][j];
   if (i > x && !d[i]) break;
  }
  if (j == -1) break;
 }

 if (y == x)
  if (count[res] < 100)
  {
   count[res]++;
   fprintf (stderr, "%*c%2d %4d\n", res, ' ', res, x);
   fflush (stderr);
  }

 if (y == x)
  for (y = x + 1; y < n; y++)
   if (!d[y]) recur (y);
 
 res--;
 rem (x);
 for (i = u - 1; i >= 0; i--)
  rem (a[x][i]);
}

int main (void)
{
 int i, j, t, x, y;
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
    c[x] = n;
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
      a0[x][u++] = y;
     }
     if (l <= 2) continue;
     y = x;
     for (j = i; j < k; j++)
     {
      t = (y >> (q * j)) & p;
      t--; if (t < 0) t = l - 1;
      y = (y & ~(p << (q * j))) + (t << (q * j));
      a0[x][u++] = y;
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

  for (x = 0; x < z; x++) if (b[x])
  {
   printf ("%03X:", x);
   for (u = 0; u < m; u++)
    printf (" %03X", a0[x][u]);
   printf ("\n");
  }

  u = 0;
  for (x = 0; x < z; x++) if (b[x])
  {
   memset (d, 0, sizeof (d));
   for (i = 0; i < m; i++)
   {
    y = a0[x][i];
    d[c[y]]++;
    for (j = 0; j < m; j++)
     d[c[a0[y][i]]]++;
   }

   printf ("%4d:", c[x]);
   d[c[x]] = 0;
   t = 0;
   for (i = 0; i < m; i++)
   {
    j = c[a0[x][i]];
    printf (" %4d", j);
    d[j] = 0;
    a[c[x]][t] = j;
    t++;
   }
   printf (",");

   for (i = 0; i < n; i++) if (d[i])
   {
    printf (" %4d", i);
    d[i] = 0;
    a[c[x]][t] = i;
    t++;
   }
   printf (";\n");
   fflush (stdout);

   if (u == 0) u = t;
   else assert (u == t);
  }

  fprintf (stderr, "k = %2d, l = %2d, p = %2d, q = %2d, z = %4d, r = %4d, "
   "n = %4d, m = %3d, u = %3d\n", k, l, p, q, z, r, n, m, u);
  fflush (stderr);

  memset (d, 0, sizeof (d));
  max = 0;
  res = 0;
  lim = n / (m + 1);
  if (!lim) lim++;
  num = n;
  memset (count, 0, sizeof (count));
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
