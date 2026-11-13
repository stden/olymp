#include <cstdio>
#include <cstring>

#define m 222
#define mk 7

int n, k, u[m][m], c[m][m], p[mk][m];
int _stklen = 10 << 20;

int dfs( int a, int b )
{
  if (u[a][b])
    return c[a][b];
  u[a][b] = 1;
  if (a == 0 && b == 0)
    return c[a][b] = 1;
  for (int i = 0; i < k; i++)
    c[a][b] |= dfs(p[i][a], p[i][b]);
  return c[a][b];
}

int main( void )
{
  freopen("bit2.in", "rt", stdin);
  freopen("bit2.out", "wt", stdout);
  int t;
  scanf("%d", &t);
  while (t--)
  {
    scanf("%d%d", &n, &k);
    for (int i = 0; i < k; i++)
      for (int j = 0; j < n; j++)
        scanf("%d", &p[i][j]);
    int f = 1;
    for (int i = 0; i < n; i++)
    {
      memset(u, 0, sizeof(u));
      memset(c, 0, sizeof(c));
      f &= dfs(i, 0);
    }
    printf(f ? "YES\n" : "NO\n");
  }
  return 0;
}
