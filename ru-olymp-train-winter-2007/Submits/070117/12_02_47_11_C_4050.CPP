#include <cstdio>
#include <cstring>

#define m 55

int n, kk, p, c[m][m], d[m][m], cur[m][m], r[m][m], st[m], s;

int _m = 0, _p = 0;

void mul( int a[m][m], int b[m][m] )
{
  _m++;
  static int c[m][m];
  memset(c, 0, sizeof(c));
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
    {
      unsigned long long t = 0;
      int k;
      for (k = 0; k < (n >> 1); k++)
        t += (long long)a[i][k] * b[k][j];
      t %= p;
      for (; k < n; k++)
        t += (long long)a[i][k] * b[k][j];
      c[i][j] = t % p;
    }
  memcpy(a, c, sizeof(c));
}

void mulc( int a[m], int b[m][m] )
{
  static int c[m];
  memset(c, 0, sizeof(c));
  for (int j = 0; j < n; j++)
  {
    int t = 0;
    for (int k = 0; k < n; k++)
    {
      t += ((long long)a[k] * b[k][j]) % p;
      while (t >= p)
        t -= p;
    }
    c[j] = t;
  }
  memcpy(a, c, sizeof(c));
}

void pow( int a[m][m], int b )
{
  _p++;
  static int x[m][m], r[m][m];
  memset(x, 0, sizeof(x));
  for (int i = 0; i < n; i++)
    x[i][i] = 1;
  memcpy(r, a, sizeof(r));
  for (int i = 0; i < 31; i++)
  {
    if ((b >> i) & 1)
      mul(x, r);
    mul(r, r);
  }
  memcpy(a, x, sizeof(x));
}

void print( int a[m][m], char *s )
{
  fprintf(stderr, "%s\n", s);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      fprintf(stderr, "%d%c", a[i][j], j == n - 1 ? '\n' : '\t');
}

int main( void )
{
  freopen("restore.in", "rt", stdin);
  freopen("restore.out", "wt", stdout);
//  freopen("restore.err", "wt", stderr);
  scanf("%d%d%d", &n, &kk, &p);
  memset(c, 0, sizeof(c));
  while (kk--)
  {
    int a, b;
    scanf("%d%d", &a, &b), a--, b--;
    c[a][b] = c[b][a] = 1;
  }
  memcpy(d, c, sizeof(c));
  for (int k = 0; k < n; k++)
    for (int i = 0; i < n; i++)
      for (int j = 0; j < n; j++)
        if (d[i][k] != 0 && d[k][j] != 0 && (d[i][j] == 0 || d[i][j] > d[i][k] + d[k][j]))
          d[i][j] = d[i][k] + d[k][j];
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      if (d[i][j] == 0)
        d[i][j] = -1;
  for (int i = 0; i < n; i++)
    d[i][i] = 0;
  memset(cur, 0, sizeof(cur));
  for (int i = 0; i < n; i++)
    cur[i][i] = 1;
  scanf("%d%d", &s, &kk), s--;
  int la = -1;
  while (kk--)
  {
    int a, b;
    scanf("%d%d", &a, &b);
    if (la == -1)
      for (int i = 0; i < n; i++)
        st[i] = d[s][i] == a;
    else
    {
      for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
          r[i][j] = c[i][j] && (la == -1 || d[s][i] == la) && d[s][j] == a;
//      print(r, "r");
      mul(cur, r);
    }
    if (b > 1)
    {
      for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
          r[i][j] = c[i][j] && d[s][i] == a && d[s][j] == a;
//      print(r, "r");
      pow(r, b - 1);
//      print(r, "r^(b-1)");
      mul(cur, r);
    }
    la = a;
  }
/*  fprintf(stderr, "st:\n");
  for (int i = 0; i < n; i++)
    fprintf(stderr, "%d ", st[i]);
  fprintf(stderr, "\n");*/
  mulc(st, cur);
  int ans = 0;
  for (int i = 0; i < n; i++)
    ans += st[i], ans %= p;
  printf("%d", ans);
//  fprintf(stderr, "%d %d\n", _m, _p);
  return 0;
}
