#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

//#define _DBG_

struct edge
{
  int b;
  int p;
  int f;
  edge* next;
  edge* back;
};
edge ee[1600000];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}
int sea;
void push_edge ()
{
  sea = nea;
}
void pop_edge ()
{
  nea = sea;
}

edge* ve[262144];

int q[262144];
int head;
int tail;
int vis[262144];
int mn[262144];
edge* by[262144];
int n;

int X, Y;
int S, T;

edge* add_edge (int a, int b, int p)
{
  edge* e = ealloc ();
  e->b = b, e->p = p, e->f = 0, e->next = ve[a], ve[a] = e;
  edge* e2 = ealloc ();
  b, e2->b = a, e2->p = 0, e2->f = 0, e2->next = ve[b], ve[b] = e2;
  e->back = e2, e2->back = e;
}
edge* mpe[262144];

edge* mp_add_edge (int a, int b, int p, edge* img)
{
  edge* e = ealloc ();
  e->b = b, e->p = p, e->f = 0, e->next = mpe[a], mpe[a] = e, e->back = img;
}

bool buildMPGraph ()
{
  memset (mpe, 0, sizeof mpe);
  head = 1;
  tail = 0;
  q[0] = 0;
  memset (vis, 0, sizeof vis);
  bool res = false;
  while (head > tail)
  {
    int cur = q[tail++];
    if (cur == T) res = true;
    vis[cur] = 2;
    for (edge* e = ve[cur]; e; e = e->next)
      if (e->f < e->p)
      {
        if (vis[e->b] == 0)
          q[head++] = e->b, vis[e->b] = 1;
        if (vis[e->b] != 2)
          mp_add_edge (cur, e->b, 1, e);
      }
  }
  return res;
}
void removeEdge (int v)
{
  mpe[v]->back->f += mpe[v]->f;
  mpe[v]->back->back->f -= mpe[v]->f;
  mpe[v] = mpe[v]->next;
}
bool blockDfs (int v)
{
#ifdef _DBG_
  fprintf (stderr, "enter %d\n", v);
#endif
  if (v == T)
    return true;
  while (mpe[v])
  {
    if (blockDfs (mpe[v]->b))
    {
      mpe[v]->f = mpe[v]->p;
      removeEdge (v);
      if (v != S)
        return true;
    }
    else
      removeEdge (v);
  }
#ifdef _DBG_
  fprintf (stderr, "leave %d\n", v);
#endif
  return false;
}

int getFlow ()
{
  S = 0;
  T = n - 1;
  while (true)
  {
#ifdef _DBG_
    fprintf (stderr, "!\n");
    for (int i = 0; i < n; i++)
      for (edge* e = ve[i]; e; e = e->next)
        fprintf (stderr, "%d-%d %d/%d\n", i, e->b, e->f, e->p);
#endif
    push_edge ();
    if (!buildMPGraph ())
      break;
    blockDfs (S);
    pop_edge ();
/*    tail = 0;
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
    }*/
  }
  int flow = 0;
  for (edge* e = ve[S]; e; e = e->next)
    flow += e->f;
  return flow;
}
void printFlow ()
{
  printf ("YES\n");
  for (int i = 1; i <= X; i++)
    for (edge* e = ve[i]; e; e = e->next)
      if (e->b > 0 && e->f == e->p)
      {
        printf ("%d ", e->b - X);
        break;
      }
}
void noQuit ()
{
  printf ("NO");
  exit (0);
}

void dfs (int v, int p = -1)
{
#ifdef _DBG_
  printf ("enter %d\n", v);
#endif
  if (vis[v] == 1)
    noQuit ();
  if (vis[v] == 2)
    return;
  vis[v] = 1;
  for (edge* e = ve[v]; e; e = e->next)
    if (e->b != p && e->f < e->p)
      dfs (e->b, v);
#ifdef _DBG_
  printf ("leave %d\n", v);
#endif
  vis[v] = 2;
}

int main ()
{
  freopen ("omax.in", "rt", stdin);
  freopen ("omax.out", "wt", stdout);
#ifdef _DBG_
  freopen ("omax.err", "wt", stderr);
#endif

  scanf ("%d", &X);
  Y = X;
  n = X + Y + 2;
  for (int i = 0; i < X; i++)
    add_edge (0, i + 1, 1);
  for (int i = 0; i < Y; i++)
    add_edge (i + X + 1, n - 1, 1);
  for (int i = 0; i < X; i++)
  {
    int c;
    scanf ("%d", &c);
    for (int j = 0; j < c; j++)
    {
      int b;
      scanf ("%d", &b);
      add_edge (i + 1, b + X, 1);
    }
  }

  int flow = getFlow ();
  if (flow < X)
    noQuit ();
#ifdef _DBG_
  printf ("%d\n", flow);
#endif

  memset (vis, 0, sizeof vis);
  for (int i = 0; i < n; i++)
    dfs (i);
  printFlow ();
 
  return 0;
}
