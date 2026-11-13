#include <cstdio>
#include <cstring>

int main( void )
{
  unsigned long long f[46][2];
  int n;
  freopen("badsubstr.in", "rt", stdin);
  freopen("badsubstr.out", "wt", stdout);
  scanf("%d", &n);
  memset(f, 0, sizeof(f));
  f[0][0] = 1;
  for (int i = 0; i < n; i++)
  {
    f[i + 1][0] = 2 * f[i][0] + f[i][1];
    f[i + 1][1] = f[i][0] + f[i][1];
  }
  printf("%Lu", f[n][0] + f[n][1]);
  return 0;
}
