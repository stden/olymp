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

typedef long long int64;
typedef long double ldb;
typedef int ar[100000];

const int inf = (1 << 30) - 1;
const double eps = 1e-9;

char c[100000];

void read_long (ar &a)
{
  memset (a, 0, sizeof (a));
  memset (c, 0, sizeof (c));
  gets (c);
  a[0] = strlen (c);
  for (int i = 1; i <= a[0]; i ++)
    a[i] = c[a[0]-i] - '0';    
}

bool more (ar &a, ar &b)
{
  if (a[0] != b[0])
    return a[0] > b[0];
  for (int i = a[0]; i > 0; i --)
    if (a[i] != b[i])
      return a[i] > b[i];
  return false;
}

void print (ar &a)
{
  for (int i = a[0]; i > 0; i --)
    printf ("%d", a[i]);
  printf ("\n");  
}

void sub (ar &a, ar &b)
{
  for (int i = 1; i <= a[0]; i ++)
    {
      a[i] -= b[i];
      while (a[i] < 0)
        {
	  a[i] += 10;
	  a[i+1] --;
	}
    }
  while (a[0] > 0 && a[a[0]] == 0)
    a[0] --;
}

ar a, b;

int main ()
{
  freopen ("aplusminusb.in", "r", stdin);
  freopen ("aplusminusb.out", "w", stdout);
  read_long (a);
  read_long (b);
  if (more (b, a))
    {
      printf ("-");
      sub (b, a);
      print (b);
    }
   else
    {
      sub (a, b);
      print (a);
    }
  return 0;
}