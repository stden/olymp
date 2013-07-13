#include <cstdio>
#include <vector>
#include <algorithm>

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

#define maxn 30001


using namespace std; 


vector <vector <pair< int, int > > > v;

int where[maxn], wich[maxn], h[maxn], hn, st[maxn], res[maxn];

void SWP( int a, int b )
{
  swap(h[a], h[b]);
  swap(wich[a], wich[b]);
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
  hn = 0;
  st[a] = 1;
  Add(0, a);
  while (hn > 0)
  {
    int ve = wich[0], d = h[0];
    res[ve] = d;
    st[ve] = 2;
    DelUp();
    for (int i = 0; i < v[ve].size(); i++)
     Check(v[ve][i].FI, d + v[ve][i].SE);
  }
}
int main( void )
{

  freopen("path.in", "rt", stdin);
  freopen("path.out", "wt", stdout);
  scanf("%d%d", &N, &M);
  v.resize(N + 1);
  for (int a, b, c, i = 0; i < M; i++)
  {
    scanf("%d%d%d", &a, &b, &c);
    v[a].PB(MP(b, c));
    v[b].PB(MP(a, c));
  }
//  fprintf(stderr, "st\n");
  Dei(1);
  for (int i = 1; i <= N; i++)
    printf("%d%c", res[i] , i < N ? ' ' : '\n');
  return 0;
}
