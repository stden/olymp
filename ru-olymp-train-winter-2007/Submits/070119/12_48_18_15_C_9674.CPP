#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

struct edge
{
  int b;
  edge* next;
};
edge ee[200001];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[100001];
edge* vb[100001];
edge* tmp[100001];

void add_edge (int a, int b)
{
  edge* e = ealloc ();
  e->b = b, e->next = ve[a], ve[a] = e;
  e = ealloc ();
  e->b = a, e->next = vb[b], vb[b] = e;
}    

int n, m;
bool vis[100001];
int cm[100001];
int rep[100001];
int nc;
int dfsr[100001];
int nd;

int c_in[100001];
int c_out[100001];

void dfs1 (int v)
{
  if (vis[v]) return;
  dfsr[nd++] = v;
  vis[v] = true;
  for (edge* e = ve[v]; e; e = e->next)
    dfs1 (e->b);
}

void dfs2 (int v, int c)
{
  if (vis[v]) return;
  vis[v] = true;
  cm[v] = c;
  for (edge* e = ve[v]; e; e = e->next)
    dfs2 (e->b, c);
}

int main ()
{
  freopen ("republic.in", "rt", stdin);
  freopen ("republic.out", "wt", stdout);

  memset (ve, 0, sizeof ve);
  memset (vb, 0, sizeof vb);

  scanf ("%d %d", &n, &m);
  for (int i = 0; i < m; i++)
  {
    int a, b;
    scanf ("%d %d", &a, &b);
    add_edge (a - 1, b - 1);
  }

  memset (vis, 0, sizeof vis);
  nd = 0;
  for (int i = 0; i < n; i++)
    dfs1 (i);

  memset (vis, 0, sizeof vis);
  nc = 0;
  for (int i = nd - 1; i >= 0; i--)
  {
    if (!vis[dfsr[i]])
    {
      rep[nc] = dfsr[i];
      dfs2 (dfsr[i], nc++);
    }
  }

  if (nc == 1)
  {
    printf ("%d", 0);
    return 0;
  }

  memset (c_in, 0, sizeof c_in);
  memset (c_out, 0, sizeof c_out);

  for (int i = 0; i < n; i++)
    for (edge* e = ve[i]; e; e = e->next)
      if (cm[i] != cm[e->b])
        c_out[cm[i]]++, c_in[cm[e->b]]++;

  int o_in = 0, o_out = 0, o_no = 0;
  int x;
  for (int i = 0; i < nc; i++)
  {
    if (c_in[i] == 0)
    {
      x = i;
      if (c_out[i] != 0) o_in++;
      else o_no++;
    }
    else if (c_out[i] == 0)
      o_out++;
  }
  printf ("%d\n", o_in + o_out + (o_no ? o_no + 1 : 0) - 1);
  if (o_no)
  {
    int pp = x;
    for (int i = 0; i < nc; i++)
    {
      if (c_in[i] == 0 && c_out[i] == 0 && i != x)
      {
        printf ("%d %d\n", rep[pp] + 1, rep[i] + 1);
        pp = i;
      }
    }
    printf ("%d %d\n", rep[pp] + 1, rep[x] + 1);
  }
  for (int i = 0; i < nc; i++)
  {
    if (i != x && c_in[i] != 0 && c_out[i] == 0)
      printf ("%d %d\n", rep[i] + 1, rep[x] + 1);
    if (i != x && c_in[i] == 0 && c_out[i] != 0)
      printf ("%d %d\n", rep[x] + 1, rep[i] + 1);
  }

  return 0;
}
