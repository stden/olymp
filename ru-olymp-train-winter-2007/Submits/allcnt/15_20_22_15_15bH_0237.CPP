#include <stdio.h>
#include <string.h>
#include <algorithm>
using namespace std;

int p[50001];

int main ()
{
  freopen ("nextperm.in", "rt", stdin);
  freopen ("nextperm.out", "wt", stdout);

  int n;
  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
    scanf ("%d", &p[i]);

  if (!next_permutation (p, p + n))
  {
    printf ("IMPOSSIBLE");
    return 0;
  }

  for (int i = 0; i < n; i++)
    printf ("%d ", p[i]);

  return 0;
}
