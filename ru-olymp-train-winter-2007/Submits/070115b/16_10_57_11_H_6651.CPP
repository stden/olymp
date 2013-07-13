#include <cstdio>
#include <algorithm>

using namespace std;

#define m 55000

int n, a[m];

int main( void )
{
  freopen("nextperm.in", "rt", stdin);
  freopen("nextperm.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%d", &a[i]);
  if (next_permutation(a, a + n))
    for (int j = 0; j < n; j++)
      printf("%d ", a[j]);
  else
    printf("IMPOSSIBLE");
  return 0;
}
