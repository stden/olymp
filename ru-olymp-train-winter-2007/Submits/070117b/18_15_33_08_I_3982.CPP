#include <cstdio>
#include <cstring>

#define maxn 240010

int A[maxn], D[maxn];

int main( void )
{
  freopen("subseq.in", "rt", stdin);
  freopen("subseq.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
    scanf("%d", &A[i]);

  memset(D, -1, sizeof(D));
  for (int i = 0; i < N; i++)
  {
    int Min = 0;
    int Max = N;
    while (Min < Max)
    {
      int Ave= (Min + Max + 1) / 2;
      if (D[Ave] != -1 && A[D[Ave]] >= A[i])
        Min = Ave;
      else
        Max = Ave - 1;
    }
    D[Min + 1] = i;
  }

  int X;
  for (X = N; X >= 0 && D[X] == -1; X--)
    ;
  printf("%d\n", X);
  for (int i = 1; i <= X; i++)
    printf("%d\n", D[i] + 1);

  return 0;
}
