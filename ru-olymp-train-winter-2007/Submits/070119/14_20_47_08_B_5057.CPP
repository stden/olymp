#include <cstdio>
#include <cstring>

#define maxn 210

int D[maxn][maxn], C[maxn], N;

void dfs( int u, int p )
{
  C[u] = 1;
  for (int i = 0; i < N; i++)
    if (!C[i] && D[u][i] >= 0 && (p & (1 << D[u][i])))
      dfs(i, p);
}

int main( void )
{
  freopen("optimum.in", "rt", stdin);
  freopen("optimum.out", "wt", stdout);

  int M, P;
  scanf("%d%d%d", &N, &M, &P);
  memset(D, -1, sizeof (D));
  for (int i = 0; i < M; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    D[a - 1][b - 1] = D[b - 1][a - 1] = i;
  }

  int Ans = 0;
  for (int p = 0; p < (1 << M); p++)
  {
    int K = 0;
    for (int i = 0; i < M; i++)
      if (p & (1 << i))
        K++;
    if (K != N - 1)
      continue;
    memset(C, 0, sizeof(C));
    dfs(0, p);
    int f = 1;
    for (int j = 0; j < N && f; j++)
      if (!C[j])
        f = 0;
    Ans += f;
  }
  printf("%d\n", Ans % P);

  return 0;
}
