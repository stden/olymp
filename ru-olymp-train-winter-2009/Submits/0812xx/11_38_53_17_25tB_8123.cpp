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
typedef int ar[60];

const int inf = (1 << 30) - 1;
const int deg = 10000;

int n, d, l[9], r[9];
ar t1[9][501][50], t2[9][501];
ar tmp;

void long_add (ar &a, ar &b, int d)
{
  a[0] = max (a[0], b[0]+d);
  for (int i = 1; i <= b[0]; i ++)
    {
      a[i+d] += b[i];
      if (a[i+d] >= deg)
        {
          a[i+d] -= deg;
          a[i+d+1] ++;
        }
    }
  for (int i = a[0]-b[0]-d+1; i <= a[0]; i ++)
    if (a[i+d] >= deg)
      {
        a[i+d] -= deg;
        a[i+d+1] ++;
      }
     else
      break;
  while (a[a[0]+1] > 0)
    a[0] ++;
  while (a[0] > 0 && a[a[0]] == 0)
    a[0] --;
}

void mult (ar &a, int d)
{
  int o = 0;
  for (int i = 1; i <= a[0]; i ++)
    {
      a[i] = a[i] * d + o;
      o = a[i] / deg;
      a[i] %= deg;
    }
  if (o)
    {
      a[0] ++;
      a[a[0]] = o;
    }
  while (a[0] > 0 && a[a[0]] == 0)
    a[0] --;
}

void long_mult (ar &ans, ar &a, ar &b)
{
  ar tmp;
  for (int i = ans[0]+1; i >= 0; i--)
    ans[i] = 0;
  for (int i = 1; i <= b[0]; i ++)
    {
      for (int j = 0; j <= a[0]+1; j ++)
        tmp[j] = a[j];
      mult (tmp, b[i]);
      long_add (ans, tmp, i-1);
    }
}

void print (ar &a)
{
  printf ("%d", a[a[0]]);
  for (int i = a[0]-1; i > 0; i --)
    {
      if (a[i] == 0)
        {
          printf ("0000");
          continue;
        }
      int o = a[i];
      while (o * 10 < deg)
        {
          o *= 10;
          printf ("0");
        }
      printf ("%d", a[i]);  
    }
  printf ("\n");  
}

int main ()
{
  freopen ("btrees.in", "r", stdin);
  freopen ("btrees.out", "w", stdout);
  cin >> n >> d;
  if (n < d -1)
    {
      cout << 0 << endl;
      return 0;
    }
  if (n < d * (d-1))
    {
      if (n <= d * 2 - 1)
        cout << 1 << endl;
       else
        cout << 0 << endl;
      return 0;  
    }
  memset (t1, 0, sizeof (t1));
  memset (t2, 0, sizeof (t2));
  for (int i = d-1; i < d*2; i ++)
    t2[0][i][0] = t2[0][i][1] = 1;
  memset (tmp, 0, sizeof (tmp));
  l[0] = d-1;
  r[0] = d*2 - 1;
  for (int i = 1; i < 9; i ++)
    {
      l[i] = l[i-1] * d;
      r[i] = r[i-1] * d * 2;
      if (r[i] > n)
        r[i] = n+1;
   //   if (l[i] > n)
     //   l[i] = n+1;
    }
  cerr << l[9] << endl;  
  for (int h = 1; h < 9; h ++)
   if (l[h] <= n)
    {
      for (int k = 1; k <= min (n, r[h]); k ++)
        {
          memcpy (t1[h][k][1], t2[h-1][k], sizeof (t2[h-1][k]));
          for (int x = 2; x <= d * 2; x ++)
            {
              for (int i = l[h-1]; i <= min (k, r[h-1]); i ++)
                if (t2[h-1][i][0] > 0 && t1[h][k-i][x-1] > 0 && (x-1)*r[h-1] >= k-i)
                  {
                    long_mult (tmp, t1[h][k-i][x-1], t2[h-1][i]);
                    long_add (t1[h][k][x], tmp, 0);
                  }
            }
          for (int i = d; i <= d * 2; i ++)
            long_add (t2[h][k], t1[h][k][i], 0);
        }
    }
  memset (tmp, 0, sizeof (tmp));
  forn (i, 9)
    long_add (tmp, t2[i][n], 0);
  print (tmp);  
  return 0;
}
