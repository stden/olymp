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

char s[20000];

int main ()
{
  freopen ("next.in", "r", stdin);
  freopen ("next.out", "w", stdout);
  memset (s, 0, sizeof (s));
  scanf ("%s", s);
  int n = strlen (s);
  int pw = 0;
  for (int i = n-1; i >= 0; i --)
    if (s[i] == '0')
     {
       pw = i;
       break;
     }  
  if (pw == 0)
    {
      printf ("%s\n", s);
      return 0;
    }
  while (true)
    {
      s[pw] = '1';
      int v = pw+1;
      if (v == n)
        break;
      int p = 0;
      while (v < n)
        {
          if (s[p] == '0')
            pw = v;
          s[v] = s[p];
          v ++;
          p ++;
        }   
    }
  printf ("%s\n", s);  
  return 0;
}