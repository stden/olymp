#include <stdio.h>
#include <algorithm>
#include <stdlib.h>
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
point opoly[MAX];
int prev[MAX];
int next[MAX];
int ind[MAX];

bool inside (int i, int a, int b, int c)
{
  point p[3];
  p[0] = poly[a];
  p[1] = poly[b];
  p[2] = poly[c];
  point x = poly[i];
 
  int w = (p[1].x - p[0].x) * (p[2].y - p[0].y) - (p[1].y - p[0].y) * (p[2].x - p[0].x);
  if (w < 0)
  {
    point tmp = p[1];
    p[1] = p[2];
    p[2] = tmp;
  }
  for (int i = 0; i < 3; i++)
  {
    int j = (i + 1) % 3;
    int d = (x.x - p[i].x) * (p[j].y - p[i].y) - (x.y - p[i].y) * (p[j].x - p[i].x);
    if (d > 0)
      return false;
  }
  return true;
}
bool is_tri (int a, int b, int c)
{
  point p[3];
  p[0] = poly[a];
  p[1] = poly[b];
  p[2] = poly[c];
  int w = (p[1].x - p[0].x) * (p[2].y - p[0].y) - (p[1].y - p[0].y) * (p[2].x - p[0].x);
  if (w >= 0)
    return false;
  return true;
}

int oa[MAX];
int ob[MAX];
int oc[MAX];
int no = 0;
void output (int a, int b, int c)
{
  oa[no] = a;
  ob[no] = b;
  oc[no++] = c;
}

int main ()
{
  int end = clock () + (CLOCKS_PER_SEC * 1500) / 1000;
  freopen ("tri.in", "rt", stdin);
  freopen ("tri.out", "wt", stdout);

  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
    scanf ("%d %d", &poly[i].x, &poly[i].y), poly[i].i = i, next[i] = i + 1, prev[i] = i - 1;
  prev[0] = n - 1;
  next[n - 1] = 0;

  sort (poly, poly + n);

  for (int i = 0; i < n; i++)
    opoly[i] = poly[i], ind[poly[i].i] = i;

  int cut = 0;
  while (cut < n - 2 && clock () < end)
  {
    bool ok = false;
    for (int i = 0; i < n && !ok; i++)
    {
      if (!is_tri (ind[i], ind[next[i]], ind[prev[i]]))
        continue;
      ok = true;
      for (int j = 0; j < n && ok; j++)
      {
        if (j == i || j == next[i] || j == prev[i])
          continue;
        if (inside (ind[j], ind[i], ind[next[i]], ind[prev[i]]))
          ok = false;
      }
      if (ok)
      {
        output (i, prev[i], next[i]);
        next[prev[i]] = next[i];
        prev[next[i]] = prev[i];
        cut++;
      }
    }
    if (!ok)
      break;
  }
  if (cut >= n - 2)
  {
    for (int i = 0; i < no; i++)
      printf ("%d %d %d\n", oa[i] + 1, ob[i] + 1, oc[i] + 1);
    return 0;
  }

  for (int i = 0; i < n; i++)
    poly[i] = opoly[i], next[i] = i + 1, prev[i] = i - 1;
  prev[0] = n - 1;
  next[n - 1] = 0;

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
