#include <cstdio>
#include <cstring>

#define m 10100

int f[2][m], la, lb;
char a[m], b[m];

int main( void )
{
  freopen("patterns.in", "rt", stdin);
  freopen("patterns.out", "wt", stdout);
  scanf("%s%s", a, b);
  la = strlen(a);
  lb = strlen(b);
  memset(f, 0, sizeof(f));
  f[0][0] = 1;
  for (int i = 0; i < la; i++)
  {
    for (int j = 0; j < lb; j++)
      if (f[0][j])
        if (a[i] == b[j] || a[i] == '?')
          f[1][j + 1] = 1;
        else if (a[i] == '*')
          f[0][j + 1] = f[1][j] = 1;
    memcpy(f[0], f[1], sizeof(f[1]));
  }
  printf(f[0][lb] ? "YES" : "NO");
  return 0;
}
