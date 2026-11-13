#include <cstdio>

#define m 250100

int s[m], l = 1, ll, p[m];

int main( void )
{
  freopen("substr.in", "rt", stdin);
  freopen("substr.out", "wt", stdout);
  int f = -1, c;
  while ((c = getc(stdin)) != -1)
    if (c == '*' && f == -1)
      s[l++] = -1, f = 0, ll = l - 1;
    else if (33 <= c && c <= 126)
      s[l++] = c;
  p[1] = 0;
  int k = 0;
  for (int i = 2; i <= l; i++)
  {
    while (k > 0 && s[i] != s[k + 1])
      k = p[k];
    if (s[i] == s[k + 1])
      k++;
    p[i] = k;
    if (k >= ll - 1)
      printf("%d\n", i - 2 * ll + 2);
  }
  return 0;
}
