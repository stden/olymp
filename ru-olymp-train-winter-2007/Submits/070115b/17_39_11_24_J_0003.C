#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define maxn 30001

#define SWAP(a, b, c) ((c) = (a), (a) = (b), (b) = (c))

int *v[maxn], *cost[maxn];

int e[500000][3], Cnt[maxn];
int where[maxn], wich[maxn], h[maxn], hn, st[maxn], res[maxn];

void SWP( int a, int b )
{
  int t;
  SWAP(h[a], h[b], t);
  SWAP(wich[a], wich[b], t);
  where[wich[a]] = a;
  where[wich[b]] = b;
}

void FixDown( int i ) 
{
  int l, r, m;

  while (1)
  {
    m = i;
    l = (i << 1) + 1;
    r = l + 1;
    if (l < hn && h[m] > h[l])
      m = l;
    if (r < hn && h[m] > h[r])
      m = r;
    if (m != i)
    {
      SWP(m, i);
      i = m;
    }
    else
    {
      break;
    }
  }
}

void FixUp( int i )
{
  int p;
  while (i > 0 && h[p = (i - 1) >> 1] > h[i])
    SWP(i, p), i = p;
}

void DelUp( void )
{
  SWP(0, hn - 1);
  hn--;
  FixDown(0);
}
void Add( int d, int v )
{
  h[hn] = d;
  wich[hn] = v;
  where[v] = hn;
  FixUp(hn);
  hn++;
}
int N, M;

void Check( int a, int d )
{
  if (st[a] == 2)
    return;
  if (st[a] == 0)
  {
    Add(d, a);
    st[a] = 1;
    return;
  }
  if (h[where[a]] > d)
    h[where[a]] = d, FixUp(where[a]);
}

void Dei( int a )
{
  int ve, d, i;
  hn = 0;
  st[a] = 1;
  Add(0, a);
  while (hn > 0)
  {
    ve = wich[0], d = h[0];
    res[ve] = d;
    st[ve] = 2;
    DelUp();
    for (i = 0; i < Cnt[ve]; i++)
     Check(v[ve][i], d + cost[ve][i]);
  }
}
int main( void )
{

  int a, b, c, i;
  freopen("path.in", "rt", stdin);
  freopen("path.out", "wt", stdout);
  scanf("%d%d", &N, &M);
  for (a, b, c, i = 0; i < M; i++)
  {
    scanf("%d%d%d", &a, &b, &c);
    e[i][0] = a;
    e[i][1] = b;
    e[i][2] = c;
    Cnt[a]++;
    Cnt[b++];
  }
  for (i = 1; i <= N; i++)
    v[i] = malloc(sizeof(int) * Cnt[i]),
    cost[i] = malloc(sizeof(int) * Cnt[i]);
  memset(Cnt, 0, sizeof(Cnt));
  for (i = 0; i < M; i++)
  {
    v[e[i][0]][Cnt[e[i][0]]] = e[i][1];
    cost[e[i][0]][Cnt[e[i][0]]++] = e[i][2];

    v[e[i][1]][Cnt[e[i][1]]] = e[i][0];
    cost[e[i][1]][Cnt[e[i][1]]++] = e[i][2];
  }
//  fprintf(stderr, "st\n");
  Dei(1);
  for (i = 1; i <= N; i++)
    printf("%d%c", res[i] , i < N ? ' ' : '\n');
  return 0;
}
