#include <cstdio>

int main( void )
{
  freopen("psyche.in", "rt", stdin);
  freopen("psyche.out", "wt", stdout);
  long long n;
  int k;
  scanf("%Ld%d", &n, &k);
//  long long ans = 0;
//  for (int i = 1; i <= n; i++)
//    ans = (ans + k) % i;
//  printf("%Ld\n", ans + 1);
  if (k == 1)
  {
    printf("%Ld", n);
    return 0;
  }
  long long a = 0, i = 1;
  while (i < n)
  {
    long long x = (i - a + k - 2) / (k - 1);
//    printf("i=%Ld a=%Ld x=%Ld\n", i, a, x);
    if (i + x > n)
    {
      printf("%Ld", (a + (n - i) * k) % n + 1);
      return 0;
    }
    i += x, a += k * x, a %= i;
  }
  printf("%Ld", a + 1);
  return 0;
}
