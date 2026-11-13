#include <cstdio>
#include <cstring>

#define m 16

int a[m][m], n;
long double b[m][m], c[m][m], d[m], x[m], f[1 << m][m];

int main( void )
{
  freopen("game.in", "rt", stdin);
  freopen("game.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      scanf("%d", &a[i][j]);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      scanf("%Lf", &b[i][j]);
//  fprintf(stderr, "1\n");
  for (int i = 1; i < (1 << n); i++)
  {
//    fprintf(stderr, "i=%d\n", i);
    if (!(i & (i - 1)))
    {
      for (int j = 0; j < n; j++)
        if (i >> j)
          f[i][j] = 0;
      continue;
    }
    int nu = 0, p[m];
    for (int j = 0; j < n; j++)
      if ((i >> j) & 1)
        p[nu++] = j;
//    fprintf(stderr, "  1\n");
    memset(c, 0, sizeof(c));
    memset(d, 0, sizeof(d));
    for (int j = 0; j < nu; j++)
    {
//      fprintf(stderr, "  j=%d\n", j);
//      fprintf(stderr, "    1\n");
      int s = 0;
      for (int k = 0; k < nu; k++)
        if (k != j)
          s += a[p[j]][p[k]];
//      fprintf(stderr, "    2\n");
      c[j][j] = -1;
      for (int k = 0; k < nu; k++)
        if (k != j)
        {
          c[j][(j + 1) % nu] += a[p[j]][p[k]] * (1 - b[p[j]][p[k]]) / s;
          d[j] -= a[p[j]][p[k]] * (1 - b[p[j]][p[k]]) / s;
//          fprintf(stderr, "-1>d[%d]-=%Lf\n", j, a[p[j]][p[k]] * (1 - b[p[j]][p[k]]) / s);
          if ((j + 1) % nu == k)
            d[j] -= a[p[j]][p[k]] * b[p[j]][p[k]] * (f[i & ~(1 << p[k])][p[(j + 2) % nu]] + 1) / s/*,
            fprintf(stderr, "-2>d[%d]-=%Lf\n", j, a[p[j]][p[k]] * b[p[j]][p[k]] * (f[i & ~(1 << p[k])][p[(j + 2) % nu]] + 1) / s)*/;
          else
            d[j] -= a[p[j]][p[k]] * b[p[j]][p[k]] * (f[i & ~(1 << p[k])][p[(j + 1) % nu]] + 1) / s/*,
            fprintf(stderr, "-3>d[%d]-=%Lf\n", j, a[p[j]][p[k]] * b[p[j]][p[k]] * (f[i & ~(1 << p[k])][p[(j + 1) % nu]] + 1) / s)*/;
        }
    }
/*    for (int j = 0; j < nu; j++)
    {
      for (int k = 0; k < nu; k++)
        fprintf(stderr, "%3.3lf ", c[j][k]);
      fprintf(stderr, "  %3.3lf\n", d[j]);
    }*/
//    fprintf(stderr, "  2\n");
    for (int j = 0; j < nu; j++)
      for (int k = j + 1; k < nu; k++)
      {
        long double q = c[k][j] / c[j][j];
        d[k] -= d[j] * q;
        for (int l = j; l < nu; l++)
          c[k][l] -= c[j][l] * q;
      }
//    fprintf(stderr, "  3\n");
    for (int j = nu - 1; j >= 0; j--)
    {
      for (int k = j + 1; k < n; k++)
        d[j] -= c[j][k] * x[k];
      x[j] = d[j] / c[j][j];
    }
//    fprintf(stderr, "  4\n");
    for (int j = 0; j < nu; j++)
      f[i][p[j]] = x[j];
  }
  printf("%.6Lf", f[(1 << n) - 1][0]);
  return 0;
}
