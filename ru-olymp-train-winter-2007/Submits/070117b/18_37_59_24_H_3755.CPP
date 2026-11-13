#include <cstdio>
#include <cstring>

char S[100];
int SN;
int Res[51][51][2];


int F(int l, int r, int isl)
{
  int d = r - l + 1, res = -1;
  if (d == 1)
    return 1;
  if (Res[l][r][isl] + 1)
    return Res[l][r][isl];
//  fprintf(stderr, "int (%d;%d)\n", l, r);
  if (d % 2 == 0)
  {
    int i, j;
    for (i = l, j = l + (d / 2); j <= r && S[i] == S[j]; i++, j++);
    if (j > r)
    {
//      fprintf(stderr, "!!\n");
      res = (1 *  (!isl)) + F(l, l + (d / 2) - 1, 1) + 1;
    }
  }
  int t;
  for (int i = 1; i < d; i++)
    if (res > (t = (F(l, l + i - 1, isl) + F(l + i, r, 0))) || !(res + 1))
    {
      res = t;
//      fprintf(stdout, "(%d;%d)-> (%d;%d).(%d;%d) = %d\n", l, r,l, l + i - 1, l + i, r, t);
    }
  Res[l][r][isl] = res;
//  fprintf(stderr, "(%d;%d) = %d\n", l, r, res);
  return res;
}

int main( void )
{
  freopen("repeat.in", "rt", stdin);
  freopen("repeat.out", "wt", stdout);
  scanf("%s", S);
  SN = strlen(S);
  memset(Res, -1, sizeof(Res));
  printf("%d", F(0, SN - 1, 1));


  return 0;
}