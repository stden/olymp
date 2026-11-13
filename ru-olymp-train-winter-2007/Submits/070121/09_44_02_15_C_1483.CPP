#include <stdio.h>
#include <string.h>
#include <algorithm>
using namespace std;

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

const int MAX = 262144;
struct point
{
  int x, y;
  int i;
};
bool operator < (point const& a, point const& b)
{
  return a.x < b.x || (a.x == b.x && a.y < b.y);
}
int n;
point poly[MAX];

int main ()
{
  freopen ("tri.in", "rt", stdin);
  freopen ("tri.out", "wt", stdout);

  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
    scanf ("%d %d", &poly[i].x, &poly[i].y), poly[i].i = i + 1;

  sort (poly, poly + n);
  int cur = 0;
  while (cur < n - 2)
  {
    printf ("%d %d %d\n", poly[cur].i, poly[cur + 1].i, poly[cur + 2].i);
    cur++;
  }

  return 0;
}
