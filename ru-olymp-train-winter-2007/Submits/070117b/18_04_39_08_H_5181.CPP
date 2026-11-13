#include <algorithm>
#include <cstdio>
#include <cstring>

using namespace std;

#define maxl 60

char S[maxl];
int D[maxl][maxl][2];

int F( int L, int N, int FF )
{
  if (D[L][N][FF] != -1)
    return D[L][N][FF];
  if (N == 0)
    return D[L][N][FF] = 0;
  int Res = min(F(L + 1, N - 1, 1), F(L, N - 1, FF)) + 1;
  for (int i = 2; i < N; i++)
    for (int j = 1; j * i <= N; j++)
      if (i * j == N)
      {
        int f = 1;
        for (int ii = 0; ii < i; ii++)
          for (int jj = 0; jj < j; jj++)
            if (S[L + ii * i + jj] != S[L + jj])
              f = 0;
        if (!f)
          continue;
        Res = min(Res, F(L, j, 0) + 1 + FF);
      }
  return D[L][N][FF] = Res;
}

int main( void )
{
  freopen("repeat.in", "rt", stdin);
  freopen("repeat.out", "wt", stdout);

  scanf("%s", S);
  int N = strlen(S);
  memset(D, -1, sizeof(D));
  printf("%d\n", F(0, N, 0));

  return 0;
}
