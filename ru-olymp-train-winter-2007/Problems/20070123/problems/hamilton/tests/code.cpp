#include <cstdio>

void PutBit( int b )
{
  static int bn = 0, c = 0;
  if ((b == -1 && bn) || bn == 6)
  {
    if (c < 10)
      c += '0';
    else if (c < 36)
      c += 'A' - 10;
    else if (c < 62)
      c += 'a' - 36;
    else if (c == 62)
      c = '!';
    else
      c = '?';
    putc(c, stdout);
    bn = c = 0;
  }
  c |= b << bn++;
}

#define maxn 4010
char s[maxn];

int main( void )
{
  int i, j, n, k;
  scanf("%d\n", &n);
  printf("%d\n", n);
  for (i = 0; i < n; i++)
  {
    gets(s);
    for (j = i + 1; j < n; j++)
      PutBit(s[j] - '0');
  }
  PutBit(-1);
  puts("");
  scanf("%d\n", &k);
  printf("%d\n", k);
  int wf = 0;
  while (k--)
  {
    scanf("%d", &i);
    if (wf == 1) printf(" ");
    else wf = 1;
    printf("%d", i);
  }
  /////////////////////////////////////
  printf("\n");
  return 0;
}
