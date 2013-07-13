#include <stdio.h>
#include <string.h>
#include <algorithm>
using namespace std;

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

struct card
{
  char x[3];
};
int val[256];
bool operator < (card const& a, card const& b)
{
  return val[a.x[0]] < val[b.x[0]] || (a.x[0] == b.x[0] && a.x[1] < b.x[1]);
}
card cc[32];

int main ()
{
  freopen ("preference.in", "rt", stdin);
  freopen ("preference.out", "wt", stdout);

  for (int i = 0; i < 10; i++)
    val[i + '0'] = i;
  val['T'] = 10;
  val['J'] = 11;
  val['Q'] = 12;
  val['K'] = 13;
  val['A'] = 14;

  int n;
  scanf ("%d", &n);
  for (int i = 0; i < 12; i++)
    scanf ("%s", cc[i].x);
  sort (cc, cc + 12);

  printf ("10\n");
  printf ("%s %s\nN\n", cc[0].x, cc[1].x);

  return 0;
}
