#include <cstdio>

int _stklen = 20 << 20;

long long F( long long N, int K )
{
  if (N == 1)
    return 0;
  if (N % K)
  {
    long long T = F(N - 1, K);
    T = (T + K) % N;
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
  scanf("%I64d%d", &N, &K);
  printf("%I64d\n", F(N, K) + 1);

  return 0;
}
