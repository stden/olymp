#include <cstdio>
#include <cstring>
#include <vector>


#define maxn 300002
#define PB push_back

using namespace std;

vector < vector <int> > ex;
int px[maxn], py[maxn], wasx[maxn], wasy[maxn], yn, xn, nc, may, tpx[maxn], tpy[maxn], a, b;

int dfs( int v, int isy )
{
  if (isy)
  {
    wasy[v] = 1;
    if (py[v] && !wasx[py[v]])
      return dfs(py[v], 0);
    return 1;
  }
  else
  {
    wasx[v] = 1;
    for (int i = 0; i < ex[v].size(); i++)
      if ((a != v || ex[v][i] != b) && px[v] != ex[v][i] && !wasy[ex[v][i]] && dfs(ex[v][i], 1))
      {
        px[v] = ex[v][i];
        py[ex[v][i]] = v;
        return 1;
      }
  }
  return 0;
}

int main( void )
{
  freopen("omax.in", "rt", stdin);
  freopen("omax.out", "wt", stdout);
  scanf("%d", &xn);
  ex.resize(xn + 1);
  for (int i = 1; i <= xn; i++)
  {
    int t;
    scanf("%d", &t);
    for (int j = 0; j < t; j++)
    {
      int q;
      scanf("%d", &q);
      ex[i].PB(q);
      if (!py[q] && !px[i])
        px[i] = q, py[q] = i, nc++, may++;
      if (yn < q)
        yn = q;
    }
  }
  for (int i = 1; i <= xn; i++)
    if (px[i])
    {
      if (!may)
      {
        printf("NO\n");
        return 0;
      }
      may--;
    }
    else
    {
      memset(wasx, 0, sizeof(int) * (xn + 1));
      memset(wasy, 0, sizeof(int) * (yn + 1));
      if (!dfs(i, 0))
      {
        printf("NO\n");
        return 0;
      }
    }
  for (int i = 1; i <= xn; i++)
  {
    memset(wasx, 0, sizeof(int) * (xn + 1));
    memset(wasy, 0, sizeof(int) * (yn + 1));
    for (int j = 1; j <= xn; j++)
      tpx[j] = px[j];
    for (int j = 1; j <= yn; j++)
      tpy[j] = py[j];
    
    a = i;
    b = px[i];
    px[a] = 0;
    py[b] = 0;
    if (dfs(i, 0))
    {
      printf("NO\n");
      return 0;
    }
    for (int j = 1; j <= xn; j++)
      px[j] = tpx[j];
    for (int j = 1; j <= yn; j++)
      py[j] = tpy[j];
  }
  printf("YES\n");
  for (int i = 1; i <= xn; i++)
    printf("%d%c", px[i], i < xn ? ' ' : '\n');
  return 0;
}