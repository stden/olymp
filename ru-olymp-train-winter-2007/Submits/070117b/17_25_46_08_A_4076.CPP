#include <cstdio>
#include <string>

typedef unsigned long long Long;

Long D[50][4];

int main( void )
{
  freopen("badsubstr.in", "rt", stdin);
  freopen("badsubstr.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  memset(D, 0, sizeof(D));
  D[0][1] = 1;
  for (int i = 0; i < N; i++)
    for (int j = 0; j < 3; j++)
      if (D[i][j])
        for (int k = 0; k < 3; k++)
          if (j || k != 1)
            D[i + 1][k] += D[i][j];
  Long Ans = 0;
  for (int i = 0; i < 3; i++)
    Ans += D[N][i];
  printf("%I64d\n", Ans);

  return 0;
}
