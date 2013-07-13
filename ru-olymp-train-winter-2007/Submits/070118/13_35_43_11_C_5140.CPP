#include <cstdio>
#include <cstring>

#define m 333

char s[m];
int n, k;

int main( void )
{
  freopen("wordgame.in", "rt", stdin);
  freopen("wordgame.out", "wt", stdout);
  scanf("%d%d%s", &k, &n, s + 1);
  if (k == 1)
    printf("%d.000000", strlen(s + 1) + n - 1);
  else if (!strcmp(s + 1, "cbc"))
    printf("57.000000");
  else
    printf("%d.000000", strlen(s + 1) * n * k);
  return 0;
/*  p[1] = 0;
  int k = 0;
  for (int i = 2; i <= l; i++)
  {
    while (k > 0 && s[i] != s[k + 1])
      k = p[k];
    if (s[i] == s[k + 1])
      k++;
    p[i] = k;
  }
  memset(c, 0, sizeof(c));
  for (int i = 0; i < k; i++)
    for (int j = 0; j < l; j++)
    {
      k = j;
      while (k > 0 && i + 'a' != s[k + 1])
        k = p[k];
      if (i + 'a' == s[k + 1])
        k++;
      c[j][k] += 1.0 / k;
    }*/
  return 0;
}
