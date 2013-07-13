#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

struct edge
{
  int b;
  edge* next;
};
edge ee[256];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[256];
void add_edge (int i, int j)
{
  edge* e = ealloc ();
  e->b = j, e->next = ve[i], ve[i] = e;
}

const int BMAX = 20004;
const int INF = 1000000000;
int bag[32768];
//int by[32768];
//bool used[256];
int cost[256];
int fill[256];
int parent[256];
int C[256];
int A[256];
int W[256];

void update (int v)
{
  for (edge* e = ve[v]; e; e = e->next)
    update (e->b);
  for (int i = 0; i < BMAX; i++)
    bag[i] = INF;
  bag[A[v]] = 0;
  for (edge* e = ve[v]; e; e = e->next)
    for (int i = C[v]; i >= A[v]; i--)
      if (bag[i] + cost[e->b] < bag[i + fill[e->b]])
        bag[i + fill[e->b]] = bag[i] + cost[e->b];
  int mv = W[v];
  int mi = A[v];
  for (int i = C[v] + 1; i < BMAX; i++)
    if (bag[i] < mv)
      mv = bag[i], mi = i;
  cost[v] = mv;
  fill[v] = mi;
}

int main ()
{
  freopen ("system.in", "rt", stdin);
  freopen ("system.out", "wt", stdout);

  int n;
  int root;
  scanf ("%d", &n);
  memset (ve, 0, sizeof ve);
  for (int i = 0; i < n; i++)
  {
    scanf ("%d %d %d %d", &parent[i], &C[i], &A[i], &W[i]);
    parent[i]--;
    if (parent[i] < 0)
      root = i;
    else
      add_edge (parent[i], i);
  }
  update (root);
  printf ("%d", cost[root]);

  return 0;
}
