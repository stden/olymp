#include <cstdio>
#include <cstring>

#define m 55

char s[m];
int f[m][m], n;

int main( void )
{
  freopen("repeat.in", "rt", stdin);
  freopen("repeat.out", "wt", stdout);
  scanf("%s", s);
  n = strlen(s);
  for (int i = 0; i <= n; i++)
    for (int j = 0; j < n; j++)
      f[i][j] = (int)1e9;
  f[0][0] = 0;
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      if (f[i][j] != -1)
      {
        f[i + 1][j] <?= f[i][j] + 1;
        if (i)
          f[i][i - 1] <?= f[i][j] + 1;
        if (j < i && i + i - j <= n)
        {
          int ff = 1;
          for (int k = j; k < i; k++)
            if (s[k] != s[k - j + i])
              ff = 0;
          if (ff)
            f[i + i - j][j] <?= f[i][j] + 1;
        }
      }
  int ans = (int)1e9;
  for (int i = 0; i < n; i++)
    ans <?= f[n][i];
  printf("%d", ans);
  return 0;
}
