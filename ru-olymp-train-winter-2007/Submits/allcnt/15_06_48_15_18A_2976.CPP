#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

typedef double real;

real dyn[65536][16];
bool done[65536][16];

//#define _DBG_

int n;

real A[16][16];
real B[16][16];

int next (int mask, int cur)
{
  cur++;
  while (!(mask & (1 << cur)) && cur < n)
    cur++;
  if (cur >= n) cur = 0;
  while (!(mask & (1 << cur)) && cur < n)
    cur++;
  return cur;
}
bool over (int mask)
{
  return (mask & (mask - 1)) == 0;
}

real get (int mask, int cur);

real K[16];
real Y[16];

real get (int mask, int cur0)
{
  if (done [mask][cur0])
    return dyn[mask][cur0];
  for (int i = 0; i < n; i++)
    done[mask][i] = true, dyn[mask][i] = 0;
  if (over (mask))
    return 0;

  int last = 0;
  int prev = 0;
  for (int cur = 0; cur < n; cur++)
  {
    if (!(mask & (1 << cur)))
      continue;
    real S = 0;
    K[cur] = 0;
    Y[cur] = 0;
    for (int i = 0; i < n; i++)
      if (mask & (1 << i) && i != cur)
        S += A[cur][i];
    for (int i = 0; i < n; i++)
    {
      if (mask & (1 << i) && i != cur)
      {
        int mask2 = mask & (~(1 << i));
        int cur2 = next (mask2, cur);
        real res2 = get (mask2, cur2);
        K[cur] += (A[cur][i] / S) * B[cur][i];
        Y[cur] += (A[cur][i] / S) * (B[cur][i] * res2);
      }
    }
    K[cur] = K[cur] - 1.0;
    Y[cur] += 1.0;
    prev = last;
    last = cur;
  }
#ifdef _DBG_
  printf ("[%d %d", prev, last);
  for (int i = 0; i < n; i++)
    printf ("(%lf %lf)", K[i], Y[i]);
#endif
  real cr = K[last];
  real v = Y[last];

  for (int i = 0; i < last; i++)
  {
    if (!(mask & (1 << i)))
      continue;

    if (i == prev)
      v -= Y[i] * cr, cr = 1.0 - cr * K[i];
    else
      v -= Y[i] * cr, cr = -cr * K[i];
  }
#ifdef _DBG_
  printf ("{%lf %lf}", cr, v);
  printf ("]");
#endif

  dyn[mask][last] = v / cr;
  prev = last;
  for (int i = last - 1; i >= 0; i--)
  {
    if (!(mask & (1 << i)))
      continue;

    dyn[mask][i] = Y[i] - K[i] * dyn[mask][prev];
    prev = i;
  }

  return dyn[mask][cur0];
}

int main ()
{
  freopen ("game.in", "rt", stdin);
  freopen ("game.out", "wt", stdout);

  memset (done, 0, sizeof done);

  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      scanf ("%lf", &A[i][j]);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n; j++)
      scanf ("%lf", &B[i][j]);
  for (int i = 0; i < n; i++)
    A[i][i] = B[i][i] = 0;

  for (int i = 0; i < (1 << n); i++)
    for (int j = 0; j < n; j++)
    {
#ifdef _DBG_
      printf ("!%d ", j + 1);
      int k = i;
      for (int s = 0; s < 8; s++)
        printf ((k & 1) ? "1" :"0"), k >>= 1;
      printf (": %lf\n", get (i, j));
#else
      get (i, j);
#endif
    }

  printf ("%.5lf", get ((1 << n) - 1, 0));

  return 0;
}
