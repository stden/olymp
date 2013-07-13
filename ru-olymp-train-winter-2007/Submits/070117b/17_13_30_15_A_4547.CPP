#include <stdio.h>
#include <string.h>

__int64 d[64][3];

int main ()
{
  freopen ("badsubstr.in", "rt", stdin);
  freopen ("badsubstr.out", "wt", stdout);

  int n;
  scanf ("%d", &n);

  if (n == 0)
  {
    printf ("1");
    return 0;
  }

  d[1][0] = 1;
  d[1][1] = 1;
  d[1][2] = 1;
  for (int i = 2; i <= n; i++)
  {
    d[i][0] = d[i - 1][0] + d[i - 1][1] + d[i - 1][2];
    d[i][1] = d[i - 1][1] + d[i - 1][2];
    d[i][2] = d[i - 1][0] + d[i - 1][1] + d[i - 1][2];
  }

  printf ("%I64d", d[n][0] + d[n][1] + d[n][2]);

  return 0;
}
