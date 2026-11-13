#include <stdio.h>
#include <algorithm>
using namespace std;

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
int prev[MAX];
int next[MAX];

int main ()
{
  freopen ("tri.in", "rt", stdin);
  freopen ("tri.out", "wt", stdout);

  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
    scanf ("%d %d", &poly[i].x, &poly[i].y), poly[i].i = i, next[i] = i + 1, prev[i] = i - 1;
  prev[0] = n - 1;
  next[n - 1] = 0;

  sort (poly, poly + n);

  int cur = 0;
  while (cur < n - 2)
  {
    int i = poly[cur].i;
    printf ("%d %d %d\n", i + 1, next[i] + 1, prev[i] + 1);
    next[prev[i]] = next[i];
    prev[next[i]] = prev[i];
    cur++;
  }

  return 0;
}
