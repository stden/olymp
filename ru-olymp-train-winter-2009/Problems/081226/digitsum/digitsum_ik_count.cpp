#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

typedef long long int64;
#ifdef WIN32
#define INT64 "%I64d"
#else
#define INT64 "%lld"
#endif

#define TASKNAME "digitsum"

const int MinT = 1, MaxT = 50000, MinC = 1, MaxC = 1000000000;
const int MaxK = 12;

int f [MaxK] [2];
int g [MaxK] [2];
int64 count;

int fun (int k)
{
 int i, res;
 res = 0;
 for (i = MaxK - 1; i >= 0; i--)
 {
#define sub(q) if (k < f[i][q]) continue; \
   count++; k -= f[i][q]; res += g[i][q];
  sub (0);
  sub (0);
  sub (1);
  sub (0);
  sub (1);
  sub (0);
  sub (1);
#undef sub
 }
 return res;
}

int main (void)
{
 int test, tests;
 int i, l, r;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 f[0][0] = 1;
 g[0][0] = 1;
 f[0][1] = 1;
 g[0][1] = 2;
 for (i = 1; i < MaxK; i++)
 {
  f[i][0] = f[i - 1][0] * 3 + f[i - 1][1] * 2;
  g[i][0] = g[i - 1][0] * 3 + g[i - 1][1] * 2;
  f[i][1] = f[i - 1][0] * 4 + f[i - 1][1] * 3;
  g[i][1] = g[i - 1][0] * 4 + g[i - 1][1] * 3;
 }
 scanf (" %d", &tests);
 assert (MinT <= tests && tests <= MaxT);
 count = 0;
 for (test = 0; test < tests; test++)
 {
  scanf (" %d %d", &l, &r);
  assert (MinC <= l && l <= r && r <= MaxC);
  printf ("%d\n", fun (r) - fun (l - 1));
 }
 fprintf (stderr, "Total subtractions: " INT64 "\n", count);
 return 0;
}
