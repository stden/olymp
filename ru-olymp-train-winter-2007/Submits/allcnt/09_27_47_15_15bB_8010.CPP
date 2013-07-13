#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

struct edge
{
  int a;
  int b;
  int p;
  int f;
  edge* next;
  edge* back;
};
edge ee[262144];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[262144];

edge* add_edge (int a, int b, int p)
{
  edge* e = ealloc ();
  e->a = a, e->b = b, e->p = p, e->f = 0, e->next = ve[a], ve[a] = e;
  edge* e2 = ealloc ();
  e2->a = b, e2->b = a, e2->p = 0, e2->f = 0, e2->next = ve[b], ve[b] = e2;
  e->back = e2, e2->back = e;
}

int q[262144];
int head;
int tail;
int vis[262144];
int mn[262144];
edge* by[262144];

void dfs (int v)
{
  if (vis[v])
    return;
  vis[v] = true;
  for (edge* e = ve[v]; e; e = e->next)
    if (e->f != e->p)
      dfs (e->b);
}

int main ()
{
  freopen ("cut.in", "rt", stdin);
  freopen ("cut.out", "wt", stdout);

  int n, m;
  scanf ("%d %d", &n, &m);
  memset (ve, 0, sizeof ve);

  for (int i = 0; i < m; i++)
  {
    int a, b, c;
    scanf ("%d %d %d", &a, &b, &c);
    add_edge (a - 1, b - 1, c);
    add_edge (b - 1, a - 1, c);
  }

  int vs = 1;
  memset (vis, 0, sizeof vis);
  int flow = 0;
  while (true)
  {
    tail = 0;
    head = 1;
    q[0] = 0;
    memset (mn, 0, sizeof (int) * n);
    mn[0] = 1000000000;
    by[0] = NULL;
    while (tail < head)
    {
      int cur = q[tail++];
      vis[cur] = vs;
      for (edge* e = ve[cur]; e; e = e->next)
        if (vis[e->b] != vs && e->f < e->p)
          q[head++] = e->b, vis[e->b] = vs, mn[e->b] = min (mn[cur], e->p - e->f), by[e->b] = e->back;
    }
    vs++;
    if (mn[n - 1] <= 0)
      break;
    flow += mn[n - 1];
    edge* cur = by[n - 1];
    while (cur)
    {
      cur->f -= mn[n - 1], cur->back->f += mn[n - 1];
      cur = by[cur->b];
    }
  }
  memset (vis, 0, sizeof vis);
  dfs (0);
  int cnt = 0;
  for (int i = 0; i < nea; i++)
    if (ee[i].f == ee[i].p && vis[ee[i].a] && !vis[ee[i].b] && ee[i].p > 0)
      cnt++;
  printf ("%d %d\n", cnt, flow);
  for (int i = 0; i < nea; i++)
    if (ee[i].f == ee[i].p && vis[ee[i].a] && !vis[ee[i].b] && ee[i].p > 0)
      printf ("%d ", i / 4 + 1);
  printf ("\n");

  return 0;
}
