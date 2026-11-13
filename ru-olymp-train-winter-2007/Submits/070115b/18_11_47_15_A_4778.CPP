#include <stdio.h>
#include <string.h>

struct edge
{
  int a;
  int b;
  bool ok;
  edge* next;
  edge* back;
  int i;
};
edge ee[262144];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[262144];

edge* add_edge (int a, int b, int i)
{
  edge* e = ealloc ();
  e->a = a, e->b = b, e->ok = true, e->next = ve[a], ve[a] = e, e->i = i;
  edge* e2 = ealloc ();
  e2->a = b, e2->b = a, e2->ok = true, e2->next = ve[b], ve[b] = e2, e2->i = i;
  e->back = e2, e2->back = e;
}

bool vis[262144];
int ord[262144];
int gr[262144];
int no = 0;

void dfs (int v, edge* by, int wrt, bool pok = true)
{
  if (vis[v])
    return;
  if (pok && by)
    by->ok = false;
  vis[v] = true;
  ord[no++] = v;
  gr[v] = wrt;
  for (edge* e = ve[v]; e; e = e->next)
    if (e->ok)
      dfs (e->b, e, wrt);
}

int main ()
{
  freopen ("bridges.in", "rt", stdin);
  freopen ("bridges.out", "wt", stdout);

  memset (ve, 0, sizeof ve);

  int n, m;
  scanf ("%d %d", &n, &m);

  for (int i = 0; i < m; i++)
  {
    int a, b;
    scanf ("%d %d", &a, &b);
    add_edge (a - 1, b - 1, i);
  }

  memset (vis, 0, sizeof vis);
  dfs (0, NULL, 0);

  int grp = 0;
  memset (vis, 0, sizeof vis);
  for (int i = 0; i < n; i++)
  {
    int j = ord[i];
    if (!vis[j])
      dfs (j, NULL, grp++, false);
  }

  int cnt = 0;
  for (int i = 0; i < m + m; i++)
    if (gr[ee[i].a] != gr[ee[i].b] && ee[i].ok)
      cnt++;
  printf ("%d\n", cnt);
  for (int i = 0; i < m + m; i++)
    if (gr[ee[i].a] != gr[ee[i].b] && ee[i].ok)
      printf ("%d ", ee[i].i + 1);

  return 0;
}
