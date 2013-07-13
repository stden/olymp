#include <cstdio>
#include <cstring>
#include <algorithm>

#define max(a, b) ((a) > (b) ? (a) : (b))
#define min(a, b) ((a) < (b) ? (a) : (b))

using namespace std;

#define inf (int)1e9
#define maxn 103
int n, log[maxn], f[maxn][maxn][maxn], pr[maxn][maxn][maxn];

int d( int x1, int x2, int y1, int y2, int g )
{
  if (x1 > x2) swap(x1, x2);
  if (y1 > y2) swap(y1, y2);
  y2 -= x1, y1 -= x1, x2 -= x1, x1 = 0;

  if (g)
    return y1 - x2 > 0 ? log[y1 - x2] : 0;
  if (y2 - x1 <= 1)
    return 0;
    
  int i, tmp, &r = f[x2][y1][y2];
  if (r != -1)
    return r;
  r = inf;
  if (y1 <= x2)
  {
    for (i = x1; i < y1; i++)
      if (r > (tmp = max(log[i - x1], d(i, x2, y1, y2, 0)) + 1))
        r = tmp, pr[x2][y1][y2] = i;
    for (i = y2 + 1; i <= n; i++)
      if (r > (tmp = max(log[n - i], d(x1, x2, y1, i, 0)) + 1))
        r = tmp, pr[x2][y1][y2] = i;
    for (i = y1; i <= y2; i++)
      if (r > (tmp = max(log[y1 - x1], log[y2 - x2]) + 1))
        r = tmp, pr[x2][y1][y2] = i;
    return r;
  }
  for (i = x1; i <= y2; i++)
    if (r > (tmp = max(d(i, x2, y1, y2, 0), d(x1, x2, y1, i, 0)) + 1))
      r = tmp, pr[x2][y1][y2] = i;
  return r;
}

int main( void )
{
  freopen("oracul.in", "rt", stdin);
  freopen("oracul.out", "wt", stdout);
  
  int i;
  scanf("%d", &n), n++;
  log[0] = log[1] = 0;
  for (i = 2; i < maxn; i++)
    log[i] = log[(i + 1) >> 1] + 1;
  memset(f, -1, sizeof(f));
  printf("%d ", d(0, 0, n, n, 0));
  printf("%d\n", n - 1 - pr[0][n][n]);
  return 0;
}
