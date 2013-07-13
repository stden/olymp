#include <cstdio>
#include <algorithm>
#include <vector>

using namespace std;

#define m 800300

int he[m], to[m], we[m], ne[m];
int d[m], n, e, h[m], hs, vh[m], ee = 0;

void adde( int a, int b, int c )
{
  to[ee] = b, we[ee] = c, ne[ee] = he[a], he[a] = ee++;
  to[ee] = a, we[ee] = c, ne[ee] = he[b], he[b] = ee++;
}

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
  memset(he, -1, sizeof(he));
  for (int i = 0; i < e; i++)
  {
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c), a--, b--;
    if (a == b)
      continue;
    adde(a, b, c);
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
    for (int i = he[v]; i != -1; i = ne[i])
      if (d[to[i]] > d[v] + we[i])
      {
        d[to[i]] = d[v] + we[i];
        siftup(vh[to[i]]);
      }
  }
  for (int i = 0; i < n; i++)
    printf("%d ", d[i]);
  return 0;
}
