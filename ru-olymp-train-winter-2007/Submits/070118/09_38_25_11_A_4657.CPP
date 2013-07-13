#include <cstdio>
#include <cstring>

#define m 16

int a[m][m], n;
double b[m][m], c[m][m], d[m], x[m], f[1 << m][m];

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
      scanf("%lf", &b[i][j]);
  for (int i = 1; i < (1 << n); i++)
  {
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
    memset(c, 0, sizeof(c));
    for (int j = 0; j < nu; j++)
    {
      int s = 0;
      for (int k = 0; k < nu; k++)
        if (k != j)
          s += a[p[j]][p[k]];
      c[j][j] = -1;
      for (int k = 0; k < nu; k++)
        if (k != j)
        {
          c[j][(j + 1) % nu] += a[p[j]][p[k]] * (1 - b[p[j]][p[k]]) / s;
          d[j] -= a[p[j]][p[k]] * (1 - b[p[j]][p[k]]) / s;
          if ((j + 1) % nu == k)
            d[j] -= a[p[j]][p[k]] * b[p[j]][p[k]] * (f[i & ~(1 << p[k])][p[(j + 2) % nu]] + 1) / s;
          else
            d[j] -= a[p[j]][p[k]] * b[p[j]][p[k]] * (f[i & ~(1 << p[k])][p[(j + 1) % nu]] + 1) / s;
        }
    }
    for (int j = 0; j < nu; j++)
      for (int k = j + 1; k < nu; k++)
      {
        double q = c[k][j] / c[j][j];
        d[k] -= d[j] * q;
        for (int l = j; l < nu; l++)
          c[k][l] -= c[j][l] * q;
      }
    for (int j = nu - 1; j >= 0; j--)
    {
      for (int k = j + 1; k < n; k++)
        d[j] -= c[j][k] * x[k];
      x[j] = d[j] / c[j][j];
    }
    for (int j = 0; j < n; j++)
      f[i][p[j]] = x[j];
  }
  printf("%.6lf", f[(1 << n) - 1][0]);
  return 0;
}
