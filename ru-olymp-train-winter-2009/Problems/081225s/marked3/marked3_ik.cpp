#include <cstdio>
#include <cstring>

#define TASKNAME "marked3"

const int MaxN = 26, MaxM = 1 << MaxN, MaxR = MaxM >> 5;
typedef int arr [MaxR];

arr g, h;
int m, n, r, x, y;

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
  a[s >> 5] |= 1 << (s & 31);
 }
 for (s = r - 1; s >= 0; s--)
 {
  a[s] |= (a[s] >>  1) & 0x55555555;
  a[s] |= (a[s] >>  2) & 0x33333333;
  a[s] |= (a[s] >>  4) & 0x0F0F0F0F;
  a[s] |= (a[s] >>  8) & 0x00FF00FF;
  a[s] |= (a[s] >> 16) & 0x0000FFFF;
 }
 for (j = 1, i = ~j; j < r; j <<= 1, i = ~j)
  for (s = (r - 1) & i; s >= 0; s = (s - 1) & i)
   a[s] |= a[s | j];
}

int main (void)
{
 int res, s;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d %d", &n, &x, &y) != EOF)
 {
  m = 1 << n;
  r = m >> 5;
  if (!r) r = 1;
  marksubsets (x, g);
  marksubsets (y, h);
  res = 0;
  for (s = 0; s < r; s++)
   res += __builtin_popcount (g[s] & ~h[s]);
  printf ("%d\n", res);
 }
 return 0;
}
