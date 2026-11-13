#include <cstdio>
#include <cmath>
#include <algorithm>
#include <vector>

using namespace std;

#define REP(i, n) for (i = 0; i < (n); i++)
#define PB push_back
#define SZ(a) (a).size()

#define eps 1e-9
typedef double dbl;

struct pnt
{
  dbl x, y;
  pnt() { }
  pnt( dbl _x, dbl _y ) { x = _x, y = _y; }
};

pnt operator +( pnt a, pnt b ) { return pnt(a.x + b.x, a.y + b.y); }
pnt operator -( pnt a, pnt b ) { return pnt(a.x - b.x, a.y - b.y); }
dbl operator *( pnt a, pnt b ) { return a.x * b.y - a.y * b.x; }

int Sgn( dbl a ) { return a > eps ? 1 : (a < -eps ? -1 : 0); } 

int IsIn( pnt p[3], pnt t )
{
  int i, j, s, is1 = 0, is2 = 0;
  REP(i, 3)
  {
    j = (i + 1) % 3;
    dbl tmp = (t - p[i]) * (p[j] - p[i]);
    s = Sgn((t - p[i]) * (p[j] - p[i]));
    if (s > 0) is1 = 1;
    if (s < 0) is2 = 1;
  }
  return !(is1 && is2);
}

pnt p[2][3];
vector <pnt> a;

void Try( pnt t )
{
  int i, j;
  REP(i, 2)
    if (!IsIn(p[i], t))
      return;
  REP(i, SZ(a))
    if (!Sgn(t.x - a[i].x) && !Sgn(t.y - a[i].y))
      return;
  a.PB(t);
  fprintf(stderr, "%.10lf %.10lf\n", t.x, t.y);
}

int main( void )
{
  freopen("triangle.in", "rt", stdin);
  freopen("triangle.out", "wt", stdout);

  int i, j;
  REP(i, 2) REP(j, 3)
    scanf("%lf%lf", &p[i][j].x, &p[i][j].y);

  REP(i, 2) REP(j, 3)
    Try(p[i][j]);
  REP(i, 3) REP(j, 3)
  {
    int i1 = (i + 1) % 3, j1 = (j + 1) % 3;
    pnt v1 = p[0][i1] - p[0][i], v2 = p[1][j1] - p[1][j];
    if (!Sgn(v1 * v2))
      continue;
    dbl a1 = -v1.y, b1 = v1.x, c1 = -(a1 * p[0][i].x + b1 * p[0][i].y);
    dbl a2 = -v2.y, b2 = v2.x, c2 = -(a2 * p[0][i].x + b2 * p[0][i].y);
    dbl xx = -(c1 * b2 - c2 * b1) / (a1 * b2 - a2 * b1);
    dbl yy = -(c1 * a2 - c2 * a1) / (b1 * a2 - b2 * a1);
    Try(pnt(xx, yy));
  }

  dbl res = 0;
  vector <int> perm(SZ(a));
  REP(i, SZ(a))
    perm[i] = i;
  do
  {
    dbl tmp = 0;
    fprintf(stderr, "Try:\b");
    REP(i, SZ(a))
    {
      j = (i + 1) % SZ(a);
      fprintf(stderr, "(%.0lf,%.0lf) * (%.0lf,%.0lf)\n", a[perm[j]].x, a[perm[j]].y, a[perm[i]].x, a[perm[i]].y);
      tmp += a[perm[j]] * a[perm[i]];
    }
    res >?= tmp / 2;
  } while (next_permutation(perm.begin(), perm.end()));
  printf("%.3lf\n", res);
  return 0;
}
