#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

#define min(a, b) ((a) < (b) ? (a) : (b))

#define m 220
#define mm 10100
#define inf (mm - 2)
#define inf2 (int)1e9

int r[m][mm], a[m], c[m], w[m], p[m], n;
vector <int> to[m];

void dfs( int v )
{
  for (int i = 0; i < to[v].size(); i++)
    dfs(to[v][i]);
  for (int i = 0; i <= inf; i++)
    r[v][i] = inf2;
  r[v][a[v]] <?= 0;
  for (int i = 0; i < to[v].size(); i++)
  {
    for (int j = 0; j <= c[to[v][i]]; j++)
      if (r[to[v][i]][j] < inf2)
        for (int k = 0; k < inf; k++)
          r[v][min(inf, j + k)] <?= r[v][k] + r[to[v][i]][j] + w[to[v][i]];
    for (int j = c[to[v][i]] + 1; j <= inf; j++)
      if (r[to[v][i]][j] < inf2)
        for (int k = 0; k < inf; k++)
          r[v][min(inf, j + k)] <?= r[v][k] + r[to[v][i]][j];
  }
/*  for (int j = 0; j <= 5; j++)
    fprintf(stderr, "r[%d][%d]=%d\n", v, j, r[v][j]);*/
}

int main( void )
{
  freopen("system.in", "rt", stdin);
  freopen("system.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%d%d%d%d", &p[i], &c[i], &a[i], &w[i]), p[i]--;;
  for (int i = 1; i < n; i++)
    to[p[i]].push_back(i);
  dfs(0);
  int ans = w[0];
  for (int i = c[0] + 1; i <= inf; i++)
    ans <?= r[0][i];
  printf("%d", ans);
  return 0;
}
