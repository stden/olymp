#include <cstdio>
#include <cstring>

#define m 111

long long f[m][m];
int u[m][m];

long long get( int a, int b )
{
  if (u[a][b])
    return f[a][b];
  if (a == 0)
  {
    f[a][b] = 1;
    return 1;
  }
  if (b == 0)
    return 0;
  u[a][b] = 1;
  if (a >= b)
    f[a][b] = get(a - b, b);
  else
    f[a][b] = 0;
  f[a][b] += get(a, b - 1);
}

void gen( int a, int b, long long k )
{
  if (!a || !b)
    return;
  if (a >= b && k < f[a - b][b])
  {
    printf("%d ", b);
    gen(a - b, b, k);
  }
  else
  {
    if (a >= b)
      k -= f[a - b][b];
    gen(a, b - 1, k);
  }
}

int main( void )
{
  freopen("part.in", "rt", stdin);
  freopen("part.out", "wt", stdout);
  memset(u, 0, sizeof(u));
  for (int i = 0; i < m; i++)
    for (int j = 0; j < m; j++)
      get(i, j);
  int a;
  long long b;
  while (scanf("%d%Ld", &a, &b) == 2 && (a != 0 || b != 0))
  {
    gen(a, a, b);
    printf("\n");
  }
  return 0;
}
