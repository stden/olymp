#include <stdio.h>
#include <string.h>
#include <set>
#include <stdlib.h>
#include <algorithm>
using namespace std;

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

const int MAX = 125001;
cpoint A[MAX];
cpoint B[MAX];
struct segi
{
  int i;
};
set<segi> sweep;

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

cpoint SWEEP_A;
cpoint SWEEP_B;

int compare (int a, int b)
{
  point x, y;
  int_seg (x, SWEEP_A, SWEEP_B, A[a], B[a]);
  int_seg (y, SWEEP_A, SWEEP_B, A[b], B[b]);
  if (x.y < y.y)
    return -1;
  if (x.y > y.y)
    return 1;
  return 0;
}
bool operator < (segi const& a, segi const& b)
{
  if (a.i == b.i) return false;
  return compare (a.i, b.i) < 0;
}

struct event
{
  cpoint x;
  int seg;
  int type;
};
#define EVENT_BEGIN 1
#define EVENT_END   2
bool operator < (event const& a, event const& b)
{
  return a.x.x < b.x.x || (a.x.x == b.x.x && a.x.y < b.x.y);
}
event events[MAX + MAX];
int num = 0;

bool intersect (int a, int b)
{
  point p;
  return int_seg (p, A[a], B[a], A[b], B[b]);
}

void answer (int a, int b)
{
  printf ("YES\n%d %d", a + 1, b + 1);
  exit (0);
}

int main ()
{
  freopen ("segments.in", "rt", stdin);
  freopen ("segments.out", "wt", stdout);

  int n;
  scanf ("%d", &n);
  event ev;
  for (int i = 0; i < n; i++)
  {
    scanf ("%d %d %d %d", &A[i].x, &A[i].y, &B[i].x, &B[i].y);
    events[num].x = A[i];
    events[num].seg = i;
    events[num++].type = EVENT_BEGIN;
    events[num].x = B[i];
    events[num].seg = i;
    events[num++].type = EVENT_END;
  }
  sort (events, events + num);

  for (int i = 0; i < num; i++)
  {
    ev = events[i];
    segi si;
    if (ev.type == EVENT_BEGIN)
    {
      si.i = ev.seg;
      sweep.insert (si);
      set<segi>::iterator it = sweep.find (si);
      if (it != sweep.begin ())
      {
        set<segi>::iterator it2 = it;
        it2--;
        int val = it2->i;
        if (intersect (si.i, val))
          answer (si.i, val);
      }
      it++;
      if (it != sweep.end ())
      {
        int val = it->i;
        if (intersect (si.i, val))
          answer (si.i, val);
      }
    }
    else
    {
      si.i = ev.seg;
      set<segi>::iterator it = sweep.find (si);
      if (it != sweep.begin ())
      {
        set<segi>::iterator it2 = it;
        it2--;
        int val1 = it->i;
        it++;
        if (it != sweep.end())
        {
          int val2 = it->i;
          if (intersect (val1, val2))
            answer (val1, val2);
        }
      }
      sweep.erase (it);
    }
  }

  printf ("NO");

  return 0;
}
