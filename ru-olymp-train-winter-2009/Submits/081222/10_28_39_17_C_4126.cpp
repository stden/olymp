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
typedef vector <int> vi;

const int inf = (1 << 30) - 1;
const int64 inf64 = ((int64)1 << 62) - 1;

vi a, b;

void read_long (vi &a)
{
  a.resize (1000);
  a[0] = 0;
  char ch;
  while (scanf ("%c", &ch) > 0)
    if (isdigit (ch))
      {
        a[0] ++;
        a[a[0]] = ch - '0';
      }
  reverse (a.begin()+1, a.begin()+a[0]+1);    
}

void print (vi &a)
{
  printf ("%d", a[a[0]]);
  for (int i = a[0]-1; i > 0; i --)
    printf ("%d", a[i]);
  printf ("\n");  
}

vi mult (vi a, int d)
{
  int o = 0;
  for (int i = 1; i <= a[0]; i ++)
    {
      a[i] = a[i] * d + o;
      o = a[i] / 10;
      a[i] %= 10;
    }
  if (o)
    {
      a[0] ++;
      a[a[0]] = o;
    }
  while (a[0] > 0 && a[a[0]] == 0)
    a[0] --;
  return a;  
}

vi add (vi a, int d)
{
  a[1] += d;
  for (int i = 1; i <= a[0]; i ++)
    if (a[i] >= 10)
      {
        a[i] -= 10;
        a[i+1] ++;
      }
     else
      break;
  while (a[a[0]+1] > 0)
    a[0] ++;
  return a;  
}

vi long_add (vi a, vi b, int d)
{  
  a[0] = max (a[0], b[0] + d);
  for (int i = 1; i <= b[0]; i ++)
    {
      a[i+d] += b[i];
      while (a[i+d] >= 10)
        {
          a[i+d] -= 10;
          a[i+d+1] ++;
        }
    }
  while (a[a[0]+1] > 0)
    a[0] ++;
  return a;  
}

vi long_mult (vi a, vi b)
{
  vi res;
  res.resize (1000);
  for (int i = 1; i <= b[0]; i ++)
    res = long_add (res, mult (a, b[i]), i-1);
  return res;  
}

vi div (vi a, int d)
{
  for (int i = a[0]; i > 0; i --)
    {
      if (i > 1)
        a[i-1] += 10 * (a[i] % d);
      a[i] = a[i] / d;  
    }
  while (a[0] > 0 && a[a[0]] == 0)
    a[0] --;
  return a;  
}

int main ()
{
  freopen ("room.in", "r", stdin);
  freopen ("room.out", "w", stdout);
  read_long (a);
  b = add (a, 1);
  a = long_mult (a, b);
  a = add (a, 1);
  a = div (a, 3);
  print (a);
  return 0;
}