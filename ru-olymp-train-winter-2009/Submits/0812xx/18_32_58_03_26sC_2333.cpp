#include <cstdio>

using namespace std;

int g[3][1000];
int t[3], q[3];

int main () {
  freopen ("quadratic.in", "rt", stdin);
  freopen ("quadratic.out", "wt", stdout);
  for (int i = 0; i < 3; i++) {
    scanf ("%d", &q[i]);
    for (int j = 0; j <= q[i]; j++) {
      scanf ("%d", &g[i][j]);
      g[i][j] %= 2;
    }
  }
  for (int i = 0; i < 3; i++)
    for (int j = 0; j <= q[i]; j++)
      t[i] = (t[i] + g[i][j]) % 2;
  int a = (t[0] + t[1]) % 2;
  int b = t[2];
  int c = (g[0][q[0]] + g[1][q[1]]) % 2;
  int d = g[2][q[2]];
//  printf ("%d %d %d %d\n", a, b, c, d);
  if (a * 0 == b && c * 0 == d) {
    printf ("-1\n");
    return 0;
  }
  if (c * 0 == d && a * 1 == b) {
    printf ("1 1 0\n");
    return 0;
  }
  if (c * 1 == d && a * 0 == b) {
    printf ("1 1 1\n");
    return 0;
  }
  if (c * 1 == d && a * 1 == b) {
    printf ("0 1\n");
    return 0;
  }
  printf ("no solution\n");
}