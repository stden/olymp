#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "path"

const int MaxN = 22, MaxN2 = 1 << MaxN;

int f [MaxN2];
int g [MaxN];
int m, n, n2;

int main (void)
{
 int i, j, k;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d", &n, &m) != EOF)
 {
  memset (g, 0, sizeof (g));
  for (k = 0; k < m; k++)
  {
   scanf (" %d %d", &i, &j);
   i--; j--;
   g[j] |= 1 << i;
  }
  n2 = 1 << n;
  memset (f, 0, sizeof (f));
  for (i = 0; i < n; i++)
   f[1 << i] |= 1 << i;
  for (k = 0; k < n2; k++)
   for (j = 0; j < n; j++)
    if (k & f[k] & g[j])
     f[k | (1 << j)] |= 1 << j;
  int res;
  res = 0;
  for (k = 0; k < n2; k++)
   if (f[k])
    if (res < __builtin_popcount (k))
     res = __builtin_popcount (k);
  printf ("%d\n", res);
 }
 return 0;
}
