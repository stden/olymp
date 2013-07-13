#include <stdio.h>
#include <string.h>

char a[10005];
char b[10005];

int d[10000][512];
inline bool get (int i, int j)
{
  if (i < 0 || j < 0)
    return (i < 0 && j < 0);
  return (d[i][j >> 5] & (1 << (j & 31))) != 0;
}
inline void set (int i, int j)
{
  d[i][j >> 5] |= (1 << (j & 31));
}

int main ()
{
  freopen ("patterns.in", "rt", stdin);
  freopen ("patterns.out", "wt", stdout);

  scanf ("%s %s", a, b);

  memset (d, 0, sizeof d);

  int i, j;
  for (i = 0; a[i]; i++)
  {
    for (j = 0; b[j]; j++)
    {
      if ((a[i] == b[j] || a[i] == '?') && get (i - 1, j - 1))
        set (i, j);
      else if (a[i] == '*' && (get (i, j - 1) || get (i - 1, j - 1)))
        set (i, j);
    }
  }
  printf (get (i - 1, j - 1) ? "YES" : "NO");

  return 0;
}
