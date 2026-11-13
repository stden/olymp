#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

const int INF = 1000000000;

class tree
{
  enum {maxt = 32768};
  int t[maxt + maxt];
public:
  int v[maxt];
  void build (int n);
  int get (int l, int r);
  void set (int i, int v);
} t;

void tree::build (int n)
{
  for (int i = 0; i < n; i++)
    v[i] = INF, t[i + maxt] = i;
  for (int i = maxt - 1; i >= 0; i--)
    t[i] = (v[t[i + i]] < v[t[i + i + 1]] ? t[i + i] : t[i + i + 1]);
}
int tree::get (int l, int r)
{
  int resv = INF + 1;
  int res = 0;
  l += maxt;
  r += maxt;
  while (l <= r)
  {
    if (l & 1)
    {
      res = (v[t[l]] < resv ? t[l] : res);
      l++;
    }
    if (!(r & 1))
    {
      res = (v[t[r]] < resv ? t[r] : res);
      r--;
    }
    if (l >= r)
      break;
    l >>= 1;
    r >>= 1;
  }
  return res;
}
void tree::set (int i, int a)
{
  v[i] = a;
  i += maxt;
  i >>= 1;
  while (i)
    t[i] = (v[t[i + i]] < v[t[i + i + 1]] ? t[i + i] : t[i + i + 1]), i >>= 1;
}

struct edge
{
  int a;
  int b;
  int c;
  edge* next;
  edge* back;
};
edge ee[400001];
int nea;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[32000];
bool vis[32000];
int cost[32000];

edge* add_edge (int a, int b, int c)
{
  edge* e = ealloc ();
  e->a = a, e->b = b, e->c = c, e->next = ve[a], ve[a] = e;
  edge* e2 = ealloc ();
  e2->a = b, e2->b = a, e2->c = c, e2->next = ve[b], ve[b] = e2;
  e->back = e2, e2->back = e;
}

int main ()
{
  freopen ("path.in", "rt", stdin);
  freopen ("path.out", "wt", stdout);

  int n, m;
  scanf ("%d %d", &n, &m);

  memset (ve, 0, sizeof ve);
  memset (vis, 0, sizeof vis);

  for (int i = 0; i < m; i++)
  {
    int a, b, c;
    scanf ("%d %d %d", &a, &b, &c);
    add_edge (a - 1, b - 1, c);
  }

  t.build (n);
  t.set (0, 0);
  while (true)
  {
    int i = t.get (0, n - 1);
    if (t.v[i] >= INF)
      break;
    vis[i] = true;
    cost[i] = t.v[i];
    for (edge* e = ve[i]; e; e = e->next)
      if (!vis[e->b] && t.v[e->b] > t.v[i] + e->c)
        t.set (e->b, e->c + t.v[i]);
    t.set (i, INF);
  }
  for (int i = 0; i < n; i++)
    printf ("%d ", cost[i]);

  return 0;
}
