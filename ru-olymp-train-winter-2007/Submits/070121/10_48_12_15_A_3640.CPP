#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

class tree
{
  enum {maxt = 131072};
  __int64 t[maxt + maxt];
public:
  void build ();
  __int64 get (int l, int r);
  void add (int i, int a);
};

void tree::build ()
{
  memset (t, 0, sizeof t);
}

__int64 tree::get (int l, int r)
{
  l += maxt, r += maxt;
  if (l == r)
    return t[l];
  __int64 res = t[l] + t[r];
  while (l < r - 1)
  {
    if (!(l & 1))
      res += t[l + 1];
    if (r & 1)
      res += t[r - 1];
    l >>= 1, r >>= 1;
  }
  return res;
}

void tree::add (int i, int a)
{
  i += maxt;
  t[i] += a;
  i >>= 1;
  while (i > 0)
    t[i] += a, i >>= 1;
}

tree t;
char buf[32];

inline void inc (int x, int p)
{
  if (x < 1 || x > 100001)
    return;
  t.add (x, p);
  t.add (x - 1, p);
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
    int a, b;
    scanf ("%s %d %d", buf, &a, &b);
    fprintf (stderr, "%d\n", i);
    if (buf[0] == 'A')
    {
      int x = a;
      int p = b;
      inc (x, p);
      for (int j = 1; j <= min (b, 100000); j++)
        inc (x - j, p - j), inc (x + j, p - j);
    }
    else
    {
      if (a < b)
      {
        __int64 r = t.get (a, b - 1);
        printf ("%I64d.%d00\n", r >> 1, (r & 1) ? 5 : 0);
      }
      else if (a > b)
      {
        __int64 r = t.get (b, a - 1);
        printf ("%I64d.%d00\n", r >> 1, (r & 1) ? 5 : 0);
      }
      else
        printf ("0.000\n");
    }
  }

  return 0;
}
