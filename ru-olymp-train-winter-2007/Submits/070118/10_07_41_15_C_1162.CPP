#include <stdio.h>
#include <string.h>

#include <math.h>

#include <string>
using namespace std;

bool match[512];
int kmp[512];

int n, k;
char w[512];

char buf[1024];

int main ()
{
  freopen ("wordgame.in", "rt", stdin);
  freopen ("wordgame.out", "wt", stdout);

  scanf ("%d %d %s", &k, &n, w);

  int l = (int) strlen (w);
  
  kmp[0] = 0;
  for (int i = 1; w[i]; i++)
  {
    int cur = kmp[i - 1];
    while (cur > 0 && w[cur] != w[i])
      cur = kmp[cur - 1];
    if (w[cur] == w[i])
      kmp[i] = cur + 1;
    else
      kmp[i] = 0;
  }
  memset (match, 0, sizeof match);
  int cur = kmp[l - 1];
  while (cur > 0)
    match[cur] = true, cur = kmp[cur - 1];

  long double xpw = pow (k, l) + (l - 1);
  long double len = xpw;
  long double inc = xpw * (n - 1);
  for (int i = 1; i < l; i++)
    if (match[i])
    {
      int x = l - i;
      long double cp = 1.0 / pow (k, x);
      inc = inc * (1 - cp) + (cp * (n - 1)) * x;
    }
  len += inc;

  printf ("%.6lf", (double) len);

  return 0;
}
