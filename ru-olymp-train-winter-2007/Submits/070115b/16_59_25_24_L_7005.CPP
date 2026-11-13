#include <cstdio>


int S[300000], SN, Z[300000];

int min( int a, int b )
{
  if (a < b)
    return a;
  return b;
} 

void ZF( void )
{
  int rst = 0;
  Z[0] = 0;
  for (int i = 1; i < SN; i++)
  {
    int res = 0;
    if (rst + Z[rst] > i)
      res = min(rst + Z[rst] - i, Z[i - rst]);
    while (i + res < SN && S[i + res] == S[res])
      res++;
    Z[i] = res;
    if (Z[rst] + rst < Z[i] + i)
      rst = i;
  } 
}

int main( void )
{
  freopen("substr.in", "rt", stdin);
  freopen("substr.out", "wt", stdout);

  int c, st;
  while ((c = getc(stdin)) != '*')
  {
    if (c >= 33 && c <= 126)
      S[SN++] = c;
  }
  S[SN++] = 0;
  st = SN;
  while ((c = getc(stdin)) != -1)
    if (c >= 33 && c <= 126)
      S[SN++] = c;
  ZF();
/*  for (int i = 0; i < SN; i++)
    printf("%d%c", Z[i], i < SN - 1 ? ' ' : '\n');*/
  for (int i = st; i < SN; i++)
    if (Z[i] >= st - 1)
      printf("%d\n", i - st + 1);
  return 0;
}

