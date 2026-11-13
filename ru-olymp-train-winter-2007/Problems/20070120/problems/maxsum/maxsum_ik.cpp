#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "maxsum"
#define INT64 "%I64d"
typedef long long int64;

const int MaxN = 20, MaxM = MaxN * MaxN, MaxL = 100;
const int64 MaxK = 1000000000000000LL;

int64 a [MaxN] [MaxN];
int64 f [MaxM + 1] [MaxN] [MaxN];
int64 g [MaxM + 1] [MaxN];
int c [MaxN];

int main (void)
{
 int i, j, l, m, n, p, q;
 int64 max, len, k;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d " INT64, &n, &m, &k) != EOF)
 {
  assert (n >= 2 && n <= MaxN);
  assert (m >= 1 && m <= MaxM);
  assert (k >= 1 && k <= MaxK);
  for (i = 0; i < n; i++)
  {
   scanf (" %d", &c[i]);
   assert (c[i] >= 1 && c[i] <= MaxL);
  }
  memset (a, 193, sizeof (a));
  for (i = 0; i < m; i++)
  {
   scanf (" %d %d", &j, &l);
   assert (j >= 1 && j <= MaxN && l >= 1 && l <= MaxN);
   j--; l--;
   a[j][l] = c[l];
  }
  memset (f, 193, sizeof (f));
  for (i = 0; i < n; i++)
   f[0][i][i] = 0;
  m = n * n;
  for (l = 1; l <= m; l++)
   for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
     for (p = 0; p < n; p++)
      if (f[l][i][j] < f[l - 1][i][p] + a[p][j])
       f[l][i][j] = f[l - 1][i][p] + a[p][j];
  memset (g, 193, sizeof (g));
  for (i = 0; i < n; i++)
  {
   g[0][i] = 0;
   for (l = 1; l <= m; l++)
    for (j = 0; j < n; j++)
     if (g[l][i] < f[l][i][j])
      g[l][i] = f[l][i][j];
  }
  max = 0;
  for (i = 0; i < n; i++)
   for (j = 0; j <= n; j++)
    for (p = 0; p <= m; p++)
    {
     len = k - i - p;
     if (len < 0) continue;
     if (j == 0)
     {
      if (len == 0)
      {
       for (q = 0; q < n; q++) if (f[i][0][q] >= 0)
        if (max < f[i][0][q] + g[p][q])
         max = f[i][0][q] + g[p][q];
      }
      continue;
     }
     if (len % j) continue;
     len /= j;
     for (q = 0; q < n; q++) if (f[i][0][q] >= 0 && f[j][q][q] >= 0)
      if (max < f[i][0][q] + f[j][q][q] * len + g[p][q])
       max = f[i][0][q] + f[j][q][q] * len + g[p][q];
//       fprintf (stderr, "%d %d %d " INT64 "\n", i, j, p, max);
    }
/*
  for (l = 0; l <= m; l++)
  {
   printf ("l = %d:\n", l);
   for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
     printf (INT64 "%c", f[l][i][j], j + 1 < n ? ' ' : '\n');
  }
*/
  max += c[0];
  printf (INT64 "\n", max);
 }
 return 0;
}
