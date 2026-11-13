#include <algorithm>
#include <cstdio>
#include <set>
#include <vector>
#include <cstdlib>

using namespace std;

typedef struct
{
  int x, y;
} pnt;
typedef pair <int, int> PII;
typedef vector <PII> VPII;

#define F first
#define S second
#define PB push_back
#define MP make_pair

#define m 155000
#define eps 1e-8

pnt p1[m], p2[m];
int xc, n;

pnt sub( pnt a, pnt b )
{
  a.x -= b.x, a.y -= b.y;
}

int scprod( pnt a, pnt b )
{
  int t = a.x * b.y - a.y * b.x;
  return t > 0 ? 1 : (t < 0 ? -1 : 0);
}

int inter( pnt a, pnt b, pnt c, pnt d )
{
  return scprod(sub(b, a), sub(c, a)) * scprod(sub(b, a), sub(d, a)) <= 0 &&
         scprod(sub(d, c), sub(a, c)) * scprod(sub(d, c), sub(b, c)) <= 0;
}

void check( int i, int j )
{
  if (i != j && inter(p1[i], p2[i], p1[j], p2[j]))
  {
    printf("YES\n%d %d", i + 1, j + 1);
    exit(0);
  }
}

class less1
{
public:
  bool operator()( int i, int j )
  {
    check(i, j);
    double y1, y2;
    if (p1[i].x == p2[i].x)
      y1 = p1[i].y;
    else
      y1 = p1[i].y + (p2[i].y - p1[i].y) * (xc - p1[i].x) / ((double)p2[i].x - p1[i].x);
    if (p1[j].x == p2[j].x)
      y1 = p1[j].y;
    else
      y1 = p1[j].y + (p2[j].y - p1[j].y) * (xc - p1[j].x) / ((double)p2[j].x - p1[j].x);
    return y1 < y2 - eps;
  }
};

bool operator>( pnt &a, pnt &b )
{
  if (a.x != b.x) return a.x > b.x;
  return a.y > b.y;
}

bool operator<( pnt &a, pnt &b )
{
  if (a.x != b.x) return a.x < b.x;
  return a.y < b.y;
}

bool less2( PII a, PII b )
{
  pnt aa, bb;
  aa = a.S == 1 ? p1[a.F] : p2[a.F];
  bb = b.S == 1 ? p1[b.F] : p2[b.F];
  if (aa.x != bb.x || aa.y != bb.y)
    return aa < bb;
  return a.S > b.S;
}

int main( void )
{
  freopen("segments.in", "rt", stdin);
  freopen("segments.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%d%d%d%d", &p1[i].x, &p1[i].y, &p2[i].x, &p2[i].y);
  for (int i = 0; i < n; i++)
    if (p1[i] > p2[i])
      swap(p1[i], p2[i]);
  VPII t;
  for (int i = 0; i < n; i++)
    t.PB(MP(i, 1)), t.PB(MP(i, -1));
  sort(t.begin(), t.end(), less2);
//  for (int i = 0; i < t.size(); i++)
//    fprintf(stderr, "%d %d\n", t[i].F, t[i].S);
  set <int, less1> a;
  set <int, less1> :: iterator el, ne, pr;
  for (int i = 0; i < n; i++)
  {
//    fprintf(stderr, "%d %d\n", t[i].F, t[i].S);
    if (t[i].S == 1)
    {
      xc = p1[t[i].F].x;
      a.insert(t[i].F);
      pr = ne = el = a.find(t[i].F);
      ne++;
      if (ne != a.end())
        check(*el, *ne);
      if (el != a.begin())
        pr--, check(*el, *pr);
      if (ne != a.end() && el != a.begin())
        check(*ne, *pr);
    }
    else
    {
      xc = p2[t[i].F].x;
      pr = ne = el = a.find(t[i].F);
      ne++;
      if (ne != a.end())
        check(*el, *ne);
      if (el != a.begin())
        pr--, check(*el, *pr);
      if (ne != a.end() && el != a.begin())
        check(*ne, *pr);
      a.erase(t[i].F);
    }
  }
  printf("NO");
  return 0;
}
