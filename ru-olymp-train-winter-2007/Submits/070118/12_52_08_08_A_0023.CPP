#include <cstdio>
#include <cstring>

#define maxn 16
#define maxp 33010

int N, C[maxp][maxn], A[maxn][maxn];
double B[maxn][maxn], D[maxp][maxn];

double F( int p, int k )
{
  if (C[p][k])
    return D[p][k];
  C[p][k] = 1;
  double P = 1, Ans = 0;
  if ((p & (p - 1)) == 0)
    return D[p][k] = 0;
  int next;
  int Turn = 1;
  for (int i = k; ; i = next, Turn++)
  {
    next = i + 1;
    if (next >= N)
      next -= N;
    if (p & (1 << i))
    {
      int S = 0;
      for (int j = 0; j < N; j++)
        if (p & (1 << j) && i != j)
          S += A[i][j];
      double T = 1;
      for (int j = 0; j < N; j++)
        if (p & (1 << j) && i != j)
        {
          int next2 = next;
          for (; !(p & (1 << next2)) || next2 == j; )
            if (++next2 >= N)
              next2 -= N;
          double Val = B[i][j] * A[i][j] / S;
          Ans += P * Val * (F(p - (1 << j), next2) + Turn);
          T = T - Val;
        }
      P = T * P;
    }
    if (next == k)
    {
      Ans = (Ans + P * Turn) / (1 - P);
      break;
    }
  }
  return D[p][k] = Ans;
}

int main( void )
{
  freopen("game.in", "rt", stdin);
  freopen("game.out", "wt", stdout);

  scanf("%d", &N);
  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      scanf("%d", &A[i][j]);
  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      scanf("%lf", &B[i][j]);
  memset(C, 0, sizeof(C));
  printf("%.5lf\n", F((1 << N) - 1, 0));

  return 0;
}
