#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;

#define PB push_back
#define FI first
#define SE second
#define MP make_pair

vector <vector<pair<int, int> > > v;
vector <int> res;

int N, M;
int d[30000], md[30000], was[30000];

void dfs(int i, int t, int prev)
{
  was[i] = 1;
/*  if (d == 0 && v[i].size() == 1)
  {
    res.PB(v[i][0].SE);
  }*/
  md[i] = t;
  d[i] = t;
  for (int j = 0; j < v[i].size(); j++)
  if (v[i][j].FI != prev)
  {
    if (!was[v[i][j].FI])
    {
      dfs(v[i][j].FI, t + 1, i);
      if (md[v[i][j].FI] > t)
        res.PB(v[i][j].SE);
    }
    if (md[i] > md[v[i][j].FI])
      md[i] = md[v[i][j].FI];
  }
}
int main( void )
{
  freopen("bridges.in", "rt", stdin);
  freopen("bridges.out", "wt", stdout);

  scanf("%d%d", &N, &M);  
  v.resize(N + 1);
  for (int a, b, i = 0; i < M; i++)
  {
    scanf("%d%d", &a, &b);
    v[a].PB(MP(b, i + 1));
    v[b].PB(MP(a, i + 1));
  }
  memset(was, 0, sizeof(was));
  dfs(1, 0, -1);
  sort(res.begin(), res.end());
  printf("%d\n", res.size());
  for (int i = 0; i < res.size(); i++)
    printf("%d%c", res[i], i < res.size() - 1 ? ' ' : '\n');
  return 0;
}
