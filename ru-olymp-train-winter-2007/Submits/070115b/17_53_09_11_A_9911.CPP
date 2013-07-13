#include <cstdio>
#include <vector>

using namespace std;

#define m 202000

int _stklen = 10 << 20;
int u[m], ti, tt[m], is[m], n, k;
vector <int> to[m], nu[m];

int dfs( int v, int p, int pe )
{
  int l = ti;
  tt[v] = ti++;
  u[v] = 1;
  for (int i = 0; i < to[v].size(); i++)
    if (!u[to[v][i]])
    {
      int k = dfs(to[v][i], v, nu[v][i]);
      l <?= k;
    }
    else if (to[v][i] != p)
      l <?= tt[to[v][i]];
  if (p != -1 && l > tt[p])
    is[pe] = 1;
  return l;
}

int main( void )
{
  freopen("bridges.in", "rt", stdin);
  freopen("bridges.out", "wt", stdout);
  scanf("%d%d", &n, &k);
  for (int i = 0; i < k; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b), a--, b--;
    to[a].push_back(b);
    nu[a].push_back(i);
    to[b].push_back(a);
    nu[b].push_back(i);
  }
  memset(is, 0, sizeof(is));
  memset(u, 0, sizeof(u));
  ti = 0;
  dfs(0, -1, -1);
  vector <int> ans;
  for (int i = 0; i < k; i++)
    if (is[i])
      ans.push_back(i);
  printf("%d\n", ans.size());
  for (int i = 0; i < ans.size(); i++)
    printf("%d ", ans[i] + 1);
  return 0;
}
