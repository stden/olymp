#include <algorithm>
#include <cstdio>
#include <vector>

using namespace std;

typedef vector <int> VI;
#define PB push_back

#define maxn 20
#define maxw 510

int R[maxn], C[maxn], A[maxn], W[maxn];
int D[maxn][maxw], T[maxn][maxw][2][maxw];
VI V[maxn];

int F( int u, int w )
{
  if (D[u][w] != -1)
    return D[u][w];
  int Res = 0;
  if (w >= W[u])
    Res = A[u];
  memset(T[u][w], 0, sizeof(T[u][w]));
  int K = 0;
  for (int i = 0; i < (int)V[u].size(); i++)
  {
    memset(T[u][w][1 - K], 0, sizeof(T[u][w][1 - K]));
    for (int j = 0; j < w; j++)
      for (int k = 1; k <= w - j; k++)
        T[u][w][1 - K][j + k] = max(T[u][w][1 - K][j + k], T[u][w][K][j] + F(V[u][i], k));
    K = 1 - K;
  }
  for (int i = 0; i <= w; i++)
    if (T[u][w][K][i] + A[u] > C[u])
      Res = max(Res, T[u][w][K][i] + A[u]);
  for (int i = W[u]; i <= w; i++)
    Res = max(Res, T[u][w][K][i - W[u]] + A[u]);
  return D[u][w] = Res;
}

int main( void )
{
  freopen("system.in", "rt", stdin);
  freopen("system.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
  {
    scanf("%d%d%d%d", &R[i], &C[i], &A[i], &W[i]);
    if (--R[i] != -1)
      V[R[i]].PB(i);
  }

  int Ans = W[0];
  memset(D, -1, sizeof(D));
  for (int i = 1; i < Ans; i++)
    if (F(0, i))
      Ans = i;

  printf("%d\n", Ans);

  return 0;
}
