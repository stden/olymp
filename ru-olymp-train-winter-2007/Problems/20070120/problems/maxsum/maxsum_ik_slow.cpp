#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "maxsum"

const int MaxN = 20, MaxM = 400, MaxK = 100, MaxD = 10025, Base = 10;
typedef int bignum [MaxD];

bool a [MaxN] [MaxN];
int f [2] [MaxN];
int c [MaxN];

int main (void)
{
 int g, i, j, k, l, m, n;
 int max;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d %d", &n, &m, &k) != EOF)
 {
  assert (n >= 1 && n <= MaxN);
  assert (m >= 1 && m <= MaxM);
  for (i = 0; i < n; i++)
   scanf (" %d", &c[i]),
   assert (c[i] >= 1 && c[i] <= MaxK);
  memset (a, 0, sizeof (a));
  for (i = 0; i < m; i++)
   scanf (" %d %d", &j, &l),
   assert (j >= 1 && j <= MaxN && l >= 1 && l <= MaxN),
   a[j - 1][l - 1] = true;
  g = 0;
  memset (f[g], 191, sizeof (f[g]));
  f[g][0] = c[0];
  for (l = 0; l < k; l++)
  {
   g = !g;
   memset (f[g], 191, sizeof (f[g]));
   for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
     if (a[i][j] && f[g][j] < f[!g][i] + c[j])
      f[g][j] = f[!g][i] + c[j];
/*
//   for (i = 0; i < n; i++) printf ("%d%c", f[g][i], i + 1 < n ? ' ' : '\n');
   max = 0;
   for (i = 0; i < n; i++)
    if (max < f[g][i])
     max = f[g][i];
   printf ("%d\n", max);
*/
  }
  max = 0;
  for (i = 0; i < n; i++)
   if (max < f[g][i])
    max = f[g][i];
  printf ("%d\n", max);
 }
 return 0;
}
