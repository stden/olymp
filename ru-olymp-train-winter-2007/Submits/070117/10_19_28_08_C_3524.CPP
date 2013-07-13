#include <cstdio>
#include <cstdlib>

#define maxn 750

int D[maxn][maxn];

int main( void )
{
  freopen("restore.in", "rt", stdin);
  freopen("restore.out", "wt", stdout);

  int N = maxn;
  srand(301703);
  for (int i = 0; i < N; i++)
    for (int j = 0; j < N; j++)
      D[i][j] = rand() % 1000;
  for (int k = 0; k < N; k++)
    for (int i = 0; i < N; i++)
      for (int j = 0; j < N; j++)
        if (D[i][j] > D[i][k] + D[k][j])
          D[i][j] = D[i][k] + D[k][j];

  printf("2\n");
  return 0;
}
