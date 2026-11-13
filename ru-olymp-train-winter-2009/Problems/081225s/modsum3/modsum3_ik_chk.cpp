#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#define TASKNAME "modsum3"
#ifdef WIN32
#define INT64 "%I64d"
#else
#define INT64 "%lld"
#endif
typedef long long int64;
using namespace std;

const int MinN = 2, MaxN = 18, MaxL = 1 << MaxN;
const int MinS = 1, MaxS = 10, MaxT = 50;

int s [MaxN];
int c [MaxL];
int d [MaxL] [MaxT + 1];
int m, n;

int main (void)
{
 int i, j, k, l, t, u;
 int64 res;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d", &n) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  t = 0;
  for (i = 0; i < n; i++)
  {
   scanf (" %d", &s[i]);
   assert (MinS <= s[i] && s[i] <= MaxS);
   t += s[i];
  }
  assert (t <= MaxT);
  m = 1 << n;
  c[0] = 0;
  for (i = 0; i < n; i++)
   c[1 << i] = s[i];
  for (i = 1; i < m; i++)
  {
   j = ((i - 1) ^ i) & i;
   c[i] = c[i ^ j] + c[j];
  }

  memset (d, 0, sizeof (d));
  d[0][0] = 1;
  t = 0;
  for (i = 0, j = 1; i < n; i++, j <<= 1)
  {
   k = s[i];
   for (u = (m - 1) & ~j; u >= 0; u = (u - 1) & ~j)
    for (l = t; l >= 0; l--)
     d[u + j][l + k] += d[u][l],
     d[u + j][l] += d[u][l];
   t += k;
  }

//  printf ("n = %d, m = %d, t = %d\n", n, m, t);
  res = 0;
  for (i = m - 2; i > 0; i--)
   for (j = t; j > 0; j--)
    if (d[i][j])
//     printf ("d[%d][%d] = %d, j = %d, c[%d] = %d\n",
//      i, j, d[i][j], j, (m - 1) ^ i, c[(m - 1) ^ i]),
     res += d[i][j] * (j % c[(m - 1) ^ i]);
  printf (INT64 "\n", res);
 }
 return 0;
}
