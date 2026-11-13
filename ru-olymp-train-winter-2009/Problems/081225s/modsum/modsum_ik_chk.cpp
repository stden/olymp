#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#define TASKNAME "modsum"

using namespace std;

const int MinN = 2, MaxN = 10;
const int MinS = 1, MaxS = 1000;

int s [MaxN];
int m, n;

int main (void)
{
 int a, b, i, j, k, l, res;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d", &n) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  for (i = 0; i < n; i++)
  {
   scanf (" %d", &s[i]);
   assert (MinS <= s[i] && s[i] <= MaxS);
  }
  res = 0;
  m = 1 << n;
  for (i = 1; i < m; i++)
   for (j = 1; j < m; j++)
    if (!(i & j))
    {
     a = b = 0;
     for (k = 0; k < n; k++)
      if (i & (1 << k))
       a += s[k];
     for (l = 0; l < n; l++)
      if (j & (1 << l))
       b += s[l];
     assert (b > 0);
     res += a % b;
    }
  printf ("%d\n", res);
 }
 return 0;
}
