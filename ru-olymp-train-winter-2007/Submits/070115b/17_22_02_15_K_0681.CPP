#include <stdio.h>
#include <string.h>

#include <algorithm>
using namespace std;

struct event
{
  double x;
  int type;
};
bool operator < (event const& a, event const& b)
{
  return (a.x < b.x) || (a.x == b.x && a.type < b.type);
}

event ev[100001];

int main ()
{
  freopen ("segments.in", "rt", stdin);
  freopen ("segments.out", "wt", stdout);

  int n;
  scanf ("%d", &n);
  int ne = 0;
  for (int i = 0; i < n; i++)
  {
    double a, b;
    scanf ("%lf %lf", &a, &b);
    ev[ne].x = a, ev[ne++].type = 1;
    ev[ne].x = b, ev[ne++].type = 2;
  }

  sort (ev, ev + ne);

  int cur = 0;
  int mx = 0;
  double my = 0;
  for (int i = 0; i < ne; i++)
  {
    if (ev[i].type == 1)
      cur++;
    else
      cur--;
    if (cur > mx)
      mx = cur, my = ev[i].x;
  }
  printf ("%d %lf\n", mx, my);

  return 0;
}
