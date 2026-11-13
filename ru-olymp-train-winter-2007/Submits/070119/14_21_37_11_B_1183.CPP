#include <cstdio>
#include <vector>

using namespace std;

#define m 222

vector <int> to[m];
int n, k, u[m], s[m], sp, ans = 1, p;

void dfs( int v, int pa )
{
  u[v] = 1;
  s[sp++] = v;
  for (int i = 0; i < to[v].size(); i++)
    if (!u[to[v][i]])
      dfs(to[v][i], v);
    else if (to[v][i] != pa)
      for (int j = sp - 2; j >= 0; j--)
        if (s[j] == to[v][i])
          ans = (ans * (sp - j)) % p;
  sp--;
}

int main( void )
{
  freopen("optimum.in", "rt", stdin);
  freopen("optimum.out", "wt", stdout);
  scanf("%d%d%d", &n, &k, &p);
  for (int i = 0; i < k; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b), a--, b--;
    to[a].push_back(b), to[b].push_back(a);
  }
  memset(u, 0, sizeof(u));
  dfs(0, -1);
  for (int i = 0; i < n; i++)
    if (!u[i])
    {
      printf("0");
      return 0;
    }
  printf("%d\n", ans % p);
  return 0;
}
