#include <stdio.h>
#include <string.h>

#include "binsearch.h"

#ifdef _DBG_

#include <stdlib.h>
#include <windows.h>
static int _n;
static int _v;
static bool _w = false;
static bool _l = false;
static int _p;
static int _q;

int getN()
{
  if (_w)
    return _n;
  freopen ("binsearch.in", "rt", stdin);
  freopen ("binsearch.out", "wt", stdout);
  _l = false;
  scanf ("%d %d", &_n, &_v);
  _w = true;
  _p = 0;
  for (int x = 1; x <= _n; x += x)
    _p++;
  _p = _p * 2 / 3;
  if (_p <= 0) _p = 1;
  _q = 0;
  srand (GetTickCount ());
  return _n;
}

int qr (int i, int a)
{
  printf ("q: %d; a: %d\n", i, a);
  return a;
}

int query(int i)
{
  if (i > _n || i < 1)
    exit (1);
  _q++;
  if (_l == false && (rand () % _p) == 0)
  {
    _l = true;
    return qr (i, (_v <= i ? 0 : 1));
  }
  return qr (i, (_v <= i ? 1 : 0));
}

void answer(int i)
{
  printf ("%d (%d)", (i == _v ? _q : -1), i);
  exit (0);
}

#endif

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

bool lied = false;

int main ()
{
  int n = getN ();

  int l = 0;
  int r = n;

  while (l < r)
  {
    n = getN ();
    int k = (l + r) / 2;
    int a = query (k + 1);
    if (!lied)
    {
      int a2 = query (k + 1);
      if (a != a2)
      {
        a = query (k + 1);
        lied = true;
      }
    }
    if (a == 1)
      r = k;
    else
      l = k + 1;
  }
  answer (l + 1);

  return 0;
}
