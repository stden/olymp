#include <cstdio>
#include <cstring>

#define m 1010

long long T[m][m], G[m][m], D[m][m], F[m], n, ans;

int main( void )
{
  freopen("pines.in", "rt", stdin);
  freopen("pines.out", "wt", stdout);
  scanf("%Ld", &n);
  memset(T, 0, sizeof(T));
  memset(G, 0, sizeof(G));
  memset(D, 0, sizeof(D));
  memset(F, 0, sizeof(F));
  F[0] = F[1] = F[2] = 0, F[3] = 1;
  D[0][0] = 1;
  for (int i = 1; i <= n; i++)
  {
    if (i >= 4)
      F[i] = D[i - 1][i - 1];
    for (int j = 0; i * j <= n && F[i] >= j; j++)
    {
      T[i][j] = 1;
      for (int k = 0; k < j; k++)
        T[i][j] *= F[i] - k;
      for (int k = 1; k <= j; k++)
        T[i][j] /= k;
    }
    for (int j = 0; i * j <= n; j++)
    {
      G[i][j] = 0;
      for (int k = 1; k <= j; k++)
        G[i][j] += T[i][k];
    }
    G[i][0] = 1;
    D[0][i] = 1;
    for (int j = 1; j <= n; j++)
    {
      D[i][j] = 0;
      for (int k = 0; k * j <= i; k++)
        D[i][j] += G[j][k] * D[i - k * j][j - 1];
    }
  }
/*
  printf("T:\n");
  for (int i = 0; i <= n; i++)
    for (int j = 0; j <= n; j++)
      printf("%Ld%c", T[i][j], j == n ? '\n' : '\t');
  printf("G:\n");
  for (int i = 0; i <= n; i++)
    for (int j = 0; j <= n; j++)
      printf("%Ld%c", G[i][j], j == n ? '\n' : '\t');
  printf("D:\n");
  for (int i = 0; i <= n; i++)
    for (int j = 0; j <= n; j++)
      printf("%Ld%c", D[i][j], j == n ? '\n' : '\t');
*/
//  for (int i = 0; i <= n; i++)
//    printf("f[%d]=%Ld\n", i, F[i]);
  printf("%Ld", F[n]);
  return 0;
}
