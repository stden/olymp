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
static int _li;

int getN()
{
  if (_w)
    return _n;
  freopen ("binsearch.in", "rt", stdin);
  freopen ("binsearch.out", "at", stdout);
  srand (GetTickCount ());
  scanf ("%d", &_n);
  _li = rand () % 13;
  _v = (rand () % (_n + 1)) + 1;
  _l = false;
  _w = true;
  _p = 0;
  for (int x = 1; x <= _n; x += x)
    _p++;
  _p = _p * 2 / 3;
  if (_p <= 0) _p = 1;
  _q = 0;
  return _n;
}

int qr (int i, int a)
{
  return a;
}

int query(int i)
{
  if (i > _n || i < 1)
    exit (1);
  _q++;
  if (_q == _li)
  {
    _l = true;
    return qr (i, (_v <= i ? 0 : 1));
  }
  return qr (i, (_v <= i ? 1 : 0));
}

void answer(int i)
{
  printf ("%d (%d)\n", (i == _v ? _q : -1), i);
  exit (0);
}

#endif

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

bool lied = false;

int n;
int state[64];
int state2[64];
void emulate (int k, int a)
{
  if (a)
  {
    for (int i = 0; i <= k; i++)
      state2[i] = state[i];
    for (int i = k + 1; i <= n; i++)
      state2[i] = max (0, state[i] - 1);
  }
  else
  {
    for (int i = 0; i <= k; i++)
      state2[i] = max (0, state[i] - 1);
    for (int i = k + 1; i <= n; i++)
      state2[i] = state[i];
  }
}
int eval ()
{
  int cnt = 0;
  for (int i = 0; i <= n; i++)
    cnt += state2[i] * state2[i];
  return cnt;
}
int eval (int a)
{
  emulate (a, 0);
  int r1 = eval ();
  emulate (a, 1);
  int r2 = eval ();
  return max (r1, r2);
}
int curpos ()
{
  int cur = -1;
  for (int i = 0; i <= n; i++)
    if (state[i])
    {
      if (cur < 0) cur = i;
      else return -1;
    }
  return cur;
}

int main ()
{
  n = getN ();

  for (int i = 0; i <= n; i++)
    state[i] = 2;

  int code = curpos ();
  while (code < 0)
  {
    int mr = 1000000;
    int mi;
    for (int a = 0; a <= 60; a++)
    {
      int c = eval (a);
      if (c < mr) mr = c, mi = a;
    }
    int x = query (mi + 1);
    emulate (mi, x);
    memcpy (state, state2, sizeof state);
    code = curpos ();
  }
  answer (code + 1);
                    /*
  while (l < r)
  {
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
  answer (l + 1);    */

  return 0;
}
