#include <cstdio>

unsigned long long cnt[45][3];

int main( void )
{
  freopen("badsubstr.in", "rt", stdin);
  freopen("badsubstr.out", "wt", stdout);
  int n;
  scanf("%d", &n);
  if (!n)
  {
    printf("1\n");
    return 0;
  }
  cnt[1][0] = 1;
  cnt[1][1] = 1;
  cnt[1][2] = 1;
  for (int i = 2; i <= n; i++)
    cnt[i][0] = cnt[i - 1][0] + cnt[i - 1][1] + cnt[i - 1][2],
    cnt[i][1] = cnt[i - 1][1] + cnt[i - 1][2],
    cnt[i][2] = cnt[i - 1][0] + cnt[i - 1][1] + cnt[i - 1][2];
  printf("%I64u", cnt[n][0] + cnt[n][1] + cnt[n][2]);
  return 0;
}