#include <stdio.h>

int out [] = {
  0, 0, 0, 1, 1, 1, 1, 2, 4, 7, 12, 22, 42
};

int main ()
{
  freopen ("pines.in", "rt", stdin);
  freopen ("pines.out", "wt", stdout);
  
  int n;
  scanf ("%d", &n);
  printf ("%d", out[n]);

  return 0;
}


