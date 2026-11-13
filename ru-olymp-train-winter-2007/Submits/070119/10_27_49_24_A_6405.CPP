#include <cstdio>

int main( void )
{
  int N;

  long long A, B;

  freopen("sumtwo.in", "rt", stdin);
  freopen("sumtwo.out", "wt", stdout);

  int K;
  scanf("%d", &K);
  while (K--)
  {
    scanf("%Ld%Ld", &A, &B);
    printf("%Ld\n", A + B);
  }
  return 0;
}
