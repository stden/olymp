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

int q[262144];
int head;
int tail;
int vis[262144];
int mn[262144];
edge* by[262144];
int n;

edge* add_edge (int a, int b, int p)
{
  edge* e = ealloc ();
  e->a = a, e->b = b, e->p = p, e->f = 0, e->next = ve[a], ve[a] = e;
  edge* e2 = ealloc ();
  e2->a = b, e2->b = a, e2->p = 0, e2->f = 0, e2->next = ve[b], ve[b] = e2;
  e->back = e2, e2->back = e;
}

int getFlow ()
{
  for (int i = 0; i < nea; i++)
    ee[i].f = 0;
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
  return flow;
}

int main ()
{
  freopen ("pairs.in", "rt", stdin);
  freopen ("pairs.out", "wt", stdout);

  int x, y, e;
  scanf ("%d %d", &x, &y, &e);
  n = x + y + 2;
  for (int i = 0; i < x; i++)
    add_edge (0, i + 1, 1);
  for (int i = 0; i < y; i++)
    add_edge (i + x + 1, n - 1, 1);
  int ge = nea;
  for (int i = 0; i < n; i++)
  {
    int a, b;
    scanf ("%d %d", &a, &b);
    add_edge (a, b + x, 1);
  }

  int flow = getFlow ();
  int count = 0;
  for (int i = ge; i < nea; i += 2)
  {
    int iop = ee[i].p;
    ee[i].p = 0;
    for (int j = i + 2; j < nea; j += 2)
    {
      int jop = ee[j].p;
      ee[j].p = 0;
      if (flow != getFlow ())
        count++;
      ee[j].p = jop;
    }
    ee[i].p = iop;
  }

  printf ("%d", count);

  return 0;
}
