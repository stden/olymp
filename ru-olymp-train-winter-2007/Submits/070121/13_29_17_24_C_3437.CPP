#include <algorithm>
#include <cstdio>
#include <cmath>
#include <list>
#include <vector>


#define MP make_pair
#define PB push_back
#define FI first
#define SE second
#define eps 1e-9

using namespace std;

class point
{
public:
  double x, y;
  point( double nx, double ny )
    : x(nx), y(ny)
  {}
  point( void )
  {}
  void Read( void )
  {
    scanf("%lf%lf", &x, &y);
  }
};

point operator-(point a, point b)
{
  point ret;
  ret.x = a.x - b.x;
  ret.y = a.y - b.y;
  return ret;
}

double operator*( point a, point b)
{
  return a.x * b.y - a.y * b.x;
}


int sign( double a )
{
  if (fabs(a) < eps)
    return 0;
  if (a < 0)
    return -1;
  return 1;
}

int inter( double a1, double b1, double a2, double b2 )
{
  if (a1 > b1)
    swap(a1, b1);
  if (a2 > b2)
    swap(a2, b2);
  if (a1 > a2)
    swap(a1, a2),
    swap(b1, b2);
  return b1 > a2 - eps;
}

int cross( point a1, point b1, point a2, point b2 )
{
  return inter(a1.x, b1.x, a2.x, b2.x) 
      && inter(a1.y, b1.y, a2.y, b2.y) 
      && (sign((b1 - a1) * (a2 - a1)) * sign((b1 - a1) * (b2 - a1)) == -1)
      && (sign((b2 - a2) * (a1 - a2)) * sign((b2 - a2) * (b1 - a2)) == -1);
}


list < pair <point, int> > L;
pair<point, int> T[10000];
int TN;

int IsOk( point p1, point p2 )
{
  for (int i = 0; i < TN; i++)
  {
    int j = (i + 1) % TN;
    if (cross(p1, p2, T[i].FI, T[j].FI))
      return 0;
  }
  return 1;
}
void Go( void )
{
  while (1)
  {
    if (TN <= 3)
    {
      printf("%d %d %d\n", T[0].SE, T[1].SE, T[2].SE);
      return;
    }

    int f = 1;
    for (int i = 0; i < TN && f; i++)
    {
      int p = (i + TN - 1) % TN, ne = (i + 1) % TN;
      if (IsOk(T[p].FI, T[ne].FI) && (T[ne].FI - T[p].FI) * (T[i].FI - T[p].FI) < eps)
      {
        printf("%d %d %d\n", T[p].SE, T[i].SE, T[ne].SE);
        TN--;
        for (int j = i; j < TN; j++)
          T[j] = T[j + 1];
        f = 0;
      }

    }
  }

}
int main( void )
{
  freopen("tri.in", "rt", stdin);
  freopen("tri.out", "wt", stdout);
  int n;
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
  {
    point p;
    p.Read();
    T[TN++] = MP(p, i + 1);
  }
  Go();
  return 0;
}