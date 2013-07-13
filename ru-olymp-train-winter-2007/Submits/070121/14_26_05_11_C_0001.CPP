#include <cstdio>

int main( void )
{
  freopen("tri.in", "rt", stdin);
  freopen("tri.out", "wt", stdout);
  int n;
  scanf("%d", &n);
  if (n == 3)
  {
    printf("1 2 3\n");
    return 0;
  }
  if (n == 4)
  {
    printf("1 2 3\n");
    printf("3 4 1\n");
    return 0;
  }
  if (n == 6)
  {
    printf("1 2 3\n");
    printf("1 3 4\n");
    printf("1 6 4\n");
    printf("6 5 4\n");
    return 0;
  }
  for (int i = 0; i < n - 2; i++)
    printf("%d %d %d\n", 1 + i, 1 + (1 + i) % n, 1 + (2 + i) % n);
  return 0;
}
