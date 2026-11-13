#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>

#define eps 1e-4

using namespace std;

class Num
{
public:
  int a[1001], an, c[1001], cn;
  Num( void )
  {
  }
  void Read( void )
  {
    an = 0, cn = 0;
    while (getc(stdin) != '[');
    while (scanf("%d", a + an++) == 1)
      getc(stdin);
    an--;
    int c1 = getc(stdin);
    while (c1 != ')')
    {
      scanf("%d", c + cn++);
      c1 = getc(stdin);
    }
    getc(stdin);
  }
  void Out( void )
  {
    printf("[%d;", a[0]);
    for (int i = 1; i < an; i++)
      printf("%d,", a[i]);
    printf("(");
    for (int i = 0; i < cn; i++)
      printf("%d%c", c[i], i < cn - 1 ? ',' : ')');
    printf("]\n");
  }
  long double getcicle( void )
  {
    long double a1 = 1, b1 = 0,  c1 = 0, d1 = 1;
    for (int i = cn - 1; i >= 0; i--)
    {
      swap(a1, c1);
      swap(b1, d1);
      long double t1 = a1 + c[i] * c1, t2 = b1 + d1 * c[i];
      a1 = t1;
      b1 = t2;
    }
    long double A = c1, B = (d1 - a1), C = -b1, D;
    D = (B * B - 4 * A * C);
    D = sqrt(D);
    return (-B + D) / 2 / A;
  }
  long double get( void )
  {
    long double ci = getcicle();
    for (int i = an - 1; i >= 0; i--)
      ci = a[i] + 1 / ci;
    return ci;
  }
  Num( long double r )
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
  }
};

int main( void )
{
  Num a, b;
  freopen("aplusb.in", "rt", stdin);
  freopen("aplusb.out", "wt", stdout);
  a.Read();
  b.Read();
  long double c = a.get() + b.get();
  Num res(c);
  res.Out();
  fprintf(stderr, "%.9lf == %.9lf\n", (double)c, (double)res.get());

/*  a.Out();
  b.Out();*/

  return 0;
}