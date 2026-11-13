#include <cstdio>

using namespace std;

int main () {
  freopen ("cube.in", "rt", stdin);
  freopen ("cube.out", "wt", stdout);
  int n;
  int best[1024];
  int c[1024];
  scanf ("%d", &n);
  int m = 1 << n;
  for (int i = 0; i < m; i++)
    scanf ("%d", &c[i]);
  best[0] = c[0];
  for (int i = 1; i < m; i++) {
    best[i] = 0;
    for (int j = 0; j < n; j++)
      if ((i >> j) & 1)
	if (best[i] < best[i - (1 << j)]) best[i] = best[i - (1 << j)];
    best[i] += c[i];
  }
  printf ("%d\n", best[m - 1]);
}