#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cstring>
#include <ctime>
#include "treeunit.h"

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

struct rec
{
  int v, next, n;
};

int cs, ver[200010], list, n, lf[200010], rg[200010], cv;
bool ureb[200010];
rec reb[400010];
int ur[200010], uv[200010], qr[200010], qv[200010], d[200010];

void push (int v1, int v2, int nm)
{
  reb[list].v = v2;
  reb[list].n = nm;
  reb[list].next = ver[v1];
  ver[v1] = list;
  list ++;
}

void go (int v, int p)
{
  if (uv[v] == cs)
    return;
  uv[v] = cs;
  qv[0] ++;
  qv[qv[0]] = v;
  n ++;
  d[v] = 1;
  int ptr = ver[v];
  while (ptr != -1)
    {
      if (ureb[reb[ptr].n])
        {
          if (ur[reb[ptr].n] != cs)
            {
              qr[0] ++;
              qr[qr[0]] = reb[ptr].n;
              ur[reb[ptr].n] = cs;
            }
          if (reb[ptr].v != p)  
            {
              go (reb[ptr].v, v);
              d[v] += d[reb[ptr].v];
            }  
        }
      ptr = reb[ptr].next;  
    }
}

void calc ()
{
  qr[0] = qv[0] = 0;
  n = 0;
  cs ++;
  go (cv, 0);
}

int find ()
{
  int ans = n, an = qr[1];
  for (int i = 1; i <= qr[0]; i ++)
    {
      int ax = qr[i];
      int v1 = lf[ax];
      int v2 = rg[ax];
      if (d[v1] < d[v2])
        swap (v1, v2);
      int na = max (d[v2], n - d[v2]);
      if (na < ans || (na == ans && (rand()&1)))
        {
          ans = na;
          an = ax;
        }
    }
  return an;  
}

int main ()
{
  init ();
  n = getN ();
  forn (i, n-1)
    {
      lf[i+1] = getA (i+1);
      rg[i+1] = getB (i+1);
    }
  forn (i, n-1)
    ureb[i+1] = 1;
  cv = 1;  
  memset (ver, 255, sizeof (ver));
  list = 0;
  forn (i, n-1)
    {
      push (lf[i+1], rg[i+1], i+1);
      push (rg[i+1], lf[i+1], i+1);
    } 
  n = 0;
  cs = 0;
  memset (ur, 0, sizeof (ur));
  memset (uv, 0, sizeof (uv));
  calc ();
  while (n > 1)
    {
      int num = find ();
      int x = query (num);
      if (x == 0)
        cv = lf[num];
       else
        cv = rg[num];
      ureb[num] = false;
      calc ();
    }
  report (cv);  
  return 0;
}