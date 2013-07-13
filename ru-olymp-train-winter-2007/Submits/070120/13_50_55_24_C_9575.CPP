#include <cstdio>

#define maxn 50002
#define p 999999987
#define mul 17

int ch[maxn], cn, tn, P[maxn * 100];
char T[maxn * 100];
long long cnt[maxn], sum[maxn], sumall;

int EQ( int t1, int t2, int c1 )
{
  fprintf(stderr, "t1 = %d t2 = %d\n", t1, t2);
  while (t2 < c1)
  {
    if ((cnt[t1] != cnt[t2]) || (ch[t1] != ch[t2]))
      return 0;
    t1++, t2++;
  }
  return cnt[t1] >= cnt[t2] && ch[t1] == ch[t2];
}

long long min( int a, int b )
{
  if (a < b)
    return a;
  return b;
}

int main( void )
{
  freopen("rle.in", "rt", stdin);
  freopen("rle.out", "wt", stdout);
  cn = 1;
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
    sumall += cnt[cn - 1];
    if (cn > 1 && ch[cn - 1] == ch[cn - 2])
      cn--, cnt[cn - 1] += cnt[cn];

  }
  for (int i = 1; i < cn; i++)
    sum[i] = sum[i - 1] + cnt[i];
  /*if (sumall >= maxn * 100)
  {
    int i, n;
    scanf("%d", &n);
    while (n--)
    {
      int pos;
      fprintf(stderr, "n = %d\n", n);
      long long ret = 0;
      scanf("%d", &pos);
      int i;
      for (i = 1; i < cn; i++) 
        if (sum[i] >= pos)
          break;
      int r = i, l = 0;
      if (i == 1)
      {
        printf("%d\n", pos - 1);
        continue;
      }
      long long h1 = 0, h2 = 0, mulr = 1, rpos, tres = 0;
      if (ch[i] == ch[1])
        tres = min(cnt[i], cnt[1]);
      while (r > 1)
      {
        if (ch[r] == ch[1] && cnt[r] >= cnt[1])
        {
          rpos = sum[r - 1] + 1 + cnt[r] - cnt[1];
          
          while (sum[l + 1] <  pos - rpos + 1)
            l++, h1 = (h1 * mul + cnt[l] * ch[l]) % p;
/*          fprintf(stderr, "%d")
          fprintf(stderr, "l = %d r = %d, rpos = %d %I64d == %I64d\n", l, r, rpos, ((h1 * mul + ch[l + 1] * (pos - rpos + 1 - sum[l])) % p), ((sum[r] - rpos + 1) * mulr * ch[r] + h2) % p);*/
     /*     if (((h1 * mul + ch[l + 1] * (pos - rpos + 1 - sum[l])) % p) == (((sum[r] - rpos + 1) * mulr * ch[r] + h2) % p) && EQ(2, r + 1, i))
            ret = pos - rpos + 1;

        } 
        h2 = (h2 + mulr * ch[r] * cnt[r]) % p, r--, mulr = (mulr * mul) % p;
      }
      if (tres > ret)
        ret = tres;
//      printf("%I64d\n", ret);
    }
    return 0;
  } */
  tn = 1;
  for (int i = 1; i < cn; i++)
  {
//    printf("%I64d(%c)\n", cnt[i], ch[i]);
    for (int j = 0; j < cnt[i]; j++)
      T[tn++] = ch[i];
  }
  T[tn] = 0;
//  fprintf(stderr, "!!!\n");
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
                  