#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "path"

const int MinN = 1, MaxN = 22, MaxN2 = 1 << MaxN, MinM = 0, MaxM = 1000;

char c [MaxN2];
int f [MaxN2];
int g [MaxN];
int m, n, n2;

int main (void)
{
 int i, j, j2, k;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 memset (c, 0, sizeof (c));
 for (i = 1; i < MaxN2; i++)
  c[i] = c[i >> 1] + (i & 1);
 while (scanf (" %d %d", &n, &m) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  assert (MinM <= n && n <= MaxM);
  memset (g, 0, sizeof (g));
  for (k = 0; k < m; k++)
  {
   scanf (" %d %d", &i, &j);
   assert (1 <= i && i <= n);
   assert (1 <= j && j <= n);
   i--; j--;
   g[i] |= 1 << j;
  }
  for (i = 0; i < n; i++)
   g[i] &= ~(1 << i);
  n2 = 1 << n;
  memset (f, 0, sizeof (f));
  for (i = 0; i < n; i++)
   f[1 << i] |= 1 << i;
  int res, arg;
  res = 0, arg = -1;
  for (k = 0; k < n2; k++)
  {
   printf ("%d: %d %d\n", k, f[k], c[k]);
   if (f[k] && res < c[k])
    res = c[k], arg = k;
   for (j = 0, j2 = 1; j < n; j++, j2 <<= 1)
    if (!(k & j2) && (k & f[k] & g[j]))
     f[k | j2] |= j2;
  }
  printf ("%d\n", res - 1);
  k = n2 - 1;
  for (; res > 0; res--)
  {
   printf (" [%d: %d %d] ", arg, f[arg], k);
   fflush (stdout);
   assert (f[arg] & k);
   j = __builtin_ctz (f[arg] & k);
   printf ("%d%c", j + 1, res ? ' ' : '\n');
   arg ^= 1 << j;
   k = g[j];
  }
 }
 return 0;
}
