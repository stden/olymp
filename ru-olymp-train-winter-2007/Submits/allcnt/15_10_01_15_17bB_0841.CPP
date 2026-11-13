#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

bool d[256][256][256];
int x[256][256][256];

int n;
int v[256];
int s;

int m[3][256];
int mc[3];

int main ()
{
  freopen ("change.in", "rt", stdin);
  freopen ("change.out", "wt", stdout);

  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
    scanf ("%d", &v[i]), s += v[i];

  memset (d, 0, sizeof d);
  d[0][0][0] = true;
  for (int c = 1; c <= n; c++)
  {
    for (int i = 0; i <= s; i++)
      for (int j = 0; j <= s; j++)
      {
        if (d[c - 1][i][j])
        {
          d[c][i][j] = true;
          x[c][i][j] = 0;
        }
        else if (i >= v[c - 1] && d[c - 1][i - v[c - 1]][j])
        {
          d[c][i][j] = true;
          x[c][i][j] = v[c - 1];
        }
        else if (j >= v[c - 1] && d[c - 1][i][j - v[c - 1]])
        {
          d[c][i][j] = true;
          x[c][i][j] = -v[c - 1];
        }
        else
          d[c][i][j] = false;
      }
  }

  int ms = 1000000000;
  int mi, mj;
  for (int i = 0; i <= s; i++)
  {
    for (int j = 0; j <= s; j++)
    {
      int k = s - i - j;
      if (i * i + j * j + k * k < ms && d[n][i][j])
        ms = i * i + j * j + k * k, mi = i, mj = j;
    }
  }
  mc[0] = mc[1] = mc[2] = 0;
  for (int c = n; c > 0; c--)
  {
    if (x[c][mi][mj] > 0)
      m[0][mc[0]++] = x[c][mi][mj], mi -= x[c][mi][mj];
    else if (x[c][mi][mj] < 0)
      m[1][mc[1]++] = -x[c][mi][mj], mj += x[c][mi][mj];
    else
      m[2][mc[2]++] = v[c - 1];
  }
  for (int i = 0; i < 3; i++, printf ("\n"))
  {
    printf ("%d ", mc[i]);
    for (int j = mc[i] - 1; j >= 0; j--)
      printf ("%d ", m[i][j]);
  }

  return 0;
}
