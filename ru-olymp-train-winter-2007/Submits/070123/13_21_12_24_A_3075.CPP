#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>

#define eps 1e-5

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
  double getcicle( void )
  {
    double a1 = 1, b1 = 0,  c1 = 0, d1 = 1;
    for (int i = cn - 1; i >= 0; i--)
    {
      swap(a1, c1);
      swap(b1, d1);
      double t1 = a1 + c[i] * c1, t2 = b1 + d1 * c[i];
      a1 = t1;
      b1 = t2;
    }
    double A = c1, B = (d1 - a1), C = -b1, D;
    fprintf(stderr, "%lf %lf %lf\n",A, B, C);
    D = (B * B - 4 * A * C);
    D = sqrt(D);
    return (-B + D) / 2 / A;
  }
  double get( void )
  {
    double ci = getcicle();
    for (int i = an - 1; i >= 0; i--)
      ci = a[i] + 1 / ci;
    return ci;
  }
  Num( double r )
  {
    double wasd[1000];
    wasd[0] = r;
    int i;
    an = 0;
    while (an < 10)
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
      fprintf(stderr, "%lf\n", r);
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
  fprintf(stderr, "%lf %lf", a.get(), b.get());
  double c = a.get() + b.get();
  Num res(c);
  res.Out();
/*  a.Out();
  b.Out();*/

  return 0;
}