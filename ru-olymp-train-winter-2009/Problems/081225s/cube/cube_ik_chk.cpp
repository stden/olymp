// Problem: Cube
// Author: Ivan Kazmenko
// Dynamic programming
#include <assert.h>
#include <stdio.h>
#include <string.h>

#define TASKNAME "cube"

const int MinN = 1, MaxN = 10, MaxL = 1 << MaxN, MinS = 0, MaxS = 1000;

int a [MaxL], f [MaxL];

int main (void)
{
 int i, j, m, n;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d", &n) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  m = 1 << n;
  for (i = 0; i < m; i++)
  {
   scanf (" %d", &a[i]);
   assert (MinS <= a[i] && a[i] <= MaxS);
  }
  memset (f, -1, sizeof (f));
  f[0] = a[0];
  for (i = 1; i < m; i++)
   for (j = 0; j < n; j++)
    if (i & (1 << j))
     if (f[i] < f[i - (1 << j)] + a[i])
      f[i] = f[i - (1 << j)] + a[i];
  printf ("%d\n", f[m - 1]);
 }
 return (0);
}
