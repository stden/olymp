#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#define TASKNAME "modsum2"
#ifdef WIN32
#define INT64 "%I64d"
#else
#define INT64 "%lld"
#endif
typedef long long int64;
using namespace std;

const int MinN = 2, MaxN = 16, MaxL = 1 << MaxN;
const int MinS = 1, MaxS = 1000000;

int s [MaxN];
int c [MaxL];
int m, n;

int main (void)
{
 int i, j;
 int64 res;
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
  m = 1 << n;
  memset (c, 0, sizeof (c));
  for (i = 1; i < m; i++)
   for (j = 0; j < n; j++)
    if (i & (1 << j))
     c[i] += s[j];
  res = 0;
  for (i = 1; i < m - 1; i++)
   for (j = i; j > 0; j = (j - 1) & i)
//    printf ("%d %d\n", m - i - 1, j),
    res += c[m - i - 1] % c[j];
  printf (INT64 "\n", res);
 }
 return 0;
}
