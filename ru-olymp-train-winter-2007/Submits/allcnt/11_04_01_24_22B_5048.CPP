#include <cstdio>
#include <vector>
#include <cstring>

#define PB push_back
#define  maxc 10001

using namespace std;

int n;
vector <vector <int> > ne;
vector <int> c, w, a, p;

int min( int a, int b )
{
  if (a < b)
    return a;
  return b;
}

int dp[202][maxc + 1];

int c1[maxc + 1], c2[maxc + 1], cn1, cn2, tmp[maxc + 1];

void up( int v1, int v2 )
{
  cn1 = 0; 
  cn2 = 0;
  memset(tmp, -1, sizeof(tmp));
  for (int i = 0; i <= maxc; i++)
    if (dp[v1][i] + 1)
      c1[cn1++] = i;
  for (int i = 0; i <= maxc; i++)
    if (dp[v2][i] + 1)
      c2[cn2++] = i;
  for (int i = 0; i < cn1; i++)
    for (int j = 0; j < cn2; j++)
    {
      int t = min(c1[i] + c2[j], maxc);
      if (!(tmp[t] + 1) || tmp[t] > dp[v1][c1[i]] + dp[v2][c2[j]])
        tmp[t] = dp[v1][c1[i]] + dp[v2][c2[j]];
    }
  for (int i = 0; i <= maxc; i++)
    dp[v1][i] = tmp[i];
}


void check( int v, int c, int w )
{
  if (!(dp[v][c] + 1) || dp[v][c] > w)
    dp[v][c] = w;
}

void dfs( int v )
{
  for (int i = 0; i < ne[v].size(); i++)
    dfs(ne[v][i]);
  for (int i = ne[v].size() - 1; i >= 1; i--)
    up(ne[v][i - 1], ne[v][i]);
   
  dp[v][0] = 0;
  dp[v][a[v]] = w[v];
//  fprintf(stderr, "v = %d\n", v);
  if (ne[v].size())
  {
    for (int v1 = ne[v][0], i = 0; i <= maxc; i++)
    {
      if (dp[v1][i] + 1)	         	
         check(v, min(i + a[v], maxc), dp[v1][i] + (i + a[v] <= c[v]) * w[v]);
//      fprintf(stderr, "%d : %d\n", i, dp[v1][i]);
    }
  }
}

int main( void )
{
  freopen("system.in", "rt", stdin);
  freopen("system.out", "wt", stdout);

  scanf("%d", &n);
  ne.resize(n + 1);
  c.resize(n + 1);
  w.resize(n + 1);
  a.resize(n + 1);
  p.resize(n + 1);
  for (int i = 1; i <= n; i++)
  {
    int ri, ci, ai, wi;
    scanf("%d%d%d%d", &ri, &ci, &ai, &wi);
    ne[ri].PB(i);
    c[i] = ci;
    p[i] = ri;
    a[i] = ai;
    w[i] = wi;
  }
  memset(dp, -1, sizeof(dp));
//  fprintf(stderr, "in dfs\n");
  dfs(1);
//  fprintf(stderr, "out dfs\n");
/*  for (int i = 0; i <= maxc; i++)
    fprintf(stderr, "%d : %d\n", i, dp[1][i]);*/
  for (int i = 0; i <= maxc; i++)
    if (res > dp[1][i] && dp[1][i] + 1)
      res = dp[1][i];

  printf("%d\n", res);
  return 0;
}