#include <cstdio>
#include <cmath>
#include <algorithm>

using namespace std;

#define maxn 500000
#define eps 1e-9

double T[maxn], X1[maxn], X2[maxn], H1[maxn], H2[maxn];
int IsAdd[maxn];
double GetS( double x1, double x2, double h1, double h2, int l, int r )
{
  double a1 = x1, b1 = x2, a2 = l, b2 = r, nh1, nh2;
//  fprintf(stderr, "x1 = %.2lf, x2 = %.2lf, h1 = %.2lf, h2 = %.2lf, l = %d, r = %d\n", x1, x2, h1, h2, l, r);
  if (a1 > a2)
    swap(a1, a2),
    swap(b1, b2);
  if (b1 < a2 + eps)
    return 0;
  if (a1 < a2)
    a1 = a2;
  if (b1 > b2)
    b1  = b2;
  if (fabs(a1 - b1) < eps)
    return 0;
//  fprintf(stderr, "a = %.2lf b = %.2lf\n", a1, b1);
  nh1 = h1 + (a1 - x1) / (x2 - x1) * (h2 - h1);
  nh2 = h1 + (b1 - x1) / (x2 - x1) * (h2 - h1);

  return 0.5 * (nh1 + nh2) * (b1 - a1);
}

void AddT( int num, int l, int r, double x1, double x2, double h1, double h2)
{
//  fprintf(stderr, "AddT: x1 = %.2lf, x2 = %.2lf, h1 = %.2lf, h2 = %.2lf, l = %d, r = %d\n", x1, x2, h1, h2, l, r);
  if (!IsAdd[num])
  {
    IsAdd[num] = 1;
    X1[num] = l, X2[num] = r, H1[num] = 0, H2[num] = 0;
  }
  double a1 = x1, b1 = x2, a2 = l, b2 = r, nh1, nh2;
  if (a1 > a2)
    swap(a1, a2),
    swap(b1, b2);
  if (b1 < a2 + eps)
    return;
  if (a1 < a2)
    a1 = a2;
  if (b1 > b2)
    b1  = b2;
  if (fabs(a1 - b1) < eps)
    return;
  nh1 = h1 + (a1 - x1) / (x2 - x1) * (h2 - h1);
  nh2 = h1 + (b1 - x1) / (x2 - x1) * (h2 - h1);
  H1[num] += nh1;
  H2[num] += nh2;
}

void MoveDone( int num, int l, int r )
{
  IsAdd[num] = 0;
  T[num] += GetS(X1[num], X2[num], H1[num], H2[num], l, r);
  int d = (r - l + 1) >> 1;
  if (l != r - 1)
  {
    AddT((num << 1) + 1, l, l + d, X1[num], X2[num], H1[num], H2[num]);
    AddT((num << 1) + 2, l + d, r    , X1[num], X2[num], H1[num], H2[num]);
  }
}

void Add( int num, int l, int r, int x1, int x2, int h1, int h2)
{
//  fprintf(stderr, "Add:  num = %d, l = %d, r = %d, x1 = %d, x2 = %d, h1 = %d, h2 = %d\n", num, l, r, x1, x2, h1, h2);
  if (IsAdd[num])
    MoveDone(num, l, r);
  if (x1 <= l && r <= x2)
  {
//    fprintf(stderr, "OK\n");
    AddT(num, l, r, x1, x2, h1, h2);
    return;
  }
  if (x1 >= r || x2 <= l)
  {
//    fprintf(stderr, "OK2\n");
    return;
  }
  T[num] += GetS(x1, x2, h1, h2, l, r);
  int d = (r - l + 1) >> 1;
  Add((num << 1) + 1, l, l + d, x1, x2, h1, h2);
  Add((num << 1) + 2, l + d, r  , x1, x2, h1, h2);

}

double Get( int num, int l, int r, int x1, int x2 )
{
  if (IsAdd[num])
    MoveDone(num, l, r);
  if (x1 <= l && r <= x2)
    return T[num];
  if (x1 >= r || x2 <= l)
    return 0 ;
  int d = (r - l + 1) >> 1;
  double ret = 0;
  ret += Get((num << 1) + 1, l, l + d, x1, x2);
  ret += Get((num << 1) + 2, l + d, r    , x1, x2);
  return ret;

}

int main( void )
{
  freopen("geology.in", "rt", stdin);
  freopen("geology.out", "wt", stdout);

  int t, bonus = 131073;
  scanf("%d", &t);         
  while (t--)
  {
    int c;
    while ((c = getc(stdin)) != 'A' && c != 'Q');
    while (getc(stdin) != ' ');
//    fprintf(stderr, "%c", (char)c);
    if (c == 'A')
    {
      int x, p;
      scanf("%d%d", &x, &p);
      Add(0, 1, bonus, x - p, x, 0, p);
  //    return 0;
      Add(0, 1, bonus, x, x + p, p, 0);
  /*    for (int i = 0; i < 3; i++)
      {
        fprintf(stderr, "%d : ", i);
        fprintf(stderr, "t = %.2lf isadd = %d",  T[i], IsAdd[i]);
        fprintf(stderr, "\n");

      }*/
    }
    else
    {
      int l, r;
      scanf("%d%d", &l, &r);
      if (l > r)
        swap(l, r);
      double res;
      res = l != r ? Get(0, 1, bonus, l, r) : 0,
      printf("%.3lf\n", res);
    }
  }
  return 0;
}