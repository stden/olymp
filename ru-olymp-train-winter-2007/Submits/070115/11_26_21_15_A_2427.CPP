#include <stdio.h>

int main ()
{
  freopen ("cars.in", "rt", stdin);
  freopen ("cars.out", "wt", stdout);

  int a;
  scanf ("%d", &a);
  printf ("%d", a);

  return 0;
}
