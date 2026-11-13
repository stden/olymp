#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#define TASKNAME "marked3"

using namespace std;

const int MinN = 1, MaxN = 26, MaxM = 1 << MaxN, MaxR = MaxM >> 5;
const int MinZ = 0, MaxZ = 1000;
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
  assert (0 <= k && k <= n);
  s = 0;
  for (j = 0; j < k; j++)
  {
   scanf (" %d", &b);
   assert (1 <= b && b <= n);
   b--;
   assert (!(s & (1 << b)));
   s |= 1 << b;
  }
  a[s >> 5] |= 1 << (s & 31);
 }
 for (s = m - 1; s >= 0; s--)
  if (a[s >> 5] & (1 << (s & 31)))
   for (j = 0; j < n; j++)
    if (s & (1 << j))
     a[(s - (1 << j)) >> 5] |= 1 << ((s - (1 << j)) & 31);
}

int main (void)
{
 int res, s;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d %d", &n, &x, &y) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  assert (MinZ <= x && x <= MaxZ);
  assert (MinZ <= y && y <= MaxZ);
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
