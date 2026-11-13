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

int n, m, k, st, cs[50][7], dc[50][7], a[50][50], d[50][128], best[50][128];
bool u[50][128];
vector <int> ws;

void calc_best (int v)
{
  forn (i, 1 << k)
    {
      ws.clear ();
      best[v][i] = inf;
      forn (j, k)
        if (i & (1 << j))
	  ws.pb (j);
      bool us = true;
      forn (j, ws.size())
        if (cs[v][ws[j]] == 0)
	  us = false;
      if (!us)
        continue;
      int fc = 1;
      for (int j = 1; j <= (int)ws.size(); j ++)
        fc *= j;
      forn (j, fc)
        {
	  int ccs, cdc;
	  ccs = 0;
	  cdc = 100;
	  forn (p, ws.size())
	    {
	      ccs += (cs[v][ws[p]] / 100) * (cdc);
	      cdc -= dc[v][ws[p]];
	    }
	  best[v][i] = min (best[v][i], ccs);  
	  next_permutation (all (ws));
	}
    }
}

void go (int st, int mask)
{
  memset (u, 0, sizeof (u));
  forn (i, n)
    forn (j, 1 << k)
      d[i][j] = inf;
  d[st][mask] = 0;
  while (true)
    {
      int v = -1;
      int m = -1;
      forn (i, n)
        forn (j, 1 << k)
	  if (!u[i][j] && ((v == -1) || (d[i][j] < d[v][m])))
	    {
	      v = i;
	      m = j;
	    }    
      if ((v == -1) || (d[v][m] >= inf))
        break;
      u[v][m] = true;
      forn (i, n)
        if (d[i][m] > d[v][m] + a[i][v])
	  d[i][m] = d[v][m] + a[i][v];
      for (int j = m; j < (1 << k); j = (j + 1) | m)
        if (d[v][j] > d[v][m] + best[v][j^m])
          d[v][j] = d[v][m] + best[v][j^m];
    }
  int ans = inf;
  mask = (1 << k) - 1;
  forn (i, n)
    if (d[i][mask] + a[i][st] < ans)
      ans = d[i][mask] + a[i][st];
  if (ans == inf)
    ans = -1;
  printf ("%d\n", ans);  
}

int main ()
{
  freopen ("armor.in", "r", stdin);
  freopen ("armor.out", "w", stdout);
  scanf ("%d%d%d%d", &n, &m, &k, &st);
  st --;
  forn (i, n)
    forn (j, k)
      scanf ("%d%d", &cs[i][j], &dc[i][j]);
  memset (d, 255, sizeof (d));
  forn (i, n)
    forn (j, n)
      a[i][j] = inf;
  forn (i, n)
    a[i][i] = 0;
  forn (i, m)
    {
      int x, y, w;
      scanf ("%d%d%d", &x, &y, &w);
      x --;
      y --;
      a[x][y] = a[y][x] = w;
    }
  forn (p, n)
    forn (i, n)
      forn (j, n)
        a[i][j] = min (a[i][j], a[i][p] + a[p][j]);
  forn (i, n)  
    calc_best (i);
  go (st, 0);
  return 0;
}