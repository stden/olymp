#include <cstdio>
#include <cstring>

#define min(a, b) ((a) < (b) ? (a) : (b))
#define max(a, b) ((a) > (b) ? (a) : (b))

#define m 10100

int p[m], a[m][3], n;

int main( void )
{
  freopen("linguae.in", "rt", stdin);
  freopen("linguae.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < 3; j++)
      scanf("%d", &a[i][j]);
  for (int i = 0; i <= n; i++)
    p[i] = (int)1e9;
  p[0] = 0;
  for (int i = 0; i < n; i++)
    for (int j = max(0, i - 3); j <= i; j++)
      if (p[i] < 1e9)
      {
        p[min(j + 1, n)] <?= p[i] + a[j][0];
        p[min(j + 2, n)] <?= p[i] + a[j][1];
        p[min(j + 3, n)] <?= p[i] + a[j][2];
      }
  printf("%d\n", p[n]);
  return 0;
}
