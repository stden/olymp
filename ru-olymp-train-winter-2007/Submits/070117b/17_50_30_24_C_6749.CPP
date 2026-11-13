#include <cstdio>
#include <cstring>

int c[20000][3], res[20000];
int n;

void relax( int p, int d )
{
  if (p > n)
    p = n;
    
  if (!(res[p] + 1) || res[p] > d)
    res[p] = d;
}


int main( void )
{
  freopen("linguae.in", "rt", stdin);
  freopen("linguae.out", "wt", stdout);
  res[0] = 0;
  scanf("%d", &n);
  memset(res, -1, sizeof(res));
  for (int i = 0; i < n; i++)
    for (int j = 0; j < 3; j++)
      scanf("%d", c[i] + j);
  for (int i = 0; i < n; i++)
    for (int j = i; i - j < 3 && j >= 0; j--)
      for (int k = i - j; k < 3; k++)
        relax(j + k + 1, c[j][k]);
  printf("%d", res[n]);
  return 0;
}