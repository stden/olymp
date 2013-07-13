#include <cstdio>

#define TASKNAME "digitsum"

const int MaxK = 12;

int f [MaxK] [2];
int g [MaxK] [2];

int fun (int k)
{
 int i, res;
 res = 0;
 for (i = MaxK - 1; i >= 0; i--)
 {
#define sub(q) if (k < f[i][q]) continue; k -= f[i][q]; res += g[i][q];
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
//  printf ("%d %d %d %d\n", f[i][0], g[i][0], f[i][1], g[i][1]);
 }
 scanf (" %d", &tests);
 for (test = 0; test < tests; test++)
 {
  scanf (" %d %d", &l, &r);
  printf ("%d\n", fun (r) - fun (l - 1));
 }
 return 0;
}
