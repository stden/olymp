#include <algorithm>
#include <cstdio>
#include <cstring>

using namespace std;

typedef long long Long;

#define INF (Long)1e18

#define maxn 25

int C[maxn];
Long G[maxn][maxn], R[maxn][maxn], Temp[maxn][maxn];

int main( void )
{
  freopen("maxsum.in", "rt", stdin);
  freopen("maxsum.out", "wt", stdout);

  int N, M;
  Long K;
  scanf("%d%d%I64d", &N, &M, &K);
  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      G[i][j] = R[i][j] = -INF;
  for (int i = 0; i < N; i++)
    scanf("%d", &C[i]);
  for (int i = 0; i < M; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    G[a - 1][b - 1] = C[b - 1];
  }

  for (int i = 0; i < N; i++)
    R[i][i] = 0;
  for (; K; K >>= 1)
  {
    if (K & 1)
    {
      for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
          Temp[i][j] = -INF;
      for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
          for (int k = 0; k < N; k++)
            Temp[i][j] = max(Temp[i][j], R[i][k] + G[k][j]);
      memcpy(R, Temp, sizeof(Temp));
    }
    for (int i = 0; i < N; i++)
      for (int j = 0; j < N; j++)
        Temp[i][j] = -INF;
    for (int i = 0; i < N; i++)
      for (int j = 0; j < N; j++)
        for (int k = 0; k < N; k++)
          Temp[i][j] = max(Temp[i][j], G[i][k] + G[k][j]);
    memcpy(G, Temp, sizeof(Temp));
  }

  Long Ans = C[0];
  for (int i = 0; i < N; i++)
    Ans = max(Ans, C[0] + R[0][i]);
  printf("%I64d\n", Ans);

  return 0;
}
