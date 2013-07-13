#include <stdio.h>
#include <string.h>

#include <algorithm>
using namespace std;

struct event
{
  int x, type;
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
    int a, b;
    scanf ("%d %d", &a, &b);
    ev[ne].x = a, ev[ne++].type = 1;
    ev[ne].x = b, ev[ne++].type = 2;
  }

  sort (ev, ev + ne);

  int cur = 0;
  int mx = 0;
  int my = 0;
  for (int i = 0; i < ne; i++)
  {
    if (ev[i].type == 1)
      cur++;
    else
      cur--;
    if (cur > mx)
      mx = cur, my = ev[i].x;
  }
  printf ("%d %d\n", mx, my);

  return 0;
}
