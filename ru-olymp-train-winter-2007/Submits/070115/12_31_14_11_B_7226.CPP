#include <cstdio>
#include <cstring>

#define m 100101

char s[m];
int b[m], a[m], c[m], n;

int solve( int n )
{
  memcpy(b, c, sizeof(int) * (n + 2));
  if (b[n] != 1 && b[n] != 0)
    return 0;
//  fprintf(stderr, "n=%d\n", n);
  for (int i = 0; i < (n - 1) / 2; i++)
  {
//    fprintf(stderr, "b[i]=%d, b[n-i-1]=%d\n", b[i], b[n - i - 1]);
    if ((b[i] + 10) % 10 != (b[n - i - 1] + 10) % 10 && (b[i] + 11) % 10 != (b[n - i - 1] + 10) % 10)
      return 0;
//    fprintf(stderr, "i=%d\n", i);
    int c;
    if ((b[i] + 10) % 10 == (b[n - i - 1] + 10) % 10)
      c = b[n - i] * 10 + b[n - i - 1];
    else
      c = b[n - i] * 10 + b[n - i - 1] - 1;
    a[i] = (c + 1) / 2, a[n - i - 1] = c - a[i];
    b[n - i - 1] -= c;
    while (b[n - i - 1] < 0)
      b[n - i - 1] += 10, b[n - i]--;
    b[i] -= c;
    while (b[i] < 0)
      b[i] += 10, b[i + 1]--;
  }
  if (n & 1)
  {
    int i = n / 2;
    int c = b[n - i] * 10 + b[i];
    if (c & 1)
      return 0;
    a[i] = c / 2;
  }
  else
  {
    int i = n / 2 - 1;
    int c = b[i + 2] * 100 + b[i + 1] * 10 + b[i];
    if (c % 11)
      return 0;
    c /= 11;
    a[i] = (c + 1) / 2, a[i + 1] = c - a[i];
  }
/*
  for (int i = 0; i < n; i++)
    fprintf(stderr, "%d", a[n - i - 1]);
  fprintf(stderr, "\n");
*/
  for (int i = 0; i < n; i++)
    b[i] = a[i] + a[n - i - 1];
  for (int i = 0; i < n; i++)
    while (b[i] >= 10)
      b[i + 1]++, b[i] -= 10;
  for (int i = 0; i < n; i++)
    if (b[i] != c[i])
      return 0;
  return 1;
}

int main( void )
{
  freopen("reverse.in", "rt", stdin);
  freopen("reverse.out", "wt", stdout);
  while (scanf("%s", s) == 1)
  {
    n = strlen(s);
    if (n == 1 && s[0] == '0')
      break;
    for (int i = 0; i < n; i++)
      c[i] = s[n - i - 1] - '0';
    c[n] = 0;
    if ((n > 1 && solve(n - 1)) || solve(n))
      printf("YES\n");
    else
      printf("NO\n");
  }
  return 0;
}
