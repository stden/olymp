#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "path"

const int MaxN = 22, MaxN2 = 1 << MaxN;

bool f [MaxN2] [MaxN];
bool g [MaxN] [MaxN];
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
   g[i][j] = true;
  }
  n2 = 1 << n;
  memset (f, 0, sizeof (f));
  for (i = 0; i < n; i++)
   f[1 << i][i] = true;
  for (k = 0; k < n2; k++)
   for (i = 0; i < n; i++)
    if (f[k][i] && (k & (1 << i)))
     for (j = 0; j < n; j++)
      if (!(k & (1 << j)) && g[i][j])
       f[k | (1 << j)][j] = true;
  int res;
  res = 0;
  for (k = 0; k < n2; k++)
   for (i = 0; i < n; i++)
    if (f[k][i])
     if (res < __builtin_popcount (k))
      res = __builtin_popcount (k);
  printf ("%d\n", res);
 }
 return 0;
}
