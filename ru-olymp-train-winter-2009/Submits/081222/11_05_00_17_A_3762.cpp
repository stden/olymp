#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cstring>
#include <ctime>

using namespace std;

#define y1 botva
#define forn(i,n) for (int i = 0; i < (int)n; i ++)
#define ford(i,n) for (int i = n-1; i >= 0; i --)
#define fs first
#define sc second
#define all(x) x.begin(), x.end()
#define last(x) (int)x.size()-1
#define pb push_back
#define mp make_pair
#define ws botva1

typedef long long int64;
typedef long double ldb;

const int inf = (1 << 30) - 1;

int n, m, k, list;
int t[262144][6];
int a1[6];

void push (int v)
{
  if (v < list)
    {
      t[v*2][5] += t[v][5];
      t[v*2+1][5] += t[v][5];
    }
  t[v][5] %= k;  
  forn (i, k)
    a1[i] = t[v][(i-t[v][5]+k)%k];
  forn (i, k)
    t[v][i] = a1[i];
  t[v][5] = 0;  
}

int rsq (int v, int l, int r, int a, int b)
{
  push (v);
  if (l > b || r < a)
    return 0;
  if (a <= l && r <= b)
    {
      int64 res = 0;
      for (int i = 1; i <= 4; i ++)
        res += t[v][i] * (int64)i;
      return res;  
    }
  return rsq (v*2, l, l+r >> 1, a, b) +
         rsq (v*2+1, (l+r >> 1) + 1, r, a, b);
}

void add (int v, int l, int r, int a, int b)
{
  push (v);
  if (l > b|| r < a)
    return;
  if (a <= l && r <= b)
    {
      t[v][5] ++;
      push (v);
      return;
    }
  add (v*2, l, l+r >> 1, a, b);
  add (v*2+1, (l+r>>1)+1, r, a, b);
  push (v);
  forn (i, k)
    t[v][i] = t[v*2][i] + t[v*2+1][i];
}

int main ()
{
  freopen ("sum.in", "r", stdin);
  freopen ("sum.out", "w", stdout);
  scanf ("%d%d%d", &n, &k, &m);
  list = 1;
  while (list < n)
    list = list * 2;
  memset (t, 0, sizeof (t));
  for (int i = list; i < list*2; i ++)
    t[i][0] = 1;
  for (int i = list-1; i > 0; i --)
    t[i][0] = t[i*2][0] + t[i*2+1][0];
  forn (i, m)
    {
      int x, l, r;
      scanf ("%d%d%d", &x, &l, &r);
      if (x == 2)
        printf ("%d\n", rsq (1, 1, list, l, r));
       else
        add (1, 1, list, l, r);
    }
  return 0;
}