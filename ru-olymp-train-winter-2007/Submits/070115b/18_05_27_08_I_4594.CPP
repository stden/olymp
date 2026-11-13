#include <cstdio>
#include <cstring>

#define maxn 110

#define maxl 100
#define base 1000000000
#define basl 9

typedef struct
{
  int A[maxl];
} Long;

Long D[maxn];

Long operator += ( Long &A, Long B )
{
  for (int i = 0; i < maxl; i++)
    A.A[i] += B.A[i];
  for (int i = 0; i < maxl; i++)
    if (A.A[i] >= base)
      A.A[i] -= base, A.A[i + 1]++;
  return A;
}

Long operator +( Long A, int C )
{
  Long R = A;
  R.A[0] += C;
  for (int i = 0; i < maxl; i++)
    if (R.A[i] >= base)
      R.A[i] -= base, R.A[i + 1]++;
  return R;
}

Long operator -= ( Long &A, Long B )
{
  for (int i = 0; i < maxl; i++)
    A.A[i] -= B.A[i];
  for (int i = 0; i < maxl; i++)
    if (A.A[i] < 0)
      A.A[i] += base, A.A[i + 1]--;
  return A;
}

Long operator - ( Long A, Long B )
{
  for (int i = 0; i < maxl; i++)
    A.A[i] -= B.A[i];
  for (int i = 0; i < maxl; i++)
    if (A.A[i] < 0)
      A.A[i] += base, A.A[i + 1]--;
  return A;
}

int operator > ( Long &A, Long B )
{
  for (int i = maxl - 1; i >= 0; i--)
    if (A.A[i] != B.A[i])
      if (A.A[i] > B.A[i])
        return 1;
      else
        return 0;
  return 0;
}

int operator >= ( Long &A, Long B )
{
  for (int i = maxl - 1; i >= 0; i--)
    if (A.A[i] != B.A[i])
      if (A.A[i] > B.A[i])
        return 1;
      else
        return 0;
  return 1;
}

Long operator *( Long A, int C )
{
  Long R = A;
  for (int i = 0; i < maxl; i++)
    R.A[i] *= C;
  for (int i = 0; i < maxl; i++)
    R.A[i + 1] += R.A[i] / base, R.A[i] %= base;
  return R;
}

Long F( int N )
{
  if (D[N].A[0] != -1)
    return D[N];
  memset(D[N].A, 0, sizeof(D[N].A));
  if (N == 0)
  {
    D[N].A[0] = 1;
    return D[N];
  }
  for (int i = 1; i <= N; i++)
    D[N] += F(N - i);
  return D[N];
}

void LWrite( Long A )
{
  int i = maxl - 1;
  for (i = maxl - 1; i > 0 && A.A[i] == 0; i--)
    ;
  printf("%d", A.A[i--]);
  for (; i >= 0; i--)
    printf("%0*d", basl, A.A[i]);
  puts("");
}

Long LRead( void )
{
  scanf(" ");
  char c;
  Long Res;
  memset(Res.A, 0, sizeof(Res.A));
  while (scanf("%c", &c) == 1 && c >= '0' && c <= '9')
    Res = Res * 10 + (c - '0');
  return Res;
}

int main( void )
{
  freopen("part.in", "rt", stdin);
  freopen("part.out", "wt", stdout);

  memset(D, -1, sizeof(D));

  int N;
  Long K;
  while (scanf("%d", &N) == 1 && N)
  {
    K = LRead();
    K = F(N) - (K + 1);
    while (N)
    {
      int t;
      for (t = 1; K >= F(N - t); t++)
        K -= F(N - t);
      printf("%d ", t);
      N -= t;
    }
    printf("\n");
  }

  return 0;
}
