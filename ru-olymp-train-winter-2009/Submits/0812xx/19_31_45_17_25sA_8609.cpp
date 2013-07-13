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

int n, a[1024], t[1024];

int main ()
{
  freopen ("cube.in", "r", stdin);
  freopen ("cube.out", "w", stdout);
  scanf ("%d", &n);
  forn (i, 1<<n)
    scanf ("%d", &a[i]);
  t[0] = a[0];
  for (int i = 0; i < (1 << n); i ++)
    forn (j, n)
      if (!(i & (1 << j)))
        t[i|(1<<j)] = max (t[i|(1<<j)], t[i] + a[i|(1<<j)]);
  cout << t[(1 << n)-1] << endl;      
  return 0;
}