#include <algorithm>
#include <cstdio>
#include <set>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

typedef vector <int> VI;
typedef pair <int, int> PII;


#define maxn 20010

int H[maxn], D[maxn], P[maxn];
vector <PII> V[maxn];

int dfs( int u, int p, int h )
{
  H[u] = h;
  D[u] = h;
  for (int i = 0; i < V[u].size(); i++)
    if (V[u][i].FI != p && H[V[u][i].FI] == -1)
      D[u] = min(D[u], dfs(V[u][i].FI, u, h + 1));
    else if (V[u][i].FI != p)
      D[u] = min(D[u], D[V[u][i].FI]);
    else
      P[u] = i;
  return D[u];
}

int main( void )
{
  freopen("bridges.in", "rt", stdin);
  freopen("bridges.out", "wt", stdout);

  int N, M;
  scanf("%d%d", &N, &M);
  for (int i = 0; i < M; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    V[a - 1].PB(MP(b - 1, i + 1));
    V[b - 1].PB(MP(a - 1, i + 1));
  }
  memset(H, -1, sizeof(H));
  memset(P, -1, sizeof(P));
  dfs(0, -1, 0);
  VI Ans;
  for (int i = 1; i < N; i++)
    if (D[i] >= H[i])
      Ans.PB(V[i][P[i]].SE);
  sort(Ans.begin(), Ans.end());
  printf("%d\n", Ans.size());
  for (int i = 0; i < Ans.size(); i++)
    printf("%d%c", Ans[i], i < Ans.size() - 1 ? ' ' : '\n');

  return 0;
}
