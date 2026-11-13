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

int n, a[16];
int s[65536];

int main ()
{
  freopen ("modsum2.in", "r", stdin);
  freopen ("modsum2.out", "w", stdout);
  scanf ("%d", &n);
  forn (i, n)
    scanf ("%d", &a[i]);
  forn (i, 1 << n)
    {
      s[i] = 0;
      forn (j, n)
        if (i & (1 << j))
          s[i] += a[j];
    }
  int64 ans = 0;  
  for (int i = 1; i < (1 <<n ) - 1; i ++)
    for (int j = (i+1)|i; j < (1 << n); j = (j + 1) | i)
      ans += (int64)s[i] % s[i^j];
  cout << ans << endl;    
  return 0;
}
