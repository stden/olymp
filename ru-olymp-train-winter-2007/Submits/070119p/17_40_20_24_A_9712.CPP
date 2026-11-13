#include <cstdio>
#include <cmath>
#include <algorithm>

#define eps 1e-9

using namespace std;

typedef struct 
{
  double a, b, c;
} line;

typedef struct
{
  double x, y;
} point;

double getmul( point a, point b )
{
  return a.y * b.x - a.x *  b.y;
}

line MakeLine( point a, point b )
{
  line r;

  r.a = b.y - a.y;
  r.b = a.x - b.x;
  r.c = -(r.a * a.x + r.b * a.y);
  return r;
}

line l[6];

point p[100];
int ln = 0, pn = 0;

double get( line l, point p )
{
  return l.a * p.x + l.b * p.y + l.c;
}

void cross( line l1, line l2 )
{
  point t1, t2;
  t1.x = l1.a;
  t1.y = l1.b;
  t2.x = l2.a;
  t2.y = l2.b;
  if (fabs(getmul(t1, t2)) < eps)
    return;
  point r;
  r.x = (l2.c * l1.b - l1.c * l2.b) / (l1.a * l2.b - l2.a * l1.b);
  r.y = (l2.c * l1.a - l1.c * l2.a) / (l1.b * l2.a - l2.b * l1.a);
  for (int i = 0; i < ln; i++)
    if (get(l[i], r) < -eps)
      return;
  p[pn++] = r;

}


void check( point r )
{
  for (int i = 0; i < ln; i++)
    if (get(l[i], r) < -eps)
      return;
  p[pn++] = r;
}
point asubb( point a, point b ) 
{
  point r;
  r.x = a.x - b.x;
  r.y = a.y - b.y;
  return r;
}

int main( void )
{
  
  point a1, b1, c1, a2, b2, c2;
  freopen("triangle.in", "rt", stdin);
  freopen("triangle.out", "wt", stdout);
  scanf("%lf%lf%lf%lf%lf%lf%lf%lf%lf%lf%lf%lf", &a1.x, &a1.y, &b1.x, &b1.y, &c1.x, &c1.y, &a2.x, &a2.y, &b2.x, &b2.y, &c2.x, &c2.y);
  point t1, t2;
  
  double res = 0;
  t1.x = b1.x - a1.x;
  t1.y = b1.y - a1.y;

  t2.x = c1.x - a1.x;
  t2.y = c1.y - a1.y;
  if (getmul(t1, t2) < 0)
    swap(b1, c1);
  res += fabs(getmul(t1, t2)) / 2;
  t1.x = b2.x - a2.x;
  t1.y = b2.y - a2.y;

  t2.x = c2.x - a2.x;
  t2.y = c2.y - a2.y;
  if (getmul(t1, t2) < 0)
    swap(b2, c2);
  res += fabs(getmul(t1, t2))  / 2;

    l[ln++] = MakeLine(a1, b1);
  l[ln++] = MakeLine(b1, c1);
  l[ln++] = MakeLine(c1, a1);

  l[ln++] = MakeLine(a2, b2);
  l[ln++] = MakeLine(b2, c2);
  l[ln++] = MakeLine(c2, a2);
  check(a1);
  check(b1);
  check(c1);
  check(a2);
  check(b2);
  check(c2);
  for (int i = 0; i < ln; i++)
    for (int j = i + 1; j < ln; j++)
      cross(l[i], l[j]);
  for (int i = pn - 1; i >= 2; i--)
    for (int j = 1; j < i; j++)
      if (getmul(asubb(p[j], p[0]), asubb(p[j + 1], p[0])) < 0)
        swap(p[j], p[j + 1]);
  for (int i  = 1; i < pn - 1; i++)
    res -= getmul(asubb(p[i], p[0]), asubb(p[i + 1], p[0])) / 2;
  printf("%.4lf", res);
  return 0;
}