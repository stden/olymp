#include <cstdio>

int main( void )
{
  freopen("psyche.in", "rt", stdin);
  freopen("psyche.out", "wt", stdout);
  long long n;
  int k;
  scanf("%Ld%d", &n, &k);
  if (k == 1)
  {
    printf("%Ld", n);
    return 0;
  }
  int i = 1;
  long long a = 0;
  while (i < n)
  {
    long long x = (i - a + k - 2) / (k - 1);
    if (i + x > n)
    {
      printf("%Ld", (a + (n - i) * k) % n + 1);
      return 0;
    }
    i += x, a += k * x, a %= i;
  }
  printf("%Ld", a);
  return 0;
}
