#include <stdio.h>
#include <string.h>
#include <math.h>
#include <algorithm>
using namespace std;

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

struct point
{
  double x, y;
};
struct cpoint
{
  int x, y;
};
#define EPS 1e-8
bool inside (point& r, cpoint a, cpoint b)
{
  int x0 = min (a.x, b.x);
  int y0 = min (a.y, b.y);
  int x1 = max (a.x, b.x);
  int y1 = max (a.y, b.y);
  if (r.x < double (x0) - EPS)
    return false;
  if (r.y < double (y0) - EPS)
    return false;
  if (r.x > double (x1) + EPS)
    return false;
  if (r.y > double (y1) + EPS)
    return false;
  return true;
}
bool int_seg (point& r, cpoint a1, cpoint b1, cpoint a2, cpoint b2)
{
  cpoint d1, d2;
  d1.x = b1.x - a1.x;
  d1.y = b1.y - a1.y;
  d2.x = b2.x - a2.x;
  d2.y = b2.y - a2.y;
  if (d2.x * d1.y == d1.x * d2.y)
    return false;
  cpoint f1;
  f1.x = -d1.y;
  f1.y = d1.x;
  int pa = a2.x * f1.x + a2.y * f1.y - a1.x * f1.x - a1.y * f1.y;
  int dp = d2.x * f1.x + d2.y * f1.y;
  double D = double (pa) / double (dp);
  r.x = double (a2.x) - double (d2.x) * D;
  r.y = double (a2.y) - double (d2.y) * D;
  return inside (r, a1, b1) && inside (r, a2, b2);
}

point pt[32];
point pt2[32];
int num = 0;

double get_area (point* pt, int num)
{
  double sum = 0;
  for (int i = 1; i < num - 1; i++)
    sum += (pt[i].x - pt[0].x) * (pt[i + 1].y - pt[0].y) - (pt[i].y - pt[0].y) * (pt[i + 1].x - pt[0].x);
  if (sum > 0) return sum / 2;
  return -sum / 2;
}
double get_area (cpoint* pt, int num)
{
  double sum = 0;
  for (int i = 1; i < num - 1; i++)
    sum += (pt[i].x - pt[0].x) * (pt[i + 1].y - pt[0].y) - (pt[i].y - pt[0].y) * (pt[i + 1].x - pt[0].x);
  if (sum > 0) return sum / 2;
  return -sum / 2;
}

int selp;
double dist (point a, point b)
{
  return sqrt ((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

bool operator < (point const& a, point const& b)
{
  double D1 = dist (a, pt[selp]);
  double D2 = dist (b, pt[selp]);
  if (D1 < EPS) return true;
  if (D2 < EPS) return false;
  double d1 = (a.y - pt[selp].y) / D1;
  double d2 = (b.y - pt[selp].y) / D2;
  return d1 > d2;
}

bool insidet (point x, cpoint* tr)
{
  double w = (tr[1].x - tr[0].x) * (tr[2].y - tr[0].y) - (tr[1].y - tr[0].y) * (tr[2].x - tr[0].x);
  if (w < 0)
  {
    cpoint tmp = tr[1];
    tr[1] = tr[2];
    tr[2] = tmp;
  }
  for (int i = 0; i < 3; i++)
  {
    int j = (i + 1) % 3;
    double d = (x.x - tr[i].x) * (tr[j].y - tr[i].y) - (x.y - tr[i].y) * (tr[j].x - tr[i].x);
    if (d > 0)
      return false;
  }
  return true;
}

int main ()
{
  freopen ("triangle.in", "rt", stdin);
  freopen ("triangle.out", "wt", stdout);

  cpoint ap[3];
  cpoint bp[3];
  for (int i = 0; i < 3; i++)
    scanf ("%d %d", &ap[i].x, &ap[i].y);
  for (int i = 0; i < 3; i++)
    scanf ("%d %d", &bp[i].x, &bp[i].y);

  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      int i2 = (i + 1) % 3;
      int j2 = (j + 1) % 3;
      if (int_seg (pt[num], ap[i], ap[i2], bp[j], bp[j2]))
        num++;
    }
  }
     
  for (int i = 0; i < 3; i++)
  {
    point a;
    a.x = ap[i].x;
    a.y = ap[i].y;
    if (insidet (a, bp))
      pt[num++] = a;
    a.x = bp[i].x;
    a.y = bp[i].y;
    if (insidet (a, ap))
      pt[num++] = a;
  }

  if (num > 0)
  {
  selp = 0;
  for (int i = 1; i < num; i++)
    if (pt[i].x < pt[selp].x)
      selp = i;
  point A = pt[selp];
  pt[selp] = pt[num - 1];
  pt[num - 1] = A;
  selp = num - 1;
  sort (pt, pt + (num - 1));
  printf ("%.3lf", get_area (ap, 3) + get_area (bp, 3) - get_area (pt, num));
  }
  else
       
                  /*
  printf ("%d\n", num);
  for (int i = 0; i < num; i++)
    printf ("(%lf %lf) ", pt[i].x, pt[i].y);
  printf ("\n");
  double s = 0;
  int pm[32];
  for (int i = 0; i < num; i++)
    pm[i] = i + 1;
  do
  {
    for (int i = 0; i < num; i++)
      pt2[i] = pt[pm[i] - 1];
    double x = get_area (pt2, num);
    printf ("%.3lf ", x);
    for (int i = 0; i < num; i++)
      printf (" (%.3lf %.3lf)", pt2[i].x, pt2[i].y);
    printf ("\n");
    if (x > s) s = x;
  } while (next_permutation (pm, pm + num));*/

  printf ("%.3lf", get_area (ap, 3) + get_area (bp, 3));

  return 0;
}
