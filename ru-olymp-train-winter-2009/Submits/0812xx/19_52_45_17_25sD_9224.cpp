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

int n, ans = 0, cs;
int s[11];
int c[20][20];

void go2 (int v, int sm, int sp)
{
  if (v == 11)
    {
      if (sm > 0)
        ans += sp * (cs % sm);
      return;
    }
  for (int j = 0; j <= s[v]; j ++)
    {
      int x = c[s[v]][j];
      s[v] -= j;
      go2 (v+1, sm+v*j, sp * x);
      s[v] += j;
    }
}

void go1 (int v, int sm, int sp)
{
  if (v == 11)
    {
      cs = sm;
      go2 (1, 0, sp);
      return;
    }
  for (int j = 0; j <= s[v]; j ++)
    {
      int x = c[s[v]][j];
      s[v] -= j;
      go1 (v+1, sm+v*j, sp * x);
      s[v] += j;
    }
}

int main ()
{
  freopen ("modsum3.in", "r", stdin);
  freopen ("modsum3.out", "w", stdout);
  scanf ("%d", &n);
  memset (s, 0, sizeof (s));
  forn (i, n)
    {
      int x;
      scanf ("%d", &x);
      s[x] ++;
    }  
  memset (c, 0, sizeof (c));
  c[0][0] = 1;
  for (int i = 1; i < 20; i ++)
    {
      c[i][0] = 1;
      for (int j = 1; j <= i; j ++)
        c[i][j] = c[i-1][j] + c[i-1][j-1];
    }
  ans = 0;  
  go1 (1, 0, 1);  
  cout << ans << endl;
  return 0;
}
