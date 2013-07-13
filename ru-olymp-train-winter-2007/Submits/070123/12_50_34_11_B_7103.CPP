#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

#define m 101000

int n, a[m], b[m], d[m], u[m], q[m], fi, la;
vector <int> to[m];
int _stklen = 10 << 20;

int dfs( int v )
{
  if (!u[v])
    return 0;
  u[v] = 0;
  for (int i = 0; i < to[v].size(); i++)
    if (b[to[v][i]] == -1 || (u[b[to[v][i]]] && d[b[to[v][i]]] > d[v] && dfs(b[to[v][i]])))
    {
      a[v] = to[v][i], b[to[v][i]] = v;
      return 1;
    }
  return 0;
}

int dfs1( int v, int p )
{
  int f = 0;
  u[v] = 1;
  for (int i = 0; i < to[v].size(); i++)
    if (!u[b[to[v][i]]])
      f |= dfs1(b[to[v][i]], v);
    else if (b[to[v][i]] != p && b[to[v][i]] != v && u[b[to[v][i]]] == 1)
      return 1;
  u[v] = 2;
  return f;
}

int main( void )
{
  freopen("omax.in", "rt", stdin);
  freopen("omax.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
  {
    int k;
    scanf("%d", &k);
    to[i].resize(k);
    for (int j = 0; j < k; j++)
      scanf("%d", &to[i][j]), to[i][j]--;
  }
  memset(a, -1, sizeof(a));
  memset(b, -1, sizeof(b));
  int nu = 0, f;
  do
  {
    fi = la = 0;
    memset(u, 0, sizeof(u));
    for (int i = 0; i < n; i++)
      if (a[i] == -1)
        u[i] = 1, d[i] = 0, q[la++] = i;
    while (fi < la)
    {
      int v = q[fi++];
      for (int i = 0; i < to[v].size(); i++)
        if (b[to[v][i]] != -1 && !u[b[to[v][i]]])
          u[b[to[v][i]]] = 1, d[b[to[v][i]]] = d[v] + 1, q[la++] = b[to[v][i]];
    }
    f = 0;
    for (int i = 0; i < n; i++)
      if (a[i] == -1 && u[i])
        f |= dfs(i);
  } while (f);
  for (int i = 0; i < n; i++)
    if (a[i] == -1)
    {
      printf("NO\n");
      return 0;
    }
  memset(u, 0, sizeof(u));
  for (int i = 0; i < n; i++)
    if (!u[i])
      if (dfs1(i, -1))
      {
        printf("NO\n");
        return 0;
      }
  printf("YES\n");
  for (int i = 0; i < n; i++)
    printf("%d ", a[i] + 1);
  return 0;
}
