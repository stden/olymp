#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

int d[10005];
int c[10001][3];

int main ()
{
  freopen ("linguae.in", "rt", stdin);
  freopen ("linguae.out", "wt", stdout);

  int n;
  scanf ("%d", &n);

  for (int i = 0; i < n; i++)
    scanf ("%d %d %d", &c[i][0], &c[i][1], &c[i][2]);

  d[0] = 0;
  for (int ri = 1; ri <= n; ri++)
  {
    for (int i = ri; i <= ri + 2; i++)
    {
      d[i] = 1000000000;
      if (i <= n)
        d[i] = d[i - 1] + c[i - 1][0];
      if (i > 1 && i <= n + 1 && d[i - 2] + c[i - 2][1] < d[i])
        d[i] = d[i - 2] + c[i - 2][1];
      if (i > 2 && i <= n + 2 && d[i - 3] + c[i - 3][2] < d[i])
        d[i] = d[i - 3] + c[i - 3][2];
    }
    d[ri] = min (d[ri], min (d[ri + 1], d[ri + 2]));
  }

  printf ("%d", d[n]);

  return 0;
}
