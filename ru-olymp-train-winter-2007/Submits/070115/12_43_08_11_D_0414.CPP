#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

#define m 222
#define mk 7

int n, k, u[m][m], p[mk][m];
vector <pair <int,int> > to[m][m];
int _stklen = 10 << 20;

int dfs( int a, int b )
{
  u[a][b] = 1;
  for (int i = 0; i < to[a][b].size(); i++)
    if (!u[to[a][b][i].first][to[a][b][i].second])
      dfs(to[a][b][i].first, to[a][b][i].second);
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
    for (int i = 0; i < n; i++)
      for (int j = 0; j < n; j++)
        for (int l = 0; l < k; l++)
          to[p[l][i]][p[l][j]].push_back(make_pair(i, j));
    memset(u, 0, sizeof(u));
    dfs(0, 0);
    int f = 1;
    for (int i = 0; i < n; i++)
      f &= u[i][0];
    printf(f ? "YES\n" : "NO\n");
  }
  return 0;
}
