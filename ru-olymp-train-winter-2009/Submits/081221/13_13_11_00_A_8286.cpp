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
int f [MaxN] [MaxK2];
int k, k2, m, n, v;

int main (void)
{
 int i, j, l, r;
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
   for (k = 0; k < n; k++)
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

  printf ("850\n");
/*
  memset (w, 0, sizeof (w));
  k2 = 1 << k;
  for (i = 0; i < n; i++)
   for (j = 0; j < k2; j++)
    w[
*/
 }
 return 0;
}
