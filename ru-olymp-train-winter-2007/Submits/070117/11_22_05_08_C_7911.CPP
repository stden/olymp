#include <cstdio>
#include <cstdlib>
#include <cstring>

#define maxn 35
#define maxt 60

typedef long long Long;

typedef int Matrix [maxn][maxn];

int N, P;

void Mul( Matrix &A, Matrix B )
{
  Matrix R;
  memset(R, 0, sizeof(R));
  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      for (int k = 0; k < N; k++)
        R[i][j] = (R[i][j] + (Long)A[i][k] * B[k][j]) % P;
  memcpy(A, R, sizeof(R));
}

void Mul2( Matrix &A )
{
  Matrix R;
  memset(R, 0, sizeof(R));
  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      for (int k = 0; k < N; k++)
        R[i][j] = (R[i][j] + (Long)A[i][k] * A[k][j]) % P;
  memcpy(A, R, sizeof(R));
}

void Power( Matrix &A, int P )
{
  Matrix R;
  memset(R, 0, sizeof(R));
  for (int i = 0; i < N; i++)
    R[i][i] = 1;
  for (; P; P >>= 1)
  {
    if (P & 1)
      Mul(R, A);
    Mul2(A);
  }
  memcpy(A, R, sizeof(R));
}

int G[maxn][maxn], A[maxt], B[maxt], D[maxn], C[maxn], F[maxn], Q[maxn], R[maxn];
Matrix X;

int main( void )
{
  freopen("restore.in", "rt", stdin);
  freopen("restore.out", "wt", stdout);

  int M;
  scanf("%d%d%d", &N, &M, &P);
  memset(G, 0, sizeof(G));
  for (int i = 0; i < M; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    G[a - 1][b - 1] = G[b - 1][a - 1] = 1;
  }
  int S, T;
  scanf("%d%d", &S, &T), S--;
  for (int i = 0; i < T; i++)
    scanf("%d%d", &A[i], &B[i]);
  memset(D, 0, sizeof(D));
  memset(C, 0, sizeof(C));
  int qs = 0, qz = 0;
  Q[qs + qz++] = S, C[S] = 1;
  while (qz)
  {
    int T = Q[qs++]; qz--;
    for (int i = 0; i < N; i++)
      if (G[T][i] && !C[i])
      {
        C[i] = 1, D[i] = D[T] + 1;
        Q[qs + qz++] = i;
      }
  }
  for (int i = 0; i < N; i++)
    if (D[i] == A[0])
      F[i] = 1;
  B[0]--;
  for (int i = 0; i < T; i++)
  {
    for (int j = 0; j < N; j++)
      for (int k = 0; k < N; k++)
        X[j][k] = G[j][k] && D[k] == A[i];
    Power(X, B[i]);
    memset(R, 0, sizeof(R));
    for (int i = 0; i < N; i++)
      for (int j = 0; j < N; j++)
        R[j] = (R[j] + (Long)F[i] * X[i][j]) % P;
    memcpy(F, R, sizeof(R));
  }
  int Ans = 0;
  for (int i = 0; i < N; i++)
    Ans = (Ans + F[i]) % P;
  printf("%d\n", Ans);

  return 0;
}
