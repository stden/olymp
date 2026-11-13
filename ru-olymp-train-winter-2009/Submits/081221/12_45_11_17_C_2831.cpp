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

int n, a[100001], t[2001][2001], p[2001][2001];

void go (int l, int r)
{
  if (t[l][r] != -1)
    return;
  if (l == r)
    {
      t[l][r] = 0;
      return;
    }  
  t[l][r] = inf;
  for (int i = l; i < r; i ++)
    {
      go (l, i);
      go (i+1, r);
      if (t[l][r] > (a[r] - a[l-1]) + t[l][i] + t[i+1][r])
        {
          t[l][r] = (a[r] - a[l-1]) + t[l][i] + t[i+1][r];
          p[l][r] = i;
        }
    }
}

void print (int l, int r, int v)
{
  while (p[l][r] != -1)
    {
      int w = p[l][r];
      if (v <= w)
        {
          printf ("0");
          r = w;
        }
       else
        {
          printf ("1");
          l = w + 1;
        }
    }
  printf ("\n");  
}

int main ()
{
  freopen ("code.in", "r", stdin);
  freopen ("code.out", "w", stdout);
  scanf ("%d", &n);
  forn (i, n)
    scanf ("%d", &a[i+1]);
  memset (t, 255, sizeof (t));
  memset (p, 255, sizeof (p));
  for (int i = 2; i <= n; i ++)
    a[i] += a[i-1];
  a[0] = 0;  
  go (1, n);
  forn (i, n)
    print (1, n, i+1);
  return 0;
}