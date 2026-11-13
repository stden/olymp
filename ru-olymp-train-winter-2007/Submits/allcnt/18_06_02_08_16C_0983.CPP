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

int _stklen = 20 << 20;


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

int Leaf[maxn], D2[maxn];

int dfs2( int u )
{
  if (D2[u] != -1)
    return D2[u];
  int Ans = Leaf[u];
  for (int i = 0; i < V[u].size(); i++)
    Ans += dfs2(V[u][i]);
  return D2[u] = Ans;
}

int D3[maxn];

int dfs3( int u, int Bonus )
{
  if (D3[u] != -1)
    return D3[u];
  if (Bonus >= D2[u])
    return D3[u] = 0;
  if (V[u].size() == 0)
  {
    fprintf(stderr, "?? Ботва... =(\n");
    return D3[u] = 0;
  }
  int j = 0;
  for (int i = 1; i < V[u].size(); i++)
    if (D2[V[u][i]] > D2[V[u][j]])
      j = i;
  if (D2[V[u][j]] - Bonus <= D2[u] - D2[V[u][j]])
    return D3[u] = (D2[u] - Bonus + 1) / 2;
  else
    return D3[u] = dfs3(V[u][j], Bonus + D2[u] - D2[V[u][j]]) + D2[u] - D2[V[u][j]];
}

void FindLeafs( int u, VI &Output)
{
  if (Leaf[u])
    Output.PB(u);
  for (int i = 0; i < V[u].size(); i++)
    FindLeafs(V[u][i], Output);
}

VI BData(0);
vector <PII> Result(0);

void Output( int u, int Bonus )
{
  if (Bonus >= D2[u])
    return;
  if (V[u].size() == 0)
  {
    fprintf(stderr, "?? Ботва... =(\n");
    return;
  }
  int j = 0;
  for (int i = 1; i < V[u].size(); i++)
    if (D2[V[u][i]] > D2[V[u][j]])
      j = i;

  if (D2[V[u][j]] - Bonus <= D2[u] - D2[V[u][j]])
  {
    vector <VI> Data(0);
    int Total = BData.size();
    Data.PB(BData);
    for (int i = 0; i < V[u].size(); i++)
    {
      VI Temp(0);
      FindLeafs(V[u][i], Temp);
      Total += Temp.size();
      Data.PB(Temp);
    }
    set <PII> Heap;
    for (int i = 0; i < Data.size(); i++)
      Heap.insert(MP(Data[i].size(), i));
    VI Index(Data.size(), 0);
    VI Count(Data.size());
    for (int i = 0; i < Data.size(); i++)
      Count[i] = Data[i].size();
    while (Total)
    {
      set <PII> :: iterator Last = Heap.end();
      Last--;
      int A = Last->SE;
      Last--;
      int B = Last->SE;
      Heap.erase(MP(Count[A], A));
      Heap.erase(MP(Count[B], B));
      Result.PB(MP(Data[A][Index[A]], Data[B][Index[B]]));
      Index[A]++, Total--, Count[A]--;
      if (Total & 1)
        Index[B]++, Total--, Count[B]--;
      if (Count[A])
        Heap.insert(MP(Count[A], A));
      if (Count[B])
        Heap.insert(MP(Count[B], B));
    }
  }
  else
  {
    for (int i = 0; i < V[u].size(); i++)
      if (i != j)
        FindLeafs(V[u][i], BData);
    Output(V[u][j], Bonus + D2[u] - D2[V[u][j]]);
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
  for (int i = 0; i < N; i++)
    Leaf[i] = V[i].size() == 1;
  int Root = -1;
  for (int i = 0; i < N && Root == -1; i++)
    if (!Leaf[i])
      Root = i;
  if (Root == -1)
  {
    printf("1\n");
    printf("1 2\n");
    fprintf(stderr, "хз что случилось :( Все вершины - листья!\n");
    return 0;
  }
  dfs1(Root, -1);
  memset(D2, -1, sizeof(D2));
  int Leafs = dfs2(Root);
  fprintf(stderr, "Листьев в дереве: %d\n", Leafs);
  memset(D3, -1, sizeof(D3));
  int Ans = dfs3(Root, 0);
  fprintf(stderr, "Ответ на задачу: %d\n", Ans);
  Output(Root, 0);
  printf("%d\n", Ans);
  for (int i = 0; i < Result.size(); i++)
    printf("%d %d\n", Result[i].FI + 1, Result[i].SE + 1);

  return 0;
}
