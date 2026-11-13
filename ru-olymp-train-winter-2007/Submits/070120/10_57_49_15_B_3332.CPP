#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

//#define _DBG_

const int MAX = 32;

int path[MAX][MAX][MAX];
int pmax[MAX][MAX];

struct edge
{
  int b;
  int p;
  edge* next;
};
edge ee[512];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

int c[32];

edge* ve[32];
void add_edge (int a, int b)
{
  edge* e = ealloc ();
  e->b = b, e->p = c[b], e->next = ve[a], ve[a] = e;
}

int n;

void build ()
{
  for (int i = 0; i < n; i++)
  {
    memset (path[i], -1, sizeof path[i]);
    path[i][0][i] = 0;
    for (int k = 0; k < n; k++)
      for (int j = 0; j < n; j++)
        if (path[i][k][j] >= 0)
          for (edge* e = ve[j]; e; e = e->next)
            if (path[i][k + 1][e->b] < path[i][k][j] + e->p)
              path[i][k + 1][e->b] = path[i][k][j] + e->p;
    for (int k = 0; k <= n; k++)
    {
      pmax[i][k] = 0;
      for (int j = 0; j < n; j++)
        if (path[i][k][j] > pmax[i][k])
          pmax[i][k] = path[i][k][j];
    }
  }
}

__int64 ans = 0;
__int64 k;
void relax (int i, int a, int b)
{
  if (path[i][b][i] < 0 || path[0][a][i] < 0)
    return;
  __int64 val = c[0];
  val += path[0][a][i];
  __int64 num = (k - a) / (__int64) b;
  int rem = int ((k - a) - num * (__int64) b);
  val += (__int64) (path[i][b][i]) * num;
  val += pmax[i][rem];
  if (val > ans)
    ans = val;
}

int main ()
{
  freopen ("maxsum.in", "rt", stdin);
  freopen ("maxsum.out", "wt", stdout);

  int m;
  scanf ("%d %d %I64d", &n, &m, &k);
  for (int i = 0; i < n; i++)
    scanf ("%d", &c[i]);
  for (int i = 0; i < m; i++)
  {
    int a, b;
    scanf ("%d %d", &a, &b);
    add_edge (a - 1, b - 1);
  }

  build ();

#ifdef _DBG_
  for (int i = 0; i < n; i++, printf ("\n"))
    for (int k = 0; k <= n; k++, printf ("\n"))
      for (int j = 0; j < n; j++)
        printf ("%d ", path[i][k][j]);
#endif

  for (int i = 0; i < n; i++)
    for (int a = 0; a <= n; a++)
      for (int b = 1; b <= n; b++)
        relax (i, a, b);
  printf ("%I64d", ans);

  return 0;
}
