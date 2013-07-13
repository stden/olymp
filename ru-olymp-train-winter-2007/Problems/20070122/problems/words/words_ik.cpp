#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "words"
#define INT64 "%I64d"
typedef long long int64;

const int64 MaxC = 0x3F3F3F3F3F3F3F3FLL;
// const int64 MaxC = 0x0000000003030303LL;
long long calc;

const int MaxN = 4096, MaxP = 1024, MaxL = 55, MaxZ = 385, MaxK = 20;

int a [MaxP] [MaxZ];
int d [MaxP];
int cur [MaxP], ans [MaxP];
int code [MaxP];

int a0 [MaxN] [MaxL];
int c [MaxN];
bool b [MaxN];

int k, l, m, n, p, q, u, r, z, max, res, lim, num;
int count [MaxN];

void outword (FILE * f, int x)
{
 int j;
 for (j = 0; j < k; j++)
 {
  fprintf (f, "%c", char (x & p) + 'A');
  x >>= q;
 }
 fprintf (f, "\n");
}

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
 if (calc >= MaxC) return;
 calc++;
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
 int test;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 test = 0;
 while (scanf (" %d %d", &k, &l) != EOF)
 {
  assert (k >= 1 && k <= MaxK);
  assert (l >= 2 && l <= MaxK);
  test++;
  fprintf (stderr, "Test %02d: %2d %2d\n", test, k, l);
  fflush (stderr);
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
    code[n] = x;
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

  u = 0;
  for (x = 0; x < z; x++) if (b[x])
  {
   memset (d, 0, sizeof (d));
   for (i = 0; i < m; i++)
   {
    y = a0[x][i];
    d[c[y]]++;
    for (j = 0; j < m; j++)
     d[c[a0[y][j]]]++;
   }

   d[c[x]] = 0;
   t = 0;
   for (i = 0; i < m; i++)
   {
    j = c[a0[x][i]];
    d[j] = 0;
    a[c[x]][t] = j;
    t++;
   }

   for (i = 0; i < n; i++) if (d[i])
   {
    d[i] = 0;
    a[c[x]][t] = i;
    t++;
   }
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
  calc = 0;
  recur (0);
  if (calc >= MaxC)
  {
   fprintf (stderr, "Exiting due to timeout.\n");
  }
  fprintf (stderr, "Steps processed: " INT64 "\n", calc);
  fprintf (stderr, "The result is %d\n", max);
  fflush (stderr);

  printf ("%d\n", max);
  for (i = 0; i < max; i++)
   outword (stdout, code[ans[i]]);
  fflush (stdout);
 }
 return 0;
}
