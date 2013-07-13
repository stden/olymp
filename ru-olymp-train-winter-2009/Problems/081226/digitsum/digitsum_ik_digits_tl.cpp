#include <cassert>
#include <cstdio>

#define TASKNAME "digitsum"

const int MinT = 1, MaxT = 50000, MinC = 1, MaxC = 1000000000;
const int MaxK = 12;

int f [MaxK] [2];
int g [MaxK] [2];

int digit (int k)
{
 int i;
 for (i = MaxK - 1; i > 0; i--)
 {
#define sub(q) if (k < f[i][q]) continue; k -= f[i][q];
  sub (0);
  sub (0);
  sub (1);
  sub (0);
  sub (1);
  sub (0);
  sub (1);
#undef sub
 }
#define sub(q) if (k < f[i][q]) return q + 1; k -= f[i][q];
 sub (0);
 sub (0);
 sub (1);
 sub (0);
 sub (1);
 sub (0);
 sub (1);
#undef sub
 assert (false);
 return -1;
}

int main (void)
{
 int test, tests;
 int i, l, r, s;
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
 for (test = 0; test < tests; test++)
 {
  scanf (" %d %d", &l, &r);
  l--; r--;
  s = 0;
  for (i = l; i <= r; i++)
   s += digit (i);
  printf ("%d\n", s);
 }
 return 0;
}
