#include <stdio.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <map>
using namespace std;

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

struct chain
{
  int d[4096];
  int k, n;
};
int read_int (int& a, char* str)
{
  a = 0;
  int i = 0;
  while (str[i] >= '0' && str[i] <= '9')
    a = a * 10 + str[i] - '0', i++;
  return i;
}
void read_chain (chain& a)
{
  char str[64];
  scanf ("%s", str);
  int cur = 1;
  a.k = 0;
  a.n = 0;
  cur += read_int (a.d[0], str + cur) + 1;
  while (str[cur] >= '0' && str[cur] <= '9')
    cur += read_int (a.d[++a.k], str + cur) + 1, a.n++;
  cur++;
  while (str[cur] >= '0' && str[cur] <= '9')
    cur += read_int (a.d[++a.n], str + cur) + 1;
}

void print_chain (chain& a)
{
  printf ("[%d;", a.d[0]);
  for (int i = 1; i <= a.k; i++)
    printf ("%d,", a.d[i]);
  printf ("(%d", a.d[a.k + 1]);
  for (int i = a.k + 2; i <= a.n; i++)
    printf (",%d", a.d[i]);
  printf (")]");
}

struct root
{
  __int64 k;
  __int64 b;
  __int64 d;
  __int64 c;
};
root eval_nonperiod (chain& a, root v)
{
  for (int i = a.k; i > 0; i--)
  {
    v.k += a.d[i] * v.c;
    __int64 t = v.c;
    v.c = v.k * v.k - v.b * v.b * v.d;
    v.k *= t;
    v.b *= -t;
  }
  v.k += a.d[0] * v.c;
  return v;
}
struct poly
{
  __int64 x;
  __int64 c;
};
__int64 gcd (__int64 a, __int64 b)
{
  if (b == 0) return a;
  return gcd (b, a % b);
}
void simplify (root& a)
{
  int sqx = int (sqrt (sqrt (double (a.d)))) + 5;
  for (int i = 2; i < sqx && a.d > 1; i++)
  {
    while ((a.d % (i * i)) == 0)
    {
      a.d /= i * i;
      a.b *= i;
    }
  }
  int k = gcd (gcd (a.k, a.b), a.c);
  a.k /= k;
  a.b /= k;
  a.c /= k;
}
void simplify2 (root& a)
{
  int k = gcd (gcd (a.k, a.b), a.c);
  a.k /= k;
  a.b /= k;
  a.c /= k;
}
root eval_chain (chain& a)
{ 
  poly top, free, temp;
  top.x = 0;
  top.c = -1;
  free.x = 1;
  free.c = 0;
  for (int i = a.k + 1; i <= a.n; i++)
  {
    temp.x = free.x * a.d[i] + top.x;
    temp.c = free.c * a.d[i] + top.c;
    top = free;
    free = temp;
  }
  // free + top * x = 0
  __int64 k2 = top.x;
  __int64 k1 = top.c + free.x;
  __int64 k0 = free.c;
  __int64 d = k1 * k1 - 4 * k0 * k2;
  root r;
  r.k = -k1;
  r.b = 1;
  r.d = d;
  r.c = k2 * 2;
  r = eval_nonperiod (a, r);
  simplify (r);
  return r;
}

#define EPS 1e-8

int isint (double x)
{
  int v = int (x + EPS);
  if (fabs (x - double (v)) < EPS)
    return v;
  return -1;
}

bool mgreater (root v, __int64 x)
{
  __int64 o = x;
  x *= v.c;
  x -= v.k;
  bool res = v.b * v.b * v.d >= x * x;
//  printf ("(%I64d + %I64d * sqrt (%I64d)) / %I64d %s %I64d\n", v.k, v.b, v.d, v.c, res ? ">=" : "<", o);
  return res;
}

bool operator < (root const& a, root const& b)
{
  return memcmp (&a, &b, sizeof a) < 0;
}

map<root, int> mp;
bool build_chain (chain& a, root v)
{
  a.n = -1;
  a.k = -1;
  for (int i = 0; i < 3000; i++)
  {
    a.n++, a.k++;
    if (mp.find (v) != mp.end ())
    {
      a.n--;
      a.k = mp[v] - 1;
      return true;
    }
    mp[v] = a.n;
    if (mgreater (v, 11))
      return false;
    a.d[a.n] = 1;
    while (mgreater (v, a.d[a.n] + 1))
      a.d[a.n]++;
    v.k -= a.d[a.n] * v.c;
    __int64 t = v.c;
    v.c = v.k * v.k - v.b * v.b * v.d;
    v.k *= t;
    v.b *= -t;
    simplify2 (v);
  }
  return true;
}
void find_period (chain& a)
{
  bool ok = false;
  int mi = 1025;
  for (int i = 1024; i > 0; i--)
  {
    ok = true;
    for (int j = 0; j < i && ok; j++)
      if (a.d[a.n - j] != a.d[a.n - j - i])
        ok = false;
    if (ok)
      mi = i;
  }
  int i = mi;
  if (!ok)
    return;
  ok = false;
  int s;
  for (s = 1; s < 1024 && !ok; s++)
  {
    ok = true;
    for (int j = 0; j < i && ok; j++)
      if (a.d[s + j] != a.d[s + j + i])
        ok = false;
  }
  s--;
  a.n = s + i - 1;
  a.k = s - 1;
}

chain a, b, c;

int main ()
{
  int FINISH = clock () + (CLOCKS_PER_SEC * 1800) / 1000;
  freopen ("aplusb.in", "rt", stdin);
  freopen ("aplusb.out", "wt", stdout);

  read_chain (a);
  read_chain (b);

  root x = eval_chain (a);
  root y = eval_chain (b);
  if (x.d != y.d)
  {
    printf ("Impossible");
    return 0;
  }
  x.k = x.k * y.c + y.k * x.c;
  x.b = x.b * y.c + y.b * x.c;
  x.c *= y.c;
  simplify (x);
  if (!build_chain (c, x))
  {
    printf ("Impossible");
    return 0;
  }
  print_chain (c);
//  find_period (c);
//  print_chain (c);
  root z = eval_chain (c);
  if (memcmp (&z, &x, sizeof z))
    printf ("AAA");

  return 0;
}
