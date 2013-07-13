#include <cstdio>

#define maxn 16

int a[maxn][maxn], n;
double b[maxn][maxn], ans[1 << maxn][maxn];

double go( int code, int first )
{
  int live[maxn], liven = 0, firstpos;
  double ret = 0, q = 1, s[maxn], vend[maxn], st[maxn];
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
    for (int j = 0; j < liven; j++)
      if (i != j)
        s[i] += a[live[i]][live[j]];
    for (int j = 0; j < liven; j++)
      if (i != j)
        vend[i] += a[live[i]][live[j]] * b[live[i]][live[j]] / s[i];
    st[i] = q;
//    fprintf(stderr, "st[%d] = %.4lf ", i, st[i]);
    q *= (1 - vend[i]);
  }

/*  fprintf(stderr, "q = %.4lf\n", q);
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
    for (int t2 = (((i + liven - firstpos) % liven) + 1), j = 0; j < liven; j++)
      if (i != j)
      {
        double t1 = st[i] * a[live[i]][live[j]] / s[i] * b[live[i]][live[j]], t3 = 1 - q;
        ret  
        += (((t2  + q * (liven - t2)) / t3) + 
        go(code & (~(1 << live[j])), live[(i + 1 + (j == ((i + 1) % liven))) % liven])) * t1 / t3;
   /*     if (liven == 3) 
          fprintf(stderr, "st[i] = %.3lf (%d;%d) --> t = %.3lf||| %.3lf\n", st[i], i, j, t, ((((i + liven - firstpos) % liven) + 1.0) * (1 - q) + q * liven) / (1 - q) / (1 - q));*/
      }
  ans[code][first] = ret;
/*  fprintf(stderr, "live : ");
  for (int i = 0; i < liven; i++)
    fprintf(stderr, "%d ", live[i]);
  fprintf(stderr, "ans = %.3lf\n", ret);*/
  return ret;
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