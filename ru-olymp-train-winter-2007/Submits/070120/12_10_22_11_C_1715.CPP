#include <cstdio>

#define m 1000000

int l, n, p[m];
char s[m], ss[m];

int main( void )
{
  freopen("rle.in", "rt", stdin);
  freopen("rle.out", "wt", stdout);
  l = 1;
  gets(s);
  for (int i = 0; s[i];)
    if ('a' <= s[i] && s[i] <= 'z')
      ss[l++] = s[i++];
    else
    {
      int k;
      sscanf(s + i, "%d", &k);
      while ('0' <= s[i] && s[i] <= '9')
        i++;
      while (k--)
        ss[l++] = s[i];
      i++;
    }
  p[1] = 0;
  for (int i = 2; i < l; i++)
  {
    int k = p[i - 1];
    while (k > 0 && ss[k + 1] != ss[i])
      k = p[k];
    if (ss[k + 1] == ss[i])
      k++;
    p[i] = k;
  }
  scanf("%d", &n);
  while (n--)
  {
    int k;
    scanf("%d", &k);
    printf("%d\n", p[k]);
  }
  return 0;
}
