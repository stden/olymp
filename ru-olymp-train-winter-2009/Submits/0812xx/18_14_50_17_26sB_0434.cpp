#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cstring>
#include <ctime>
#include <cassert>
#include <cmath>

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

int64 p, x, a, k, s;
set <int64> st;
vector <int64> d;
int64 rt;
map <int64, int64> m;

int64 power (int64 x, int64 pw)
{
  if (pw < 0)
    pw += p - 1;
  int64 res = 1;
  while (pw > 0)
    {
      if (pw & 1)
        res = (res * x) % p;
      pw /= 2;
      x = (x * x) % p;
    }
  return res;  
}

bool check (int64 x)
{
  forn (i, d.size())
    if (power (x, d[i]) == 1)
      return false;
  return true;    
}

int64 gcd (int64 a, int64 b, int64 &x, int64 &y)
{
  if (a == 0)
    {
      x = 0;
      y = 1;
      return b;
    }
  int64 dl = gcd (b % a, a, x, y);
  int64 x1, y1;
  x1 = y - x * (b / a);
  y1 = x;
  x = x1;
  y = y1;
  return dl;
}

int main ()
{
  freopen ("roots.in", "r", stdin);
  freopen ("roots.out", "w", stdout);
  cin >> p >> k >> a;
  k %= (p-1);
  if (p == 2 || a == 0)
    {
      printf ("1\n%lld\n", a);
      return 0;
    }
  if (k == 0)
    {
      if (a != 1)
        {
          printf ("0\n\n");
          return 0;
        }
      printf ("%d\n", p-1);
      for (int64 i = 1; i < p; i ++)
        printf ("%lld ", i);
      printf ("\n");  
      return 0;
    }
  if (a == 1)
    {
      if (!(k & 1))
        printf ("2\n%lld %lld\n", a, p-1);
       else
        printf ("1\n%lld\n", a);
      return 0;
    }
  st.clear ();
  int64 q = p - 1;
  for (int64 i = 2; i * i <= q; i ++)
    while (!(q % i))
      {
        st.insert ((p-1) / i);
        q /= i;
      }  
  if (q != 1 && q != p)
    st.insert ((p-1) / q);
  d = vector <int64> (st.begin(), st.end());
  rt = 2;
  while (!check (rt))
    rt ++;
  int64 y = ((int)sqrt (p)) + 1;
  int64 f = power (rt, y);
  m.clear ();
  int64 z = f;
  int64 cs = y;
  forn (i, y+1)
    {
      m[z] = cs;
      cs += y;
      z = (z * f) % p;
    }
  z = a;
  cs = 0;
  forn (i, y+1)
    {
      if (m.count (z))
        {
          cs = (m[z] - cs + p-1) % (p-1);
          break;
        }
      m[z] = cs;
      cs ++;
      z = (z * rt) % p;
    }
  s = cs;
  d.clear ();
  int64 dl = gcd (k, p-1, x, y);
  if (!(s % dl))
    {
      int64 x1, y1;
      int64 dl1 = gcd (k, p-1, x1, y1);
//      cerr << rt << " " << x1  << " " << k << " " << y1 << " "<< p-1 << " " << s << endl;
      x1 = (x1 * (s / dl)) % (p-1);
      x = power (rt, x1);
      x1 = x;
      for (int64 i = 1; i <= dl1; i ++)
        {
          d.pb (x1);
          x1 = (x1 * power (x, (p-1) / dl1)) % p;
        }
    }
  sort (all (d));
  d.resize (unique (all (d)) - d.begin());
  printf ("%d\n", d.size());
  forn (i, d.size())
    printf ("%lld ", d[i]);
  printf ("\n");  
  return 0;
}