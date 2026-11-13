#include <cstdio>
#include <algorithm>
#include <vector>

using namespace std;

#define m 30300

vector <int> to[m], we[m];
int d[m], n, e, h[m], hs, vh[m];

void hswap( int i, int j )
{
  swap(h[i], h[j]);
  vh[h[i]] = i, vh[h[j]] = j;
}

void siftup( int i )
{
  while (i > 1 && d[h[i >> 1]] > d[h[i]])
    hswap(i >> 1, i), i >>= 1;
}

void siftdown( int i )
{
  int l, r, e;

  while (1)
  {
    l = i << 1, r = l + 1, e = i;
    if (l <= hs && d[h[l]] < d[h[e]])
      e = l;
    if (r <= hs && d[h[r]] < d[h[e]])
      e = r;
    if (e == i)
      return;
    hswap(e, i), i = e;
  }
}

int main( void )
{
  freopen("path.in", "rt", stdin);
  freopen("path.out", "wt", stdout);
  scanf("%d%d", &n, &e);
  for (int i = 0; i < e; i++)
  {
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c), a--, b--;
    if (a == b)
      continue;
    to[a].push_back(b);
    we[a].push_back(c);
    to[b].push_back(a);
    we[b].push_back(c);
  }
  for (int i = 1; i < n; i++)
    d[i] = (int)1e9;
  d[0] = 0;
  for (int i = 0; i < n; i++)
    h[i + 1] = i, vh[i] = i + 1;
  hs = n;
  while (hs)
  {
    int v = h[1];
    hswap(1, hs--);
    siftdown(1);
    for (int i = 0; i < to[v].size(); i++)
      if (d[to[v][i]] > d[v] + we[v][i])
      {
        d[to[v][i]] = d[v] + we[v][i];
        siftup(vh[to[v][i]]);
      }
  }
  for (int i = 0; i < n; i++)
    printf("%d ", d[i]);
  return 0;
}
