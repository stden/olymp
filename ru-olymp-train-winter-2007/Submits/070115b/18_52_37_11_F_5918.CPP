#include <cstdio>
#include <algorithm>

#define eps 1e-8

using namespace std;

typedef struct
{
  long long x, y;
} pnt;

bool operator<( pnt &a, pnt &b )
{
  return a.x < b.x || (a.x == b.x && a.y < b.y);
}
bool operator>( pnt &a, pnt &b )
{
  return a.x > b.x || (a.x == b.x && a.y > b.y);
}
bool operator==( pnt &a, pnt &b )
{
  return a.x == b.x && a.y == b.y;
}

int main( void )
{
  freopen("interseg.in", "rt", stdin);
  freopen("interseg.out", "wt", stdout);
  pnt p00, p01, p10, p11;
  scanf("%Ld%Ld%Ld%Ld%Ld%Ld%Ld%Ld", &p00.x, &p00.y, &p01.x, &p01.y, &p10.x, &p10.y, &p11.x, &p11.y);
  int a1, b1, c1, a2, b2, c2;
  if (p00 > p01) swap(p00, p01);
  if (p10 > p11) swap(p10, p11);
  a1 = p00.y - p01.y, b1 = p01.x - p00.x, c1 = -(a1 * p00.x + b1 * p00.y);
  a2 = p10.y - p11.y, b2 = p11.x - p10.x, c2 = -(a2 * p10.x + b2 * p10.y);
  if (a1 * b2 == a2 * b1)
  {
    if (a1 * c2 == a2 * c1 && b1 * c2 == b2 * c1)
    {
      if (p00 > p10) swap(p00, p10);
      if (p01 > p11) swap(p01, p11);
      if (p10 < p01)
        printf("%Ld.000000 %Ld.000000 %Ld.000000 %Ld.000000", p10.x, p10.y, p01.x, p01.y);
      else if (p10 == p01)
        printf("%Ld.000000 %Ld.000000", p10.x, p10.y);
      else
        printf("Empty");
    }
    else
      printf("Empty");
  }
  else
  {
    double xx, yy;
    xx = -(c1 * b2 - c2 * b1) / ((double)a1 * b2 - a2 * b1);
    yy = -(c2 * a1 - c1 * a2) / ((double)a1 * b2 - a2 * b1);
    if (max(min(p00.x, p01.x), min(p10.x, p11.x)) <= xx + eps &&
        min(max(p00.x, p01.x), max(p10.x, p11.x)) >= xx - eps &&
        max(min(p00.y, p01.y), min(p10.y, p11.y)) <= yy + eps &&
        min(max(p00.y, p01.y), max(p10.y, p11.y)) >= yy - eps)
      printf("%.6lf %.6lf", xx, yy);
    else
      printf("Empty");
  }
  return 0;
}
