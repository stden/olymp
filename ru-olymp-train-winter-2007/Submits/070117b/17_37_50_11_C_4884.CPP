#include <cstdio>
#include <cstring>

#define min(a, b) ((a) < (b) ? (a) : (b))

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
    for (int j = 0; j < n; j++)
      if (p[i] < 1e9)
      {
        p[min(i + 1, n)] <?= p[i] + a[i][0];
        p[min(i + 2, n)] <?= p[i] + a[i][1];
        p[min(i + 3, n)] <?= p[i] + a[i][2];
      }
  printf("%d\n", p[n]);
  return 0;
}
