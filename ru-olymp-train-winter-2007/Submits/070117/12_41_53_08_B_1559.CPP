#include <cstdio>
#include <cstring>

#define maxn 510

int A[maxn][maxn], X[maxn][maxn], B[maxn], C[maxn], Is[maxn], R[maxn], L[maxn];

int main( void )
{
  freopen("radio.in", "rt", stdin);
  freopen("radio.out", "wt", stdout);

  int N, M;
  scanf("%d%d", &M, &N);
  for (int i = 0; i < M; i++)
    for (int j = 0; j < N; j++)
      scanf("%d", &A[i][j]);
  for (int i = 0; i < M; i++)
    scanf("%d", &B[i]);
  for (int i = 0; i < N; i++)
    scanf("%d", &C[i]);

  memset(Is, 0, sizeof(Is));
  memset(X, 0, sizeof(X));
  for (int i = 0; i < N; i++)
    X[i][i] = 1;
  for (int i = 0; i < M; i++)
  {
    int k = -1;
    for (int j = 0; j < N; j++)
      if (!Is[j])
      {
        int t;
        for (t = i; t < M && A[t][j] == 1; t++)
          ;
        L[j] = t - i;
        if ((k == -1 || L[j] < L[k]) && L[j] != 0)
          k = j;
      }
    if (k == -1)
      if (B[i] == 0)
        continue;
      else
      {
        printf("-1\n");
        return 0;
      }
    Is[k] = 1;
    for (int j = 0; j < N; j++)
      if (!Is[j] && A[i][j] == 1)
      {
        for (int t = i; t < L[k] + i; t++)
          A[t][j] = 0;
        X[k][j] = 1;
      }
    R[k] = B[i];
    for (int t = 0; t < L[k]; t++)
    {
      B[i + t] -= R[k];
      if (B[i + t] < 0)
      {
        printf("-1\n");
        return 0;
      }
    }
  }
  for (int i = 0; i < N; i++)
    if (!Is[i])
      R[i] = 0;

  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      if (X[j][i] && i != j)
      {
        int C = X[j][i];
        for (int k = 0; k < N; k++)
          X[j][k] -= X[i][k] * C;
        R[j] -= R[i] * C;
      }


  for (int i = 0; i < N; i++)
    if (R[i] < 0)
    {
      printf("-1\n");
      return 0;
    }

  int Ans = 0;
  for (int i = 0; i < N; i++)
    Ans += C[i] * R[i];

  printf("%d\n", Ans);
  for (int i = 0; i < N; i++)
    printf("%d%c", R[i], i < N - 1 ? ' ' : '\n');

  return 0;
}
