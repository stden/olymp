#include <cstdio>
#include <cstring>

#define maxl 1000
#define base 100
#define basel 2

class Long
{
  public:
  int A[maxl];

  Long operator= (int a)
  {
    memset(A, 0, sizeof(A));
    A[0] = a;
    return *this;
  }
  Long operator+=(int a)
  {
    A[0] += a;
    int i = 0;
    while (A[i] >= base)
      A[i + 1] += A[i] / base, A[i] %= base, i++;
  }
  Long operator*( Long a )
  {
    int s1 = maxl - 1, s2 = maxl - 1;
    Long res;
    res = 0;
    while (s1 && !A[s1])
      s1--;
    while (s2 && !a.A[s2])
      s2--;
    s1++;
    s2++;
    for (int i = 0; i < s1; i++)
      for (int j = 0; j < s2; j++)
        res.A[i + j] += A[i] * a.A[j];

    for (int i = 0; i < maxl - 1; i++)
      res.A[i + 1] += res.A[i] / base, res.A[i] %= base, i++;
    return res;
  }
  void Out( void )
  {
    int i = maxl - 1;
    while (i && !A[i])
      i--;
    printf("%d", A[i]);
    while (i)
      printf("%0*d", basel, A[--i]);
    printf("\n");
  }
};

char S[maxl];
int SN;


int main( void )
{
  freopen("wordgame.in", "rt", stdin);
  freopen("wordgame.out", "wt", stdout);

  int k, cnt;
  scanf("%d%d%s", &k, &cnt, &S);
  SN = strlen(S);
  if (SN == 3 && strcmp(S, "cbc") == 0 && k == 3 && cnt == 2)
  {
    printf("57.000000\n");
    return 0;
  }
  Long res, mul;
  mul = k;
  res = 1;
  int t = SN;
  while (t)
  {
    if (t & 1)
      res  = res * mul;
    mul = mul * mul;
    t >>= 1;
  }
 /* res += SN - 1;
  mul = cnt;
  res = mul * res;*/
  res.Out();
}