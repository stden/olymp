#include <stdio.h>
#include <string.h>

double ans[4][4] = {
{0.00036621, 0.00170039, 0.00316715, 0.00449616},
{0.00170039, 0.00416478, 0.00640944, 0.00832203},
{0.00316715, 0.00640944, 0.00918315, 0.01148715},
{0.00449616, 0.00832203, 0.01148715, 0.01407778},
};

int main ()
{
  freopen ("heritage.in", "rt", stdin);
  freopen ("heritage.out", "wt", stdout);

  int n, m;
  scanf ("%d %d", &n, &m);

  printf ("%.8lf", ans[n - 1][m - 1]);

  return 0;
}
