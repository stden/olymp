#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

int V[4096];

int main ()
{
  freopen ("minimal.in", "rt", stdin);
  freopen ("minimal.out", "wt", stdout);

  int n, m;
  scanf ("%d %d", &n, &m);
  int p, q;
  for (int i = 0; i < n; i++)
  {
    scanf ("%d", &p);
    for (int j = 0; j < p; j++)
      scanf ("%d", &q);
  }
  int c = 0;
  for (int i = 0; i < n; i++)
  {
    scanf ("%d", &p);
    if (p > 0)
      V[c++] = i;
  }
  printf ("%d\n", c);
  for (int i = 0; i < c; i++)
    printf ("%d ", V[i] + 1);
  printf ("\n0\n");

  return 0;
}
