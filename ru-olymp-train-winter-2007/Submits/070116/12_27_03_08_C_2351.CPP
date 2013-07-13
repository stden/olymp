#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>
#include <set>
#include <utility>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

typedef vector <int> VI;
typedef pair <int, int> PII;


#define maxn 50010

VI V[maxn];

void dfs1( int u, int p )
{
  VI C(0);
  for (int i = 0; i < (int)V[u].size(); i++)
    if (V[u][i] != p)
      C.PB(V[u][i]);
  for (int i = 0; i < (int)C.size(); i++)
    dfs1(C[i], u);
  V[u] = C;
}

int D[maxn][10];

int dfs2( int u, int b )
{
  if (D[u][b] != -1)
    return D[u][b];
  if (V[u].size() <= b)
    if (V[u].size() == 0)
      return D[u][b] = 0;
    else if (V[u].size() == 1)
      return D[u][b] = dfs2(V[u][0], b);
    else // 2 childs
      return D[u][b] = dfs2(V[u][0], 1), dfs2(V[u][1], 1);
  int Ans = (V[u].size() - b + 1) / 2;
  for (int i = 0; i < V[u].size(); i++)
    Ans += dfs2(V[u][i], 1);
  if (((V[u].size() + b) & 1) == 0)
    return D[u][b] = Ans;
  else
  {
    int Res = Ans;
    for (int i = 0; i < V[u].size(); i++)
      Ans = min(Ans, Res - dfs2(V[u][i], 1) + dfs2(V[u][i], 2));
    return D[u][b] = Ans;
  }
}

vector <PII> Result(0);

VI Out( int u, int b )
{
  if (V[u].size() <= b)
  {
    if (V[u].size() == 0)
      return VI(1, u);
    else if (V[u].size() == 1)
      return Out(V[u][0], b);
    else
    {
      VI T1 = Out(V[u][0], 1), T2 = Out(V[u][1], 1);
      for (int i = 0; i < T2.size(); i++)
        T1.PB(T2[i]);
      return T1;
    }
  }

  int Ans = (V[u].size() - b + 1) / 2;
  for (int i = 0; i < V[u].size(); i++)
    Ans += dfs2(V[u][i], 1);

  if (((V[u].size() + b) & 1) == 0 || Ans == D[u][b])
  {
    VI Res;
    int Curr = -1, Last = -1;
    for (int i = 0; i < V[u].size(); i++)
    {
      VI Temp = Out(V[u][i], 1);
      if (i == V[u].size() - 2)
        Last = Temp[0];
      if (i < b)
        for (int k = 0; k < Temp.size(); k++)
          Res.PB(Temp[k]);
      else if (Curr == -1)
        Curr = Temp[0];
      else
        Result.PB(MP(Curr, Temp[0])), Curr = -1;
    }
    if (Curr != -1 && Last != -1)
      Result.PB(MP(Curr, Last));

    return Res;
  }

  else
  {
    int Ans = (V[u].size() - b + 1) / 2;
    for (int i = 0; i < V[u].size(); i++)
      Ans += dfs2(V[u][i], 1);
    for (int i = 0; i < V[u].size(); i++)
      if (Ans - dfs2(V[u][i], 1) + dfs2(V[u][i], 2) == D[u][b])
      {
        VI Res;
        VI Temp = Out(V[u][i], 2);
        Res.PB(Temp[1]);
        int Curr = -1;
        for (int j = 0; j < V[u].size(); j++)
        {
          VI Temp = Out(V[u][j], 1);
          if (j < b - 1)
            Res.PB(Temp[0]);
          else if (Curr == -1)
            Curr = Temp[0];
          else
            Result.PB(MP(Curr, Temp[0])), Curr = -1;
        }
        return Res;
      }
  }
}


int main( void )
{
  freopen("biconn.in", "rt", stdin);
  freopen("biconn.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N - 1; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    V[a - 1].PB(b - 1);
    V[b - 1].PB(a - 1);
  }
  int Root = -1;
  for (int i = 0; i < N && Root == -1; i++)
    if (V[i].size() != 1)
      Root = i;
  if (Root == -1)
  {
    printf("0\n");
    fprintf(stderr, "хз что случилось :( Все вершины - листья!\n");
    return 0;
  }
  dfs1(Root, -1);
  memset(D, -1, sizeof(D));
  int Ans = dfs2(Root, 0);
  fprintf(stderr, "Ans = %d\n", Ans);
  Out(Root, 0);
  printf("%d\n", Ans);
  for (int i = 0; i < Result.size(); i++)
    printf("%d %d\n", Result[i].FI + 1, Result[i].SE + 1);

  return 0;
}
