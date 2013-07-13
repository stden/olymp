#include <cstdio>
#include <cstring>

#define maxn 21
int c[maxn], n, m;
long long cnt[55][maxn][maxn], k, nowr[2][maxn], r = 0;

int main( void )
{
  freopen("maxsum.in", "rt", stdin);
  freopen("maxsum.out", "wt", stdout);

  scanf("%d%d%I64d", &n, &m, &k);
  for (int i = 1; i <= n; i++)
    scanf("%d", c + i);
  for (int a, b, i = 0; i < m; i++)
    scanf("%d%d", &a, &b), cnt[0][a][b] = c[a] + c[b];
  for (int i = 1; i <= 54; i++)
    for (int s = 1; s <= n; s++)
      for (int p = 1; p <= n; p++)
        if (cnt[i - 1][s][p])
          for (int t = 1; t <= n; t++)
            if (cnt[i - 1][p][t] 
                && cnt[i][s][t] < cnt[i - 1][s][p] + cnt[i - 1][p][t] - c[p])
                  cnt[i][s][t] = cnt[i - 1][s][p] + cnt[i - 1][p][t] - c[p];
  int nowpos = 0, newpos, nowi = 0;
  nowr[nowpos][1] = c[1];
  
  while (k)
  {
    newpos = 1 - nowpos;
    if (k & 1)
    {
      for (int s = 1; s <= n; s++)
        if (nowr[nowpos][s])
          for (int t = 1; t <= n; t++)
            if (cnt[nowi][s][t]  && nowr[newpos][t] < cnt[nowi][s][t] + nowr[nowpos][s] - c[s])
              nowr[newpos][t] = cnt[nowi][s][t] + nowr[nowpos][s] - c[s];
      memset(nowr[nowpos], 0, sizeof(nowr[nowpos]));
      nowpos = newpos;
    }
    k >>= 1;
    nowi++;
  }            
  for (int i = 1; i <= n; i++)
    if (r < nowr[nowpos][i])
      r = nowr[nowpos][i];
  printf("%I64d\n", r);

  return 0;
} 