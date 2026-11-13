#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>

#define eps 1e-5

using namespace std;

long long gcd(long long a , long long b )
{
  long long c;
  
  while (b != 0)
    c = a % b, a = b, b = c;
  return a;
}

class Num
{
public:
  int  an, cn;
  long long A, B, C, D, a[1001], c[1001];
  Num( void )
  {
  }
  void Read( void )
  {
    an = 0, cn = 0;
    while (getc(stdin) != '[');
    while (scanf("%I64d", a + an++) == 1)
      getc(stdin);
    an--;
    int c1 = getc(stdin);
    while (c1 != ')')
    {
      scanf("%I64d", c + cn++);
      c1 = getc(stdin);
    }
    getc(stdin);
  }
  void Out( void )
  {
    printf("[%I64d;", a[0]);
    for (int i = 1; i < an; i++)
      printf("%I64d,", a[i]);
    printf("(");
    for (int i = 0; i < cn; i++)
      printf("%I64d%c", c[i], i < cn - 1 ? ',' : ')');
    printf("]\n");
//    printf("(%I64d + %I64d  * sqrt(%I64d)) / %I64d\n", A, B, C, D);
  }
  long double getcicle( void )
  {
    long long a1 = 1, b1 = 0,  c1 = 0, d1 = 1;
    for (int i = cn - 1; i >= 0; i--)
    {
      swap(a1, c1);
      swap(b1, d1);
      long long t1 = a1 + c[i] * c1, t2 = b1 + d1 * c[i];
      a1 = t1;
      b1 = t2;
    }
    long long A1 = c1, B1 = (d1 - a1), C1 = -b1, D1;
    D1 = (B1 * B1 - 4 * A1 * C1);
    A = -B1, B = 1, C = D1, D = 2 * A1;
    for (int i = 2; i <= 10; i++)
      while (C % (i * i) == 0)
        B *= i, C /= i * i;
    long long T = gcd(gcd(A, B), D);
    A /= T;
    B /= T;
    D /= T;
    return (long double)(-B1 + sqrt(D1)) / 2 / A1;
  }
  long double get( void )
  {
    long double ci = getcicle();
    long long TA, TB, TC, TD;
    for (int i = an - 1; i >= 0; i--)
    {
      ci = a[i] + 1 / ci;
      TD = A * A - B * B * C;
      TA = D * A + A * A * a[i] - B * B * a[i] * C;
      TC = C;
      TB = B * a[i] * A - B * (D + A * a[i]);
      A = TA;
      B = TB;
      C = TC;
      D = TD;
      long long T = gcd(gcd(A, B), D);
      A /= T;
      B /= T;
      D /= T;

    }
    return ci;
  }
  Num operator=( long double r )
  {
    long double wasd[1001];
    wasd[0] = r;
    int i;
    an = 0;
    while (an < 1000)
    {
      a[an++] = (int)(floor(r + eps) + eps);
      r = 1 / (r - a[an - 1]);
      if (fabs(r) < eps)
      {
        printf("Impossible\n");
        exit(0);
      }
      for (i = 0; i < an; i++)
      {
        if (fabs(wasd[i] - r) < eps)
          break;
      }
      if (i != an)
        break;
      wasd[an] = r;
    }
    for (;i < an; i++)
      c[cn++] = a[i];
    an -= cn;
    return *this;
  }
};
long long was[1001][4], wn;
long long getmax( long long A, long long B, long long C, long long D)
{
  return (long long) floorl(((long double) (A + B * sqrtl((long double) C))) / D + eps) + eps;
}
Num operator+( Num a1, Num b1 )
{
  Num res;
  long long A, B, C, D;
  long long TA, TB, TC, TD,
  a[1001], an, c[1001], cn;
  if (a1.C != b1.C || a1.C == 0) 
  {
    printf("Impossible\n");
    exit(0);
  }
  A = a1.A * b1.D + b1.A * a1.D;
  B = a1.B * b1.D + b1.B * a1.D;
  D = a1.D * b1.D;
  C = a1.C;
  long long T = gcd(gcd(A, B), D);
  A /= T;
  B /= T;
  D /= T;
  wn = 0;
  an = 0;
  int i;
  while (1)
  {
    long long t;
    
    was[an][0] = A;
    was[an][1] = B;
    was[an][2] = C;
    was[an][3] = D;
//    fprintf(stderr, "(%I64d + %I64d  * sqrt(%I64d)) / %I64d\n", A, B, C, D);
    A -= D * (t = getmax(A, B, C, D));
//    fprintf(stderr, "t = %I64d\n", t);
    a[an++] = t;
    TD = A * A - B * B * C;
    TA = D * A;
    TC = C;
    TB = - B * D;
    A = TA;
    B = TB;
    C = TC;
    D = TD;
    long long T = gcd(gcd(A, B), D);
    A /= T;
    B /= T;
    D /= T;
    
    for (i = 0; i < an; i++)
      if (was[i][0] == A && was[i][1] == B && was[i][2] == C && was[i][3] == D)
        break;
   if (i != an)
     break;
  }
  for (; i < an; i++)
    c[cn++] = a[i];
  an -= cn;
  res.an = an;
  res.cn = cn;
  for (i = 0; i < an; i++)
    res.a[i] = a[i];
  for (i = 0; i < cn; i++)
    res.c[i] = c[i];
  return res;
}
Num a, b, res;
int main( void )
{
 
  freopen("aplusb.in", "rt", stdin);
  freopen("aplusb.out", "wt", stdout);
  a.Read();
  b.Read();
  long double c = a.get() + b.get();
//  a.Out();
//  fprintf(stderr, "%lf", (double)b.get());
//  b.Out();
  res = a + b;
  res.Out();
//  fprintf(stderr, "%.9lf == %.9lf\n", (double)c, (double)res.get());

/*  a.Out();
  b.Out();*/

  return 0;
}