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

struct rec
{
  int64 o, t;
  rec ()
  {
    o = t = 0;
  }
  rec (int64 o1, int64 t1)
  {
    o = o1;
    t = t1;
  }
};

const int inf = (1 << 30) - 1;

rec s[16][2];
int n;
vector <int> dx[2];

int64 calc (int v, int h, int64 r)
{
  if (r == 0)
    return 0;
  if (h == 0)
    return s[0][v].o + s[0][v].t * 2;
  int64 res = 0;  
  for (int i = 0; i < (int)dx[v].size(); i ++)
    if (s[h-1][dx[v][i]].o + s[h-1][dx[v][i]].t < r)
      {
        r -= s[h-1][dx[v][i]].o + s[h-1][dx[v][i]].t;
        res += s[h-1][dx[v][i]].o + 2 * s[h-1][dx[v][i]].t;
      }  
     else
      return res + calc (dx[v][i], h-1, r);
  return res;    
}

int main ()
{
  freopen ("digitsum.in", "r", stdin);
  freopen ("digitsum.out", "w", stdout);
  memset (s, 0, sizeof (s));
  s[0][0] = rec (1, 0);
  s[0][1] = rec (0, 1);
  for (int i = 1; i < 16; i ++)
    {
      s[i][0].o = 3 * s[i-1][0].o + 2 * s[i-1][1].o;
      s[i][0].t = 3 * s[i-1][0].t + 2 * s[i-1][1].t;
      
      s[i][1].o = 4 * s[i-1][0].o + 3 * s[i-1][1].o;
      s[i][1].t = 4 * s[i-1][0].t + 3 * s[i-1][1].t;
    }
  scanf ("%d", &n);
  dx[0].clear ();
  dx[0].pb (0);
  dx[0].pb (0);
  dx[0].pb (1);
  dx[0].pb (0);
  dx[0].pb (1);

  dx[1].clear ();
  dx[1].pb (0);
  dx[1].pb (0);
  dx[1].pb (1);
  dx[1].pb (0);
  dx[1].pb (1);
  dx[1].pb (0);
  dx[1].pb (1);
  
  forn (i, n)
    {
      int x, y;
      scanf ("%d%d", &x, &y);
      printf ("%lld\n", calc (0, 15, y)- calc (0, 15, x-1));
    }
  return 0;
}