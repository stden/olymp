#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <algorithm>
#include <vector>
#include <set>

using namespace std;

#define X first
#define Y second
#define PB push_back
#define MP make_pair
typedef pair <int, int> PII;

#define maxn 125010
PII p1[maxn], p2[maxn];

struct event
{
  int i, x, f;
  event( int _i, int _x, int _f ) { i = _i, x = _x, f = _f; }
};
bool eless( event a, event b )
{
  return MP(a.x, a.f) < MP(b.x, b.f);
}

int curx;

double gety( int i )
{
  if (p1[i].X == p2[i].X)
    return p1[i].Y;
  return p1[i].Y + (double)(p2[i].Y - p1[i].Y) * (curx - p1[i].X) / (p2[i].X - p1[i].X);
}

struct data
{
  int i;
  data() { }
  data( int _i ) { i = _i; }
};

bool operator <( data a, data b )
{
  return MP(gety(a.i), a.i) < MP(gety(b.i), b.i);
}

PII operator -( PII a, PII b ) { return MP(a.X - b.X, a.Y - b.Y); }
int operator *( PII a, PII b ) { return a.X * b.Y - a.Y * b.X; }
int Sgn( int x) { return x > 0 ? 1 : (x < 0 ? -1 : 0); }

void Try( int i, int j )
{
  if (Sgn((p2[i] - p1[i]) * (p1[j] - p1[i])) * Sgn((p2[i] - p1[i]) * (p2[j] - p1[i])) != 1 &&
      Sgn((p2[j] - p1[j]) * (p1[i] - p1[j])) * Sgn((p2[j] - p1[j]) * (p2[i] - p1[j])) != 1)
    if (min(p1[i].X, p2[i].X) <= max(p1[j].X, p2[j].X) && min(p1[j].X, p2[j].X) <= max(p1[i].X, p2[i].X) &&
        min(p1[i].Y, p2[i].Y) <= max(p1[j].Y, p2[j].Y) && min(p1[j].Y, p2[j].Y) <= max(p1[i].Y, p2[i].Y))
    {
      printf("YES\n%d %d\n", i + 1, j + 1);
      exit(0);
    }
} 

int main( void )
{
  freopen("segments.in", "rt", stdin);
  freopen("segments.out", "wt", stdout);
  
  int n, i;
  scanf("%d", &n);

  vector <event> ev;
  for (i = 0; i < n; i++)
  {
    scanf("%d%d%d%d", &p1[i].X, &p1[i].Y, &p2[i].X, &p2[i].Y);
    if (p1[i] > p2[i])
      swap(p1[i], p2[i]);
    ev.PB(event(i, p1[i].X, 0));
    ev.PB(event(i, p2[i].X, 1));
  }
  sort(ev.begin(), ev.end(), eless);

  set <data> s;
  for (i = 0; i < ev.size(); i++)
  {
    int k = ev[i].i;
    curx = ev[i].x;
    if (ev[i].f == 0)
      s.insert(k);
    set <data>::iterator it = s.find(k), itl = it, itr = it;
    if (it != s.begin())
      Try(it->i, (--itl)->i);
    if ((++itr) != s.end())
      Try(it->i, itr->i);
    if (it != s.begin() && itr != s.end())
      Try(itl->i, itr->i);
    if (ev[i].f == 1)
      s.erase(k);
  }
  puts("NO");
  return 0;
}
