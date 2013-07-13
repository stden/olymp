#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

#define TASKNAME "armor"

using namespace std;

const int MinN = 1, MaxN = 50, MinM = 1, MaxM = 500, MinK = 1, MaxK = 7;
const int MinC = 1, MaxC = 1000000, MOD = 100, INF = 0x3F3F3F3F;
const int MinP = 0, MaxP = 10, MaxK2 = 1 << MaxK;

int a [MaxN] [MaxN];
int c [MaxN] [MaxK];
int p [MaxN] [MaxK];
int w [MaxN] [MaxK2];
int f [MaxK2];
bool b [MaxN] [MaxK2];
int k, k2, m, n, v;

int main (void)
{
 int i, j, l, r, s, t;
 int imin, jmin, wmin;
 freopen (TASKNAME ".in", "rt", stdin);
 freopen (TASKNAME ".out", "wt", stdout);
 while (scanf (" %d %d %d %d", &n, &m, &k, &v) != EOF)
 {
  assert (MinN <= n && n <= MaxN);
  assert (MinM <= m && m <= MaxM);
  assert (MinK <= k && k <= MaxK);
  assert (1 <= v && v <= n);
  v--;
  for (i = 0; i < n; i++)
   for (j = 0; j < k; j++)
   {
    scanf (" %d %d", &c[i][j], &p[i][j]);
    if (!c[i][j])
    {
     c[i][j] = INF;
    }
    else
    { 
     assert (MinC <= c[i][j] && c[i][j] <= MaxC);
     assert (c[i][j] % MOD == 0);
    }
    assert (MinP <= p[i][j] && p[i][j] <= MaxP);
   }
  memset (a, INF, sizeof (a));
  for (i = 0; i < m; i++)
  {
   scanf (" %d %d %d", &j, &l, &r);
   assert (1 <= j && j <= n);
   assert (1 <= l && l <= n);
   assert (j != l);
   assert (MinC <= r && r <= MaxC);
   j--; l--;
   if (a[j][l] > r)
   {
    a[j][l] = r;
    a[l][j] = r;
   }
  }

  memset (b, 0, sizeof (b));
  memset (w, INF, sizeof (w));
  w[v][0] = 0;
  k2 = 1 << k;
  while (!b[v][k2 - 1])
  {
   wmin = INF;
   imin = jmin = -1;
   for (i = 0; i < n; i++)
    for (j = 0; j < k2; j++)
     if (!b[i][j] && wmin > w[i][j])
     {
      wmin = w[i][j];
      imin = i;
      jmin = j;
     }
   if (wmin >= INF)
    break;
   b[imin][jmin] = true;
   memset (f, INF, sizeof (f));
   f[jmin] = wmin;
   for (j = 0; j < k2; j++)
    if ((j & jmin) == jmin)
    {
     s = MOD;
     for (l = 0; l < k; l++)
      if ((j ^ jmin) & (1 << l))
       s -= p[imin][l];
     for (l = 0; l < k; l++)
      if (!(j & (1 << l)) && c[imin][l] != INF)
      {
       r = j | (1 << l);
       t = f[j] + (c[imin][l] * s) / MOD;
       if (f[r] > t)
        f[r] = t;
      }
     if (w[imin][j] > f[j])
      w[imin][j] = f[j];
    }
   for (i = 0; i < n; i++)
   {
    t = w[imin][jmin] + a[imin][i];
    if (w[i][jmin] > t)
     w[i][jmin] = t;
   }
  }
  if (w[v][k2 - 1] >= INF)
   printf ("-1\n");
  else printf ("%d\n", w[v][k2 - 1]);
 }
 return 0;
}
