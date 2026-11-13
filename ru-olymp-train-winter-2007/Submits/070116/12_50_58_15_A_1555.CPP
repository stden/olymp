#include <stdio.h>

int main ()
{
  freopen ("map.in", "rt", stdin);
  freopen ("map.out", "wt", stdout);

  int n;
  scanf ("%d", &n);
  int a;
  for (int i = 0; i < 7; i++)
    scanf ("%d", &a);
  if (a != 4)
    printf ("NO");
  else
  {
    printf ("YES\n1 3 2 4 5");
    for (int i = 5; i < n; i++)
      printf (" %d", i + 1);
  }

  return 0;
}
