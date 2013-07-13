#include <cstdio>

#define maxn 16

int a[maxn][maxn], n;
double b[maxn][maxn], ans[1 << maxn][maxn], nowa[maxn][maxn], nowb[maxn][maxn], s[maxn], vend[maxn], st[maxn], vkill[maxn];

double go( int code, int first )
{
  int live[maxn], liven = 0, firstpos;
  double ret = 0, q = 1;
  if (ans[code][first] != 0)
    return ans[code][first];

  for (int i = 0; i < n; i++)
    if ((code >> i) & 1)
    {
      if (i == first)
        firstpos = liven;
      live[liven++] = i;
    }
/*  fprintf(stderr, "live : ");
  for (int i = 0; i < liven; i++)
    fprintf(stderr, "%d ", live[i]);
  fprintf(stderr, "first = %d, firstpos = %d\n", first, firstpos);*/
  if (liven == 1)
  {
    ans[code][first] = 0;
    return 0;
  }
  for (int i = firstpos, k = 0; k < liven; k++, i = (i + 1) % liven)
  {
    s[i] = 0;
    vend[i] = 0;
    vkill[i] = 0;
    for (int j = 0; j < liven; j++)
      if (i != j)
        s[i] += a[live[i]][live[j]];
    for (int j = 0; j < liven; j++)
      if (i != j)
        nowa[i][j] = a[live[i]][live[j]] / s[i],
        nowb[i][j] = b[live[i]][live[j]],
        vend[i] += nowa[i][j] * nowb[i][j];
    st[i] = q;
//    fprintf(stderr, "st[%d] = %.4lf ", i, st[i]);
    q *= (1 - vend[i]);
  }
/*
  fprintf(stderr, "q = %.4lf\n", q);
  fprintf(stderr, "nowa:\n");
  for (int i = 0; i < liven; i++)
    for (int j = 0; j < liven; j++)
      fprintf(stderr, "%.2lf%c", nowa[i][j], j < liven - 1 ? ' ' : '\n');
  fprintf(stderr, "nowb:\n");

  for (int i = 0; i < liven; i++)
    for (int j = 0; j < liven; j++)
      fprintf(stderr, "%.2lf%c", nowb[i][j], j < liven - 1 ? ' ' : '\n');
*/
  for (int i = 0;i < liven; i++)
    for (int j = 0; j < liven; j++)
      if (i != j)
        ret += (st[i] * nowa[i][j] * nowb[i][j] * ((((i + liven - firstpos) % liven) + 1.0) * (1 - q) + q * liven) / (1 - q) / (1 - q)) + (st[i] * nowa[i][j] * nowb[i][j] / (1 - q)) * go(code & (~(1 << live[j])), live[(i + 1 + (j == ((i + 1) % liven))) % liven]);
  ans[code][first] = ret;

}


int main( void )
{
  freopen("game.in", "rt", stdin);
  freopen("game.out", "wt", stdout);

  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      scanf("%d", a[i] + j);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      scanf("%lf", b[i] + j);

  go((1 << n) - 1, 0);
  printf("%.5lf", ans[(1 << n) - 1][0]);
  return 0; 
}