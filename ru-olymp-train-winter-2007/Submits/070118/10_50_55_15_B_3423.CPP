#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

int x[8];
int y[8];

__int64 cnt = 0;
__int64 tot = 0;
bool ok = false;

void intr (int i, int j)
{
  if (!(max (x[i], x[i + 4]) < min (x[j], x[j + 4]) ||
        min (x[i], x[i + 4]) > max (x[j], x[j + 4]) ||
        max (y[i], y[i + 4]) < min (y[j], y[j + 4]) ||
        min (y[i], y[i + 4]) > max (y[j], y[j + 4])))
    ok = false;
}

#define FRN(a) for(x[a]=0;x[a]<n;x[a]++)
#define FRM(a) for(y[a]=0;y[a]<m;y[a]++)

int main ()
{
  freopen ("heritage.in", "rt", stdin);
  freopen ("heritage.out", "wt", stdout);

  int n, m;
  scanf ("%d %d", &n, &m);
  n++, m++;

  FRN (0) FRN (1) FRN (2) FRN (3) FRN (4) FRN (5) FRN (6) FRN (7)
  FRM (0) FRM (1) FRM (2) FRM (3) FRM (4) FRM (5) FRM (6) FRM (7)
  {
    ok = true;
    tot++;
    for (int i = 0; i < 3 && ok; i++) for (int j = i + 1; j < 4 && ok; j++) intr (i, j);
    if (ok) cnt++;
  }

  printf ("%.8lf", (double) cnt / (double) tot);

  return 0;
}
