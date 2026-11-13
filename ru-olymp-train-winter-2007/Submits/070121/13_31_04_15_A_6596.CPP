#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

class tree
{
  enum {maxd = 17, maxt = (1 << maxd)};
  __int64 b[maxt + maxt];
  __int64 k[maxt + maxt];
  __int64 t[maxt + maxt];
  __int64 intg (int l, int r, __int64 b, __int64 k)
  {
    return b * (__int64) (r - l) + k * ((__int64) (r) * (__int64) (r - 1) - (__int64) (l) * (__int64) (l - 1)) / 2;
  }
  __int64 get (int l, int r, int i, __int64 b, __int64 k, int d);
  void add (int l, int r, int i, __int64 b, __int64 k, int d);
public:
  void build ();
  __int64 get (int l, int r);
  void add (int l, int r, __int64 b, __int64 k);
};

void tree::build ()
{
  memset (t, 0, sizeof t);
  memset (b, 0, sizeof b);
  memset (k, 0, sizeof k);
}

__int64 tree::get (int x1, int x2, int i, __int64 tb, __int64 tk, int d)
{
  int l = 1 << (maxd - d);
  int a = (i - (1 << d)) << (maxd - d);
  if (a >= x1 && a + l - 1 <= x2)
  {
    int r = a + l;
    return t[i] + tb * (__int64) (l) + tk * ((__int64) (r) * (__int64) (r - 1) - (__int64) (a) * (__int64) (a - 1)) / 2;
  }
  tb += b[i];
  tk += k[i];
  int l2 = l >> 1;
  int m = a + l2;
  __int64 res = 0;
  if (a + l2 > x1)
    res += get (x1, x2, i + i, tb, tk, d + 1);
  if (a + l2 <= x2)
    res += get (x1, x2, i + i + 1, tb, tk, d + 1);
  return res;
}

void tree::add (int x1, int x2, int i, __int64 tb, __int64 tk, int d)
{
  int l = 1 << (maxd - d);
  int a = (i - (1 << d)) << (maxd - d);
  if (a >= x1 && a + l - 1 <= x2)
  {
    b[i] += tb;
    k[i] += tk;
    t[i] += intg (a, a + l, tb, tk);
    return;
  }
  int l2 = l >> 1;
  int m = a + l2;
  t[i] -= t[i + i] + t[i + i + 1];
  if (a + l2 > x1)
    add (x1, x2, i + i, tb, tk, d + 1);
  if (a + l2 <= x2)
    add (x1, x2, i + i + 1, tb, tk, d + 1);
  t[i] += t[i + i] + t[i + i + 1];
}

__int64 tree::get (int l, int r)
{
  return get (l, r, 1, 0, 0, 0);
}

void tree::add (int l, int r, __int64 b, __int64 k)
{
  add (l, r, 1, b, k, 0);
}

tree t;
char buf[32];

inline void inc (__int64 x, __int64 p)
{
  t.add (max (x - p, 0), x - 1, 1 + 2 * (p - x), 2);
  t.add (x, min (x + p - 1, 100001), 2 * (p + x) - 1, -2);
}
inline __int64 get (int a, int b)
{
  if (a < b)
    return t.get (a, b - 1);
  else if (a > b)
    return t.get (b, a - 1);
  else
    return 0;
}

int main ()
{
  freopen ("geology.in", "rt", stdin);
  freopen ("geology.out", "wt", stdout);

  t.build ();
  int n;
  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
  {
    __int64 a, b;
    scanf ("%s %I64d %I64d", buf, &a, &b);
    if (buf[0] == 'A')
      inc (a, b);
    else
    {
      __int64 r = get (a, b);
      printf ("%I64d.%d00\n", r >> 1, (r & 1) ? 5 : 0);
//      printf ("%I64d\n", r);
    }
  }

  return 0;
}
