#include <cstdio>
#include <cstring>

#define TASKNAME "marked2"

const int MaxN = 20, MaxM = 1 << MaxN;
typedef bool arr [MaxM];

arr g, h;
int m, n, x, y;

void marksubsets (int z, arr & a)
{
 int b, i, j, k, s;
 memset (a, 0, sizeof (a));
 for (i = 0; i < z; i++)
 {
  scanf (" %d", &k);
  s = 0;
  for (j = 0; j < k; j++)
  {
   scanf (" %d", &b);
   b--;
   s |= 1 << b;
  }
  a[s] = true;
 }
 for (s = m - 1; s > 0; s--)
  if (a[s])
   for (j = 1; j < m; j <<= 1)
    if (s & j)
     a[s ^ j] = true;
}

int main (void)
{
 int res, s;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d %d", &n, &x, &y) != EOF)
 {
  m = 1 << n;
  marksubsets (x, g);
  marksubsets (y, h);
  res = 0;
  for (s = 0; s < m; s++)
   res += g[s] && !h[s];
  printf ("%d\n", res);
 }
 return 0;
}
