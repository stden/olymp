#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

__int64 rez[2][32];

struct edge
{
  int b;
  edge* next;
};
edge ee[512];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[32];
void add_edge (int a, int b)
{
  edge* e = ealloc ();
  e->b = b, e->next = ve[a], ve[a] = e;
}

int c[32];

int main ()
{
  freopen ("maxsum.in", "rt", stdin);
  freopen ("maxsum.out", "wt", stdout);

  int n, m, k;
  scanf ("%d %d %d", &n, &m, &k);
  for (int i = 0; i < n; i++)
    scanf ("%d", &c[i]);
  for (int i = 0; i < m; i++)
  {
    int a, b;
    scanf ("%d %d", &a, &b);
    add_edge (a - 1, b - 1);
  }

  int cur = 0;
  for (int i = 0; i < n; i++)
    rez[cur][i] = c[i];
  cur = 1 - cur;
  for (int z = 0; z < k; z++)
  {
    for (int i = 0; i < n; i++)
    {
      rez[cur][i] = 0;
      for (edge* e = ve[i]; e; e = e->next)
        if (rez[1 - cur][e->b] > rez[cur][i])
          rez[cur][i] = rez[1 - cur][e->b];
      rez[cur][i] += c[i];
    }
    cur = 1 - cur;
  }
  printf ("%I64d", rez[1 - cur][0]);

  return 0;
}
