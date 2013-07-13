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

long double eps = 1e-7;
long double a[30][30], ans[30];
int n;

ldb abs (ldb x)
{
  if (x < 0)
    x *= -1;
  return x;  
}

void swap_rows (int x, int y)
{
  forn (i, n+1)
    swap (a[x][i], a[y][i]);
}

void swap_col (int x, int y)
{
  forn (i, n+1)
    swap (a[i][x], a[i][y]);
}

int main ()
{
  freopen ("linear.in", "r", stdin);
  freopen ("linear.out", "w", stdout);
  memset (a, 0, sizeof (a));
  cin >> n;
  forn (i, n)
    forn (j, n+1)
      cin >> a[i][j];
  forn (i, n)
    a[n][i] = i;
  forn (i, n)
    {
      int x, y;
      x = y = i;
      for (int vx = i; vx < n; vx ++)
        for (int vy = i; vy < n; vy ++)
          if (abs (a[vx][vy] > abs (a[x][y])))
            {
              x = vx;
              y = vy;
            }
      if (abs (a[x][y]) < eps)
        {
          for (int j = i; j < n; j ++)
            if (abs(a[j][n]) > eps)
              {
                printf ("impossible\n");
                return 0;
              }
          printf ("infinity\n");    
          return 0;    
        }
      swap_rows (i, x);
      swap_col (i, y);
      for (int j = n; j >= i; j --)
        a[i][j] /= a[i][i];
      for (int j = i+1; j < n; j ++)
        for (int k = n; k >= i; k --)
          a[j][k] -= a[i][k] * a[j][i];
    }
  printf ("single\n");
  ford (i, n)
    {
      for (int j = i+1; j < n; j ++)
        a[i][n] -= a[i][j] * ans[(int)(a[n][j]+eps)];
      ans[(int)(a[n][i]+eps)] = a[i][n];
    }
  cout.precision (9);
  cout << fixed;
  forn (i, n)  
    cout << ans[i] << " ";
  cout << endl;  
  return 0;
}