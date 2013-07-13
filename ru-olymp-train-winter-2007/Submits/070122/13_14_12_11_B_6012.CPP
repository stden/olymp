#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

#define min(a, b) ((a) < (b) ? (a) : (b))

#define m 220
#define mm 510
#define inf (mm - 2)

int r[m][mm], t[m][mm], a[m], c[m], w[m], p[m], n;
vector <int> to[m];

void dfs( int v )
{
  for (int i = 0; i < to[v].size(); i++)
    dfs(to[v][i]);
  for (int i = 0; i <= inf; i++)
    t[v][i] = r[v][i] = 0;
  t[v][0] = a[v];
  for (int i = 0; i < to[v].size(); i++)
    for (int j = inf; j >= 0; j--)
      for (int k = 0; j + k <= inf; k++)
        t[v][j + k] >?= t[v][j] + r[to[v][i]][k];
  for (int i = 0; i <= inf; i++)
    if (t[v][i] > c[v])
      r[v][i] >?= t[v][i];
    else if (i + w[v] <= inf)
      r[v][i + w[v]] >?= t[v][i];
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
  for (int i = 0; i <= inf; i++)
    if (r[0][i] > c[0])
      ans <?= i;
  printf("%d", ans);
  return 0;
}
