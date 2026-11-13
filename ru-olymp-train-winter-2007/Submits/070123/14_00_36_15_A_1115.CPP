#include <stdio.h>
#include <string.h>
#include <math.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

struct chain
{
  int d[8];
  int k, n;
};
int read_int (int& a, char* str)
{
  a = 0;
  int i = 0;
  while (str[i] >= '0' && str[i] <= '9')
    a = a * 10 + str[i] - '0', i++;
  return i;
}
void read_chain (chain& a)
{
  char str[64];
  scanf ("%s", str);
  int cur = 1;
  a.k = 0;
  a.n = 0;
  cur += read_int (a.d[0], str + cur) + 1;
  while (str[cur] >= '0' && str[cur] <= '9')
    cur += read_int (a.d[++a.k], str + cur) + 1, a.n++;
  cur++;
  while (str[cur] >= '0' && str[cur] <= '9')
    cur += read_int (a.d[++a.n], str + cur) + 1;
}

void print_chain (chain& a)
{
  printf ("[%d;", a.d[0]);
  for (int i = 1; i <= a.k; i++)
    printf ("%d,", a.d[i]);
  printf ("(%d", a.d[a.k + 1]);
  for (int i = a.k + 2; i <= a.n; i++)
    printf (",%d", a.d[i]);
  printf (")]");
}

double eval_nonperiod (chain& a, double v)
{
  for (int i = a.k; i > 0; i--)
    v = 1.0 / (v + a.d[i]);
  return v + a.d[0];
}
double eval_period (chain& a, double v)
{
  for (int i = a.n; i > a.k; i--)
    v = 1.0 / (v + a.d[i]);
  return v;
}
struct poly
{
  __int64 x;
  __int64 c;
};
double eval_chain (chain& a)
{ 
  poly top, free, temp;
  top.x = 0;
  top.c = -1;
  free.x = 1;
  free.c = 0;
  for (int i = a.k + 1; i <= a.n; i++)
  {
    temp.x = free.x * a.d[i] + top.x;
    temp.c = free.c * a.d[i] + top.c;
    top = free;
    free = temp;
  }
  // free + top * x = 0
  __int64 k2 = top.x;
  __int64 k1 = top.c + free.x;
  __int64 k0 = free.c;
  __int64 d = k1 * k1 - 4 * k0 * k2;
  if (d < 0)
    return -1;
  double v = (double (-k1) + sqrt (double (d))) / double (k2 * 2);
  return eval_nonperiod (a, v);
}

#define EPS 1e-8

int isint (double x)
{
  int v = int (x + EPS);
  if (fabs (x - double (v)) < EPS)
    return v;
  return -1;
}

int main ()
{
  freopen ("aplusb.in", "rt", stdin);
  freopen ("aplusb.out", "wt", stdout);

  chain a, b, c;
  read_chain (a);
  read_chain (b);

  double x = eval_chain (a);
  double y = eval_chain (b);
  if (x < 0 || y < 0)
  {
    printf ("Impossible");
    return 0;
  }
  x += y;
  for (c.n = 1; c.n <= 7; c.n++)
  {
    for (c.k = 0; c.k < c.n; c.k++)
    {
      for (int i = 0; i <= c.n; i++)
        c.d[i] = 1;
      while (true)
      {
        double r = eval_chain (c);
        if (r < x - EPS)
        {
          int v = isint (x - r);
          if (v >= 0)
          {
            c.d[0] += v;
            print_chain (c);
            return 0;
          }
        }
        int cur = c.n;
        while (cur > 0 && c.d[cur] == 10)
          c.d[cur] = 1, cur--;
        if (cur <= 0)
          break;
        c.d[cur]++;
      }
    }
  }
  printf ("Impossible");

  return 0;
}
