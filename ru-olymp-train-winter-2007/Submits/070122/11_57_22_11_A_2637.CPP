#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

typedef vector <int> VI;

#define PB push_back

#define m 1010

VI to[m];
int n1, n2, k, ma[m], mf[m], u[m], tma[m], tmf[m];

int dfs( int v )
{
  u[v] = 1;
  for (int i = 0; i < to[v].size(); i++)
    if (to[v][i] != -1)
      if (ma[to[v][i]] == -1 || (!u[ma[to[v][i]]] && dfs(ma[to[v][i]])))
      {
        ma[to[v][i]] = v, mf[v] = to[v][i];
        return 1;
      }
  return 0;
}

int main( void )
{
  freopen("pairs.in", "rt", stdin);
  freopen("pairs.out", "wt", stdout);
  scanf("%d%d%d", &n1, &n2, &k);
  for (int i = 0; i < k; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b), a--, b--;
    to[a].PB(b);
  }
  memset(ma, -1, sizeof(ma));
  memset(mf, -1, sizeof(mf));
  for (int i = 0; i < n1; i++)
    if (mf[i] == -1)
    {
      memset(u, 0, sizeof(u));
      dfs(i);
    }
  int ans = 0;
  for (int i = 0; i < n1; i++)
    for (int l = 0; l < to[i].size(); l++)
      if (ma[to[i][l]] == i)
        for (int j = 0; j < n1; j++)
          for (int k = 0; k < to[j].size(); k++)
            if (j != i || l != k)
            {
              memcpy(tma, ma, sizeof(tma));
              memcpy(tmf, mf, sizeof(tmf));
              int a = to[i][l], b = to[j][k], ima = ma[b] == j, nu = 1 + ima;
              to[i][l] = to[j][k] = ma[a] = mf[i] = mf[j] = -1;
              if (ima) ma[b] = -1;
              for (int f = 0; f < 2; f++)
              {
                memset(u, 0, sizeof(u));
                for (int o = 0; o < n1; o++)
                  if (!u[o] && mf[o] == -1)
                    if (dfs(o))
                    {
                      nu--;
                      break;
                    }
              }
              if (nu)
                ans += 2 - ima/*, fprintf(stderr, "(%d %d) (%d %d)\n", i, a, j, b)*/;
              to[i][l] = a, to[j][k] = b;
              memcpy(mf, tmf, sizeof(tmf));
              memcpy(ma, tma, sizeof(tma));
            }
  printf("%d\n", ans / 2);
  return 0;
}
