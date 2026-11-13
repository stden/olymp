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

short int a[30][30], s1[30][2][32768], s2[30][2][32768];
int n, m, ans, am, q;

void go (int v, int mask, int sm, int ax)
{ 
  if (v == n)
    {
      if (ax < ans)
        {
          ans = ax;
          am = mask;
        }
      return;  
    }
  if (ax >= ans)
    return;
  if (sm+1 <= n/2)
    go (v+1, mask | (1 << v), sm+1, ax + s1[v][1][mask&q] + s2[v][1][mask >> (n/2)]);
  if (sm + n - v - 1 >= n/2)
    go (v+1, mask, sm, ax + s1[v][0][mask&q] + s2[v][0][mask >> (n/2)]);
}

int main ()
{
  freopen ("half.in", "r", stdin);
  freopen ("half.out", "w", stdout);
  srand (63463);
  scanf ("%d%d", &n, &m);
  memset (a, 0, sizeof (a));
  forn (i, m)
    {
      int x, y;
      scanf ("%d%d", &x, &y);
      x --;
      y --;
      a[x][y] = a[y][x] = 1;
    }
  n = 28;  
  forn (i, n)
    forn (j, n)
      if (i != j)
        a[i][j] = 1;
  forn (i, n)
    forn (j, 2)
      forn (mask, 1 << (n / 2))
        {
          s1[i][j][mask] = s2[i][j][mask] = 0;
          forn (k, i)
            if (k < n/2)
              {
                if (((mask >> k) & 1) != j)
                  s1[i][j][mask] += a[i][k];
              }
             else
              {
                if (((mask >> (k - n/2)) & 1) != j)
                  s2[i][j][mask] += a[i][k];
              }
              
        }
  ans = inf;
  am = 1;
  q = (1 << (n / 2)) - 1;
  go (1, 1, 1, 0);
  forn (i, n)
    if (am & (1 << i))
      printf ("%d ", i+1);
  printf ("\n");   
  int tm1 = clock ();
  tm1 /= 1000;
  assert (tm1 < 5000);
  return 0;
}