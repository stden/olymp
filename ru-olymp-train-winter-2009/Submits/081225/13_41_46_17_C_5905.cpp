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

vector <int> a;
int n, m;

int main ()
{
  freopen ("dynarray.in", "r", stdin);
  freopen ("dynarray.out", "w", stdout);
  scanf ("%d%d", &n, &m);
  a.resize (n);
  forn (i, n)
    scanf ("%d", &a[i]);
  forn (i, m)
    {
      int o, x, y, z;
      scanf ("%d", &o);
      if (o == 1)
        {
          scanf ("%d%d", &x, &y);
          a[x-1] = y;
        }
       else
      if (o == 2)
        {
          scanf ("%d%d", &x, &y);
          a.insert (a.begin()+x, y);
        }
       else
        {
          scanf ("%d%d%d", &x, &y, &z);
          int ans = 0;
          for (int i = x-1; i < y; i ++)
            if (a[i] <= z)
              ans ++;
          printf ("%d\n", ans);    
        }
    }
  return 0;  
}
