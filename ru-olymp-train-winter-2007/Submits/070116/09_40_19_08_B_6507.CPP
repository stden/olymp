#include <cstdio>
#include <cstring>

#define maxl 110
#define base 1000
#define basl 4

typedef struct
{
  int A[maxl];
} Long;

Long operator += ( Long &A, Long B )
{
  for (int i = 0; i < maxl; i++)
    A.A[i] += B.A[i];
  for (int i = 0; i < maxl; i++)
    if (A.A[i] >= base)
      A.A[i] -= base, A.A[i + 1]++;
  return A;
}

Long operator + ( Long A, int C )
{
  Long R = A;
  R.A[0] += C;
  for (int i = 0; i < maxl; i++)
    if (R.A[i] >= base)
      R.A[i] -= base, R.A[i + 1]++;
  return R;
}

Long operator * ( Long A, Long B )
{
  Long R;
  memset(R.A, 0, sizeof(R.A));
  int L1, L2;
  for (L1 = maxl - 1; L1 > 0 && A.A[L1] == 0; L1--)
    ;
  for (L2 = maxl - 1; L2 > 0 && A.A[L2] == 0; L2--)
    ;
  for (int i = 0; i <= L1; i++)
    for (int j = 0; j <= L2 && i + j < maxl; j++)
      R.A[i + j] += A.A[i] * B.A[j];
  for (int i = 0; i < maxl; i++)
    R.A[i + 1] += R.A[i] / base, R.A[i] %= base;
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
  Long R;
  for (int i = 0; i < maxl; i++)
    R.A[i] -= B.A[i];
  for (int i = 0; i < maxl; i++)
    if (R.A[i] < 0)
      R.A[i] += base, R.A[i + 1]--;
  return R;
}

int operator > ( Long A, Long B )
{
  for (int i = maxl - 1; i >= 0; i--)
    if (A.A[i] != B.A[i])
      if (A.A[i] > B.A[i])
        return 1;
      else
        return 0;
  return 0;
}

int operator >= ( Long A, Long B )
{
  for (int i = maxl - 1; i >= 0; i--)
    if (A.A[i] > B.A[i])
      return 1;
    else if (A.A[i] < B.A[i])
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



#define maxn 1010

Long D1[maxn], D2[maxn];

Long F( int N );
Long G( int N );

Long G( int N )
{
  if (D2[N].A[0] != -1)
    return D2[N];
  memset(D2[N].A, 0, sizeof(D2[N].A));
  if (N == 0)
  {
    D2[N].A[0] = 1;
    return D2[N];
  }
  for (int i = 3; i <= N; i++)
    D2[N] += F(i) * G(N - i);
  return D2[N];
}

Long F( int N )
{
  if (D1[N].A[0] != -1)
    return D1[N];
  memset(D1[N].A, 0, sizeof(D1[N].A));
  if (N <= 1 || N == 3)
  {
    D1[N].A[0] = 1;
    return D1[N];
  }
  Long Ans = G(N - 1);
  return D1[N] = Ans;
}

int main( void )
{
  freopen("pines.in", "rt", stdin);
  freopen("pines.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  memset(D1, -1, sizeof(D1));
  memset(D2, -1, sizeof(D2));
  LWrite(F(N));
/*
  for (int i = 0; i <= N; i++)
    fprintf(stderr, "F(N = %d) = %I64d\n", i, F(i));
  for (int i = 0; i <= N; i++)
    fprintf(stderr, "G(N = %d) = %Ld\n", i, G(i));
*/

  return 0;
}
