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

char s[4000];
int n;
int t[3000], p[3000];
bool u[3000][3000];

int main ()
{
  freopen ("palin.in", "r", stdin);
  freopen ("palin.out", "w", stdout);
  memset (s, 0, sizeof (s));
  scanf ("%s", s);
  n = strlen (s);
  memset (t, 0, sizeof (t));
  t[n] = 0;
  memset (u, 0, sizeof (u));
  forn (i, n)
    for (int j = i; j >= 0; j --)
      if (s[i] == s[j])
        {
          if (j + 1 >= i)
            u[j][i] = 1;
           else
            u[j][i] = u[j+1][i-1];
        }
  memset (p, 255, sizeof (p));      
  for (int i = n-1; i >= 0; i--)
    {
      t[i] = inf;
      for (int j = i; j < n; j ++)
        if (u[i][j])
          if (t[i] > t[j+1] + 1)
            {
              t[i] = t[j+1] + 1;
              p[i] = j;
            }
    }
  printf ("%d\n", t[0]);
  int i = 0;
  while (i < n)
    {
      for (int j = i; j <= p[i]; j ++)
        printf ("%c", s[j]);
      i = p[i]+1;
      printf ("\n");
    }   
  return 0;
}