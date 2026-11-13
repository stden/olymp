#include <cstdio>
#include <cstring>

#define m 44
#define ml 30

int f[m][m][m][ml], n;
int a[ml], one[ml];

void add( int *a, int *b )
{
  for (int i = 0; i < ml; i++)
    a[i] += b[i];
  for (int i = 0; i < ml; i++)
    if (a[i] >= 10)
      a[i] -= 10, a[i + 1]++;
}

void sub( int *a, int *b )
{
  for (int i = 0; i < ml; i++)
    a[i] -= b[i];
  for (int i = 0; i < ml; i++)
    if (a[i] < 0)
      a[i] += 10, a[i + 1]--;
}

int cmp( int *a, int *b )
{
  for (int i = ml - 1; i >= 0; i--)
    if (a[i] != b[i])
      return a[i] - b[i];
  return 0;
}

int main( void )
{
  freopen("parenth.in", "rt", stdin);
  freopen("parenth.out", "wt", stdout);
  scanf("%Lu", &n), n *= 2;
  memset(f, 0, sizeof(f));
  f[0][0][0][0] = 1;
  for (int i = 0; i < n; i++)
    for (int j = 0; j <= i; j++)
      for (int k = 0; k + j <= i; k++)
      {
        add(f[i + 1][j + 1][k], f[i][j][k]);
        add(f[i + 1][j][k + 1], f[i][j][k]);
        if (j)
          add(f[i + 1][j - 1][k], f[i][j][k]);
        if (k)
          add(f[i + 1][j][k - 1], f[i][j][k]);
      }
  memset(one, 0, sizeof(one));
  one[0] = 1;
  memset(a, 0, sizeof(a));
  char s[ml];
  scanf("%s", s);
  for (int i = 0; s[i]; i++)
    a[strlen(s) - i - 1] = s[i] - '0';
  sub(a, one);
  int i, j, k;
  i = n, j = k = 0;
  while (i > 0)
  {
//    fprintf(stderr, "%d %d %d %d%d%d%d\n", i, j, k, f[i][j][k][3], f[i][j][k][2], f[i][j][k][1], f[i][j][k][0]);
    if (j + k + 1 <= i - 1 && cmp(a, f[i - 1][j + 1][k]) < 0)
      putc('(', stdout), j++;
    else
    {
      sub(a, f[i - 1][j + 1][k]);
      if (j > 0 && cmp(a, f[i - 1][j - 1][k]) < 0)
        putc(')', stdout), j--;
      else
      {
        sub(a, f[i - 1][j - 1][k]);
        if (j + k + 1 <= i - 1 && cmp(a, f[i - 1][j][k + 1]) < 0)
          putc('[', stdout), k++;
        else
        {
          sub(a, f[i - 1][j][k + 1]);
          putc(']', stdout), k--;
        }
      }
    }
    i--;
  }
  return 0;
}
