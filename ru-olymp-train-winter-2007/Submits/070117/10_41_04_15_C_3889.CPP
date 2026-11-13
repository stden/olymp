#include <stdio.h>
#include <string.h>

//#define __int64 long long

struct edge
{
  int a, b;
  edge* next;
  edge* back;
  int cnt;
};
edge ee[4096];
int nea = 0;
edge* ealloc ()
{
  return &ee[nea++];
}

edge* ve[256];
int bi[256];
int cnt[256];

int n, m, p;
int S;
int t;
int A[64];
int B[64];

__int64 _tmp[2][64];
__int64* ways;
__int64* nways;
void _swap ()
{
  __int64* tmp = ways;
  ways = nways;
  nways = tmp;
  for (int i = 0; i < n; i++)
    nways[i] = 0;
}
               
void add_edge (int a, int b)
{
  edge* e1 = ealloc ();
  e1->a = a, e1->b = b, e1->next = ve[a], ve[a] = e1;
  edge* e2 = ealloc ();
  e2->a = b, e2->b = a, e2->next = ve[b], ve[b] = e2;
  e1->back = e2, e2->back = e1;
}

namespace _bfs
{
int q[64];
int head = 0;
int tail = 0;
void bfs (int v)
{
  for (int i = 0; i < n; i++)
    bi[i] = -1;
  head = 1;
  tail = 0;
  q[0] = v;
  bi[v] = 0;
  while (head > tail)
  {
    int cur = q[tail++];
    for (edge* e = ve[cur]; e; e = e->next)
      if (bi[e->b] < 0) bi[e->b] = bi[cur] + 1, q[head++] = e->b;
  }
}
};

int main ()
{
  ways = _tmp[0];
  nways = _tmp[1];

  freopen ("restore.in", "rt", stdin);
  freopen ("restore.out", "wt", stdout);

  scanf ("%d %d %d", &n, &m, &p);
  memset (ve, 0, sizeof ve);
  for (int i = 0; i < m; i++)
  {
    int a, b;
    scanf ("%d %d", &a, &b);
    add_edge (a - 1, b - 1);
  }
  scanf ("%d %d", &S, &t);
  S--;
  for (int i = 0; i < t; i++)
    scanf ("%d %d", &A[i], &B[i]);

  _bfs::bfs (S);

  for (int i = 0; i < n; i++)
    if (bi[i] == A[0])
      nways[i] = 1;
    else
      nways[i] = 0;
  _swap ();
  B[0]--;
  int cur = (B[0] ? 0 : 1);
  while (cur < t)
  {
    for (int i = 0; i < B[cur]; i++)
    {
      for (int j = 0; j < n; j++)
        if (ways[j])
          for (edge* e = ve[j]; e; e = e->next)
            if (bi[e->b] == A[cur])
              nways[e->b] = (nways [e->b] + ways[j]) % p;
      _swap ();
    }
    cur++;
  }

  __int64 sum = 0;
  for (int i = 0; i < n; i++)
    sum = (sum + ways[i]) % p;
  printf ("%I64d", sum);

  return 0;
}
