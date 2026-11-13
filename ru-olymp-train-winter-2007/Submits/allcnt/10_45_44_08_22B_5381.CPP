#include <algorithm>
#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

typedef vector <int> VI;
#define PB push_back

#define maxn 210
#define maxw 510

int R[maxn], C[maxn], A[maxn], W[maxn];
int B[maxn], T[maxn][2][maxw];
int D[maxn][maxw];
VI V[maxn];

void F( int u )
{
  if (B[u])
    return;
  int Res = 0;
  memset(T[u], 0, sizeof(T[u]));
  int K = 0;
  for (int i = 0; i < (int)V[u].size(); i++)
  {
    memset(T[u][1 - K], 0, sizeof(T[u][1 - K]));
    F(V[u][i]);
    for (int j = 0; j < maxw - 1; j++)
      for (int k = 0; k <= maxw - j - 1; k++)
        T[u][1 - K][j + k] = max(T[u][1 - K][j + k], T[u][K][j] + D[V[u][i]][k]);
    K = 1 - K;
  }
  memset(D[u], 0, sizeof(D[u]));
  for (int i = 0; i < maxw; i++)
  {
    if (T[u][K][i] + A[u] > C[u])
      D[u][i] = max(D[u][i], T[u][K][i] + A[u]);
    if (W[u] + i < maxw)
      D[u][i + W[u]] = max(D[u][i + W[u]], T[u][K][i] + A[u]);
  }
  B[u] = 1;
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
  memset(B, 0, sizeof(B));
  F(0);
  for (int i = 1; i < Ans; i++)
    if (D[0][i])
      Ans = i;

  printf("%d\n", Ans);

  return 0;
}
