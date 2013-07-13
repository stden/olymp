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

char s[4000000];
bool u[4000000];
int n, l, r, m;

int main ()
{
  freopen ("palin.in", "r", stdin);
  freopen ("palin.out", "w", stdout);
  memset (s, 0, sizeof (s));
  scanf ("%s", s);
  n = strlen (s);
  m = 0;
  memset (u, 0, sizeof (u));
  l = 0;
  r = n - 1;
  while (l < r)
    {
      if (s[l] == s[r])
        {
          m += 2;
          u[l] = u[r] = 1;
          l ++;
          r --;
        }
       else
      if (s[l] == '1')
        r --;
       else
        l ++;
    }
  if (l == r)
    {
      m ++;
      u[l] = 1;
    }
  if (m < n)
    printf ("2\n");
   else
    printf ("1\n");
  if (m < n)  
    {
      forn (i, n)
        if (!u[i])
          printf ("%c", s[i]);
      printf ("\n");
    }  
  forn (i, n)
    if (u[i])
      printf ("%c", s[i]);
  printf ("\n");
  return 0;
}