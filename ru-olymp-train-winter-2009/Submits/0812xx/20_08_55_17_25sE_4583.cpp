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
typedef bool ar[1024*1024];

ar s[2];
int n, x, y;

int main ()
{
  freopen ("marked.in", "r", stdin);
  freopen ("marked.out", "w", stdout);
  memset (s, 0, sizeof (s));
  scanf ("%d%d%d", &n, &x, &y);
  forn (i, x)
    {
      int mask = 0;
      int k;
      scanf ("%d", &k);
      forn (j, k)
        {
          int x1;
           scanf ("%d", &x1);
          x1 --;
          mask |= (1 << x1);
        }
      cerr << mask << endl;  
      s[0][mask] = 1;  
    }
  forn (i, y)
    {
      int mask = 0;
      int k;
      scanf ("%d", &k);
      forn (j, k)
        {
          int x1;
           scanf ("%d", &x1);
          x1 --;
          mask |= (1 << x1);
        }
      cerr << mask << endl;  
      s[1][mask] = 1;  
    }
  ford (i, 1 << n)
    {
      if (s[0][i])
        forn (j, n)
          if (i & (1 << j))
            s[0][i^(1<<j)] = 1;
      if (s[1][i])
        forn (j, n)
          if (i & (1 << j))
            s[1][i^(1<<j)] = 1;
    }
  int ans = 0;
  forn (i,  1 << n)
    if (s[0][i] && !s[1][i])
      ans ++;
      cout << ans << endl;
  return 0;
}
