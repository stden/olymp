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
               
struct matrix
{
  __int64 m[64][64];
};
void m_mul (matrix& c, matrix const& a, matrix const& b)
{
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
    {
      c.m[i][j] = 0;
      for (int k = 0; k < n; k++)
      {
        c.m[i][j] += a.m[i][k] * b.m[k][j];
        if (c.m[i][j] >= p)
          c.m[i][j] %= p;
      }
    }
}
void m_apply (matrix const& a)
{
  for (int i = 0; i < n; i++)
  {
    nways[i] = 0;
    for (int j = 0; j < n; j++)
    {
      nways[i] += a.m[i][j] * ways[j];
      if (nways[i] >= p)
        nways[i] %= p;
    }
  }
  _swap ();
}
void m_copy (matrix& a, matrix const& b)
{
  memcpy (a.m, b.m, sizeof a.m);
}
void m_unit (matrix& a)
{
  memset (a.m, 0, sizeof a.m);
  for (int i = 0; i < n; i++)
    a.m[i][i] = 1;
}
void m_pow (matrix& m, int p)
{
  matrix c; // m0^p = m * (c ^ p)
  matrix t;
  m_copy (c, m);
  m_unit (m);
  while (p > 0)
  {
    if (p & 1)
    {
      m_mul (t, m, c);
      m_copy (m, t);
    }
    m_mul (t, c, c);
    m_copy (c, t);
    p >>= 1;
  }
}

void m_build (matrix& a, int c)
{
  memset (a.m, 0, sizeof a.m);
  for (int i = 0; i < n; i++)
    for (edge* e = ve[i]; e; e = e->next)
      a.m[e->b][i]++;
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
  matrix m;
  while (cur < t)
  {
    m_build (m, A[cur]);
    m_pow (m, B[cur]);
    m_apply (m);
    cur++;
/*    if (B[cur] <= 32)
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
    }
    else
    {
      for (int i = 0; i < 32; i++)
      {
        for (int j = 0; j < n; j++)
          if (ways[j])
            for (edge* e = ve[j]; e; e = e->next)
              if (bi[e->b] == A[cur])
                nways[e->b] = (nways [e->b] + ways[j]) % p;
        _swap ();
      }
      B[cur] -= 32;
      _cmp::compute (B[cur]);
      for (int i = 0; i < n; i++)
        nways[i] = 0;
      for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
          nways[j] = (nways[j] + ways[i] * xways[i][j]) % p;
    }
    cur++;*/
  }

  __int64 sum = 0;
  for (int i = 0; i < n; i++)
    sum = (sum + ways[i]) % p;
  printf ("%I64d", sum);

  return 0;
}
