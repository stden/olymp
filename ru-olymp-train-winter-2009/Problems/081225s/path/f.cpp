#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "path"

const int MaxN = 24, MaxN2 = 1 << MaxN;

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
  int res, arg;
  res = 0, arg = -1;
  for (k = 0; k < n2; k++)
  {
   if (f[k] && res < c[k])
    res = c[k], arg = k;
   for (j = 0, j2 = 1; j < n; j++, j2 <<= 1)
    if (k & f[k] & g[j])
     f[k | j2] |= j2;
  }
  printf ("%d\n", res - 1);
 }
 return 0;
}
