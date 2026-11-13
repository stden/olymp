#include <cstdio>
#include <cstring>

#define m 22
#define mm 62

typedef long long llong;

int co[m], c[m][m], n, e;
llong k, d[mm][m][m], r[m][m], t[m][m];

void mul( llong r[m][m], llong a[m][m], llong b[m][m] )
{
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      r[i][j] = -1;
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      for (int k = 0; k < n; k++)
        if (a[i][j] > -1 && b[j][k] > -1)
          r[i][k] >?= a[i][j] + b[j][k];
}

int main( void )
{
  freopen("maxsum.in", "rt", stdin);
  freopen("maxsum.out", "wt", stdout);
  scanf("%d%d%Ld", &n, &e, &k);
  for (int i = 0; i < n; i++)
    scanf("%d", &co[i]);
  memset(c, 0, sizeof(c));
  for (int i = 0; i < e; i++)
  {
    int a, b;
    scanf("%d%d", &a, &b), a--, b--;
    c[a][b] = 1;
  }
  memset(d[0], -1, sizeof(d[0]));
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      if (c[i][j])
        d[0][i][j] = co[j];
  for (int i = 0; i < mm - 1; i++)
    mul(d[i + 1], d[i], d[i]);
  int f = 0;
  for (int i = 0; i < mm; i++)
    if ((k >> (llong)i) & 1)
      if (f)
        mul(t, r, d[i]), memcpy(r, t, sizeof(t));
      else
        memcpy(r, d[i], sizeof(d[i])), f = 1;
  long long ans;
  for (int i = 0; i < n; i++)
    ans >?= r[0][i];
  printf("%Ld", ans + co[0]);
  return 0;
}
