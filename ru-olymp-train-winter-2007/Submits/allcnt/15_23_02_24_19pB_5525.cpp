#include <cstdio>
#include <cstdlib>
#include <cmath>
#include <vector>
#include <set>
#include <algorithm>

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

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

double mul( point a, point b )
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

int sign( double a )
{
  if (fabs(a) < eps)
    return 0;
  if (a > 0)
    return 1;
  return -1;
}

point asubb( point a, point b ) 
{
  point r;
  r.x = a.x - b.x;
  r.y = a.y - b.y;
  return r;
}

int inter( double a1, double b1, double a2, double b2 )
{
  if (a1 > b1)
    swap(a1, b1);

  if (a2 > b2)
    swap(a2, b2);

  if (a1 > a2)
    swap(a1, a2), swap(b1, b2);
  return a2 < b1 + eps;
}

int cross( point pa1, point pb1, point pa2, point pb2 )
{
  return  inter(pa1.x, pb1.x, pa2.x, pb2.x) 
       && inter(pa1.y, pb1.y, pa2.y, pb2.y) 
       && (sign(mul(asubb(pb1, pa1), asubb(pa2, pa1))) * sign(mul(asubb(pb1, pa1), asubb(pb2, pa1))) <= 0) 
       && (sign(mul(asubb(pb2, pa2), asubb(pa1, pa2))) * sign(mul(asubb(pb2, pa2), asubb(pb1, pa2))) <= 0);
}


class event
{
public:
  point p;
  int num;
  int isadd;
  event( point np, int nnum, int nisadd)
    :p(np), num(nnum), isadd(nisadd)
  {}
};
bool operator < (event e1, event e2)
{
  if (e1.num == e2.num)
    return e1.isadd;
  if (fabs(e1.p.x - e2.p.x) > eps)
    return e1.p.x < e2.p.x;
  if (fabs(e1.p.y - e2.p.y) > eps)
    return e1.p.y < e2.p.y;
  return !e1.isadd < !e2.isadd;
}


vector < pair<point, point> > seg;
vector <event> ev;

class Pos
{
public:
  int num;
  Pos()
    :num(0)
  {}
  Pos(int nnum)
    :num(nnum)
  {}
};

double nowx;

bool operator < (Pos p1, Pos p2)
{
  double y1, y2;
  


  if (fabs(seg[p1.num].SE.x - seg[p1.num].FI.x) > eps)
    y1 = seg[p1.num].FI.y + (seg[p1.num].SE.y - seg[p1.num].FI.y) * (nowx - seg[p1.num].FI.x) / (seg[p1.num].SE.x - seg[p1.num].FI.x);
  else
    y1 = seg[p1.num].FI.y;
  if (fabs(seg[p2.num].SE.x - seg[p2.num].FI.x) > eps)
    y2 = seg[p2.num].FI.y + (seg[p2.num].SE.y - seg[p2.num].FI.y) * (nowx - seg[p2.num].FI.x) / (seg[p2.num].SE.x - seg[p2.num].FI.x);
  else
    y2 = seg[p2.num].FI.y;
//  fprintf(stderr, "nowx = %.2lf (%d-%.2lf) (%d-%.2lf)\n", nowx, p1.num, y1, p2.num, y2);
  if (fabs(y1 - y2) > eps)
    return y1 < y2;
  return p1.num < p2.num;
   
}


set<Pos> s;


void check( int pa, int pb)
{
  //fprintf(stderr, "(%d %d)\n", pa, pb);
  if (cross(seg[pa].FI, seg[pa].SE, seg[pb].FI, seg[pb].SE))
  {
    printf("YES\n%d %d\n", pa + 1, pb + 1);
   // printf("YES\n");
    exit(0);
  }
}

int main( void )
{
  freopen("segments.in", "rt", stdin);
  freopen("segments.out", "wt", stdout);
  int n;
  scanf("%d", &n);
  
  for (int i = 0; i < n; i++)
  {
    point pa, pb;
    scanf("%lf%lf%lf%lf", &pa.x, &pa.y, &pb.x, &pb.y);
    if (pa.x > pb.x + eps || (fabs(pa.x - pb.x) <= eps && pa.y > pb.y + eps))
      swap(pa, pb);
//    fprintf(stderr, "%lf %lf\n", pa.x, pb.x);
    seg.PB(MP(pa, pb));
    ev.PB(event(pa, i, 1));
    ev.PB(event(pb, i, 0));
  }
  sort(ev.begin(), ev.end());
  /*fprintf(stderr, "ev:");
  for (int i = 0; i < ev.size(); i++)
    fprintf(stderr, "(%d %d)%c", ev[i].num, 1 - ev[i].isadd, i < ev.size() - 1 ? ' ' : '\n');*/
  for (int i = 0; i < ev.size(); i++)
  {
    set<Pos> :: iterator it1, it2;
/*    for (it1 = s.begin(); it1 != s.end(); it1++)
      fprintf(stderr, "%d\n", it1->num);*/
    nowx = ev[i].p.x;
    if (ev[i].isadd)
    {
      s.insert(Pos(ev[i].num));
      it1 = s.find(Pos(ev[i].num));
      if (it1 != s.begin())
      {
        it2 = it1;
        it2--;
        check(it1->num, it2->num);
      }
      it2 = it1;
      it2++;
      if (it2 != s.end())
        check(it1->num, it2->num);
    }
    else
    {
      it1 = s.find(Pos(ev[i].num));
      it2 = it1;
      it2++;
      if (it2 != s.end())
        check(ev[i].num, it2->num);
      if (it1 != s.begin())
      {
        it1--;
        check(ev[i].num, it1->num);
        if (it2 != s.end())
          check(it1->num, it2->num);
      }
      s.erase(Pos(ev[i].num));
    }
  }
  printf("NO\n");
  return 0;
}
