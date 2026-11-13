#include <algorithm>
#include <cstdio>
#include <cstdlib>
#include <cstring>

using namespace std;

#define maxl 60

char S[maxl];
int D[maxl][maxl][2];
int D2[maxl][maxl][2];

int F( int L, int N, int FF )
{
  if (D[L][N][FF] != -1)
    return D[L][N][FF];
  if (N == 0)
    return D[L][N][FF] = 0;
  int Res = min(F(L + 1, N - 1, 1), F(L, N - 1, FF)) + 1;
  for (int i = 1; i < N; i++)
    Res = min(Res, F(L, i, FF) + F(L + i, N - i, 1));
  if ((N & 1) == 0)
  {
    int f = 1;
    for (int j = 0; j < N / 2 && f; j++)
      if (S[L + N / 2 + j] != S[L + j])
        f = 0;
    if (f)
      Res = min(Res, F(L, N / 2, 0) + 1 + FF);
  }
  return D[L][N][FF] = Res;
}

int F2( int L, int N, int FF )
{
  if (D2[L][N][FF] != -1)
    return D2[L][N][FF];
  if (N == 0)
    return D2[L][N][FF] = 0;
  if (N == 1)
    return D2[L][N][FF] = 1;
  int Res = min(F2(L + 1, N - 1, 1), F2(L, N - 1, FF)) + 1;
  for (int i = 1; i < N; i++)
    Res = min(Res, F2(L, i, FF) + F2(L + i, N - i, 1));
  if ((N & 1) == 0)
  {
    int f = 1;
    for (int j = 0; j < N / 2; j++)
      if (S[L + N / 2 + j] != S[L + j])
        f = 0;
    if (f)
      Res = min(Res, F2(L, N / 2, 0) + 1 + FF);
  }
  return D2[L][N][FF] = Res;
}

int main( void )
{
  freopen("repeat.in", "rt", stdin);
  freopen("repeat.out", "wt", stdout);

  scanf("%s", S);
  int N = strlen(S);
  memset(D, -1, sizeof(D));
  memset(D2, -1, sizeof(D2));
  printf("%d\n", F2(0, N, 0));
  while (0)
  {
    N = rand() % 10 + 1;
    for (int i = 0; i < N; i++)
      S[i] = 'a' + rand() % 26;
    memset(D, -1, sizeof(D));
    memset(D2, -1, sizeof(D2));
    if (F(0, N, 0) != F2(0, N, 0))
    {
      fprintf(stderr, "Wrong!\n");
      while(1);
    }
  }

  return 0;
}
