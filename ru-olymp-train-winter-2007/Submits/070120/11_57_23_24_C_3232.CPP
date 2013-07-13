#include <cstdio>
#define maxn 50002

int ch[maxn], cn, tn, P[maxn];
char T[maxn * 25];
long long cnt[maxn];

int main( void )
{
  freopen("rle.in", "rt", stdin);
  freopen("rle.out", "wt", stdout);
  while(1)
  {
    int c = getc(stdin);
    if (c >= '0' && c <= '9')
    {
      int num = c - '0';
      while ((c = getc(stdin)) >= '0' && c <= '9')
        num = num * 10 + c - '0';
      ch[cn] = c;
      cnt[cn++] = num;
    }
    else if (c >= 'a' && c <= 'z')
      ch[cn] = c, cnt[cn++] = 1;
    else
      break;
    if (cn > 1 && ch[cn - 1] == ch[cn - 2])
      cn--, cnt[cn - 1] += cnt[cn];

  }
  tn = 1;
  for (int i = 0; i < cn; i++)
  {
//    printf("%I64d(%c)\n", cnt[i], ch[i]);
    for (int j = 0; j < cnt[i]; j++)
      T[tn++] = ch[i];
  }
  T[tn] = 0;
//  printf("%s\n", T + 1);
  P[0] = 0;
  P[1] = 0;
  for (int i = 2; i < tn; i++)
  {
    int t = P[i - 1];
    while (t && T[t + 1] != T[i])
      t = P[t];
    if (T[t + 1] == T[i])
      t++;
    P[i] = t;
  }
  int n;
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
  {
    int pos;
    scanf("%d", &pos);
    printf("%d\n", P[pos]);
  }
  return 0;
}
