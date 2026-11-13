#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cstring>
#include <ctime>
#include <cassert>

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
const int64 inf64 = ((int64)1 << 62)-1;

struct rec
{
  int l, r;
  int64 c;
};

int n, m, k;
int64 a[64][64], f[64][64];
rec reb[512];
bool u[64];

bool go (int v, int mc)
{
  if (u[v])
    return false;
  u[v] = true;
  if (v == n-1)
    return true;
  forn (i, n)
    if (a[v][i] - f[v][i] >= mc)
      if (go (i, mc))
        { 
          f[v][i] += mc;
          f[i][v] -= mc;
          return true;
        }
  return false;      
}

void find_min_cut ()
{
  int x = 1 << 30;
  memset (f, 0, sizeof (f));
  while (x > 0)
    {
      memset (u, 0, sizeof (u));
      while (go (0, x))
        memset (u, 0, sizeof (u));
      x >>= 1;
    }
  forn (i, n)
    printf ("%d", !u[i]);
  printf ("\n");
  exit (0);
}

int64 s[4194304];
int64 t[1024];
int list;
int mask[512];

bool les (int64 p1, int64 p2)
{
  return s[p1] < s[p2];
}

int find ()
{
  int v = 1;
  while (v < list)
    if (t[v*2] == t[v])
      v = v * 2;
     else
      v = v * 2 + 1;
  return v - list + 1;    
}

void update (int v, int w)
{
  mask[v] = w;
  v = v + list - 1;
  t[v] = s[w];
  while (v > 1)
    {
      v >>= 1;
      t[v] = max (t[v*2], t[v*2+1]);
    }
}

void brute_force ()
{
  s[0] = 0;
  for (int i = 1; i < n-1; i ++)
    s[0] += a[i][n-1];
  for (int i = 1; i < (1 << (n-2)); i ++)
    for (int j = 0; j < n-2; j ++)
      if (i & (1 << j))
        {
          s[i] = s[i^(1 << j)];
          s[i] += a[0][j+1];
          s[i] -= a[j+1][n-1];
          for (int ks = 0; ks < n-2; ks ++)
            if (ks != j)
              {
                if (i & (1 << ks))
                  s[i] -= a[j+1][ks+1];
                 else
                  s[i] += a[ks+1][j+1];
              }
          break;
        }
  list = 1;
  while (list < k)
    list <<= 1;
  memset (t, 0, sizeof (t));
  for (int i = list; i < list+k; i ++)
    t[i] = inf64;
  for (int i = list-1; i >= 1; i --)
    t[i] = max (t[i*2], t[i*2+1]);
  for (int i = 0; i < (1 << (n-2)); i ++)
    if (s[i] < t[1])
      update (find (), i);
  vector <int> ans;
  forn (i, k)
    ans.pb (mask[i+1]);
  sort (all (ans), les);  
  forn (i, ans.size())
    {
      printf ("0");
      forn (j, n-2)
        printf ("%d", (ans[i] >> j) & 1);
      printf ("1\n");    
    }
  int tm1 = (int)clock();
  tm1 /= 1000;
  assert (tm1 < 10);
  exit (0);  
}

void greed ()
{
}

int main ()
{
  freopen ("cuts.in", "r", stdin);
  freopen ("cuts.out", "w", stdout);
  scanf ("%d%d", &n, &m);
  memset (a, 0, sizeof (a));
  forn (i, m)
    {
      int x, y, c;
      scanf ("%d%d%d", &x, &y, &c);
      x --;
      y --;
      a[x][y] = c;
      reb[i].l = x;
      reb[i].r = y;
      reb[i].c = c;
    }
  scanf ("%d", &k);
  if (k == 1)
    find_min_cut ();
  n = 24;
  forn (i, n)
    forn (j, n)
      a[i][j] = 1000000000;
  k = 300;    
  if (n <= 24)
    brute_force ();
   else
    greed ();
  return 0;
}