#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#define TASKNAME "marked"

using namespace std;

const int MinN = 1, MaxN = 10, MaxM = 1 << MaxN;
const int MinZ = 0, MaxZ = 1000;

bool b [MaxM];
int m, n, x, y;

int main (void)
{
 int i, j, k, l, res, s;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d %d", &n, &x, &y) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  assert (MinZ <= x && x <= MaxZ);
  assert (MinZ <= y && y <= MaxZ);
  memset (b, 0, sizeof (b));
  m = 1 << n;

  for (i = 0; i < x; i++)
  {
   scanf (" %d", &k);
   assert (0 <= k && k <= n);
   s = 0;
   for (j = 0; j < k; j++)
   {
    scanf (" %d", &l);
    assert (1 <= l && l <= n);
    l--;
    assert (!(s & (1 << l)));
    s |= 1 << l;
   }
   for (j = 0; j < m; j++)
    if ((j & s) == j)
     b[j] = true;
  }

  for (i = 0; i < y; i++)
  {
   scanf (" %d", &k);
   assert (0 <= k && k <= n);
   s = 0;
   for (j = 0; j < k; j++)
   {
    scanf (" %d", &l);
    assert (1 <= l && l <= n);
    l--;
    assert (!(s & (1 << l)));
    s |= 1 << l;
   }
   for (j = 0; j < m; j++)
    if ((j & s) == j)
     b[j] = false;
  }

  res = 0;
  for (i = 0; i < m; i++)
   res += b[i];
  printf ("%d\n", res);
 }
 return 0;
}
