#include <cstdio>
#include <cstring>
#include <cstdlib>

#define maxn 40

long long cnt[36][maxn][maxn], stcnt[maxn], cntp[2][maxn], p;
int d[maxn], a[maxn][maxn];

int main( void )
{
  freopen("restore.in", "rt", stdin);
  freopen("restore.out", "wt", stdout);
  int n, m;
  long long res = 0;
  scanf("%d%d%I64d", &n, &m, &p);
  memset(a, 0, sizeof(a));
  for (int v1, v2, i = 0; i < m; i++)
    scanf("%d%d", &v1, &v2), a[v1][v2] = a[v2][v1] = 1;
  int s;
  scanf("%d", &s);
  memset(d, -1, sizeof(d));
  d[s] = 0;
  for (int i = 0; i < n; i++)
    for (int v1 = 1; v1 <= n; v1++)
      for (int v2 = 1; v2 <= n; v2++)
        if (a[v1][v2] && d[v1] + 1 && (!(d[v2] + 1) || d[v1] + 1 < d[v2]))
          d[v2] = d[v1] + 1;
  /* output d */

  int t, prevd = 0;
  scanf("%d", &t);
  for (int v1 = 1; v1 <= n; v1++)
    for (int v2 = 1; v2 <= n; v2++)
      if (d[v2] == d[v1] && a[v1][v2])
        cnt[0][v1][v2] = 1;

  for (int i = 0; i < 32; i++)
    for (int v1 = 1; v1 <= n; v1++)
        for (int v2 = 1; v2 <= n; v2++)
          if (d[v2] == d[v1])
            for (int g = 1; g <= n; g++)
              cnt[i + 1][v1][v2] = (cnt[i + 1][v1][v2] + cnt[i][v1][g] * cnt[i][g][v2]) % p;
  int f = 1;
  while (t--)
  {
    int newd, b;
    scanf("%d%d", &newd, &b);
    b--;
    memset(cntp, 0, sizeof(cntp));
    int pos = 0;
    if (f)
    {
      for (int v1 = 1; v1 <= n; v1++)
        if (d[v1] == newd)
          stcnt[v1] = cntp[0][v1] = 1 % p;
      f = 0;
    }
    else
    {
      for (int v1 = 1; v1 <= n; v1++)
        for (int v2 = 1; v2 <= n; v2++)
          if (a[v1][v2] && d[v1] == prevd && d[v2] == newd)
            cntp[0][v2] = (cntp[0][v2] + stcnt[v1]) % p;
    }
    int i = 0;
    while (b > 0)
    {
      int newpos = 1 - pos;
      if (b & 1)
      {
        for (int v1 = 1; v1 <= n; v1++)
          if (d[v1] == newd)
            for (int v2 = 1; v2 <= n; v2++)
              if (d[v2] == newd)
                cntp[newpos][v2] = (cntp[newpos][v2] + cnt[i][v1][v2] * cntp[pos][v1]) % p;
      }
      else
        for (int v1 = 1; v1 <= n; v1++)
          if (d[v1] == newd)
            cntp[newpos][v1] = cntp[pos][v1];
          
      b >>= 1;
      memset(cntp[pos], 0, sizeof(cntp[pos]));
      pos = newpos;
      i++;
    }
    memset(stcnt, 0, sizeof(stcnt));
    for (int v1 = 1; v1 <= n; v1++)
      if (d[v1] == newd)
        stcnt[v1] = cntp[pos][v1];
    prevd = newd;
  }
  for (int v1 = 1; v1 <= n; v1++)
    if (d[v1] == prevd)
      res = (res + stcnt[v1]) % p;
  printf("%I64d", res);
  return 0;            
}
