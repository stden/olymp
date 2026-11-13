#include <cstdio>
#include <cstring>
#include <cstdlib>
#include <ctime>

#define m 550

long long a[m][m], b[m], c[m], w, h, _st, x[m], be[m], mi = -1;

void dfs( long long v )
{
  if (v == w)
  {
    long long val = 0;
    for (int i = 0; i < w; i++)
      val += x[i] * c[i];
    if (mi == -1 || val < mi)
    {
      mi = val;
      memcpy(be, x, sizeof(long long) * w);
    }
    return;
  }
  if (clock() - _st > 1.8 * CLOCKS_PER_SEC)
  {
    if (mi == -1)
      printf("-1");
    else
    {
      printf("%Ld\n", mi);
      for (long long i = 0; i < w; i++)
        printf("%Ld ", be[i]);
    }
    exit(0);
  }
  long long t = (int)1e9, lo = 0;
  for (long long j = 0; j < h; j++)
  {
    if (!a[j][v])
      continue;
    long long tt = b[j];
    for (long long i = 0; i < v; i++)
      tt -= a[j][i] * x[i];
    t <?= tt;
    if (t < 0)
      return;
    int f = 0;
    for (long long i = v + 1; i < w; i++)
      f |= a[j][i];
    if (!f)
      lo >?= tt;
    if (lo > t)
      return;
  }
  for (long long i = lo; i <= t; i++)
    x[v] = i, dfs(v + 1);
}

int main( void )
{
  _st = clock();
  freopen("radio.in", "rt", stdin);
  freopen("radio.out", "wt", stdout);
  scanf("%Ld%Ld", &h, &w);
  for (long long i = 0; i < h; i++)
    for (long long j = 0; j < w; j++)
      scanf("%Ld", &a[i][j]);
  for (long long i = 0; i < h; i++)
    scanf("%Ld", &b[i]);
  for (long long i = 0; i < w; i++)
    scanf("%Ld", &c[i]);
  dfs(0);
  if (mi == -1)
    printf("-1");
  else
  {
    printf("%Ld\n", mi);
    for (long long i = 0; i < w; i++)
      printf("%Ld ", be[i]);
  }
  return 0;
}
