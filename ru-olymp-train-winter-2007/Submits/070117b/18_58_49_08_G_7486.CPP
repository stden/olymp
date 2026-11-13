#include <cstdio>

int _stcklen = 20 << 20;

long long F( long long N, int K )
{
  if (N == 0)
    return 0;
  if (N == 1)
    return 0;
  if (N % K)
  {
    long long T = F(N - N % K, K);
    for (int i = 0; i < N % K; i++)
      T = (T + K) % (N - N % K + i + 1);
    return T;
  }
  else
  {
    long long T = F(N - N / K, K);
    T += T / (K - 1);
    return T;
  }
}

int main( void )
{
  freopen("psyche.in", "rt", stdin);
  freopen("psyche.out", "wt", stdout);

  int K;
  long long N;
  scanf("%Ld%d", &N, &K);
  printf("%Ld\n", F(N, K) + 1);

  return 0;
}
