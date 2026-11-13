#include <cstdio>

using namespace std;

int use[1024];

int main () {
  freopen ("marked.in", "rt", stdin);
  freopen ("marked.out", "wt", stdout);
  int n;
  int x, y;
  scanf ("%d%d%d", &n, &x, &y);
  for (int i = 0; i < x; i++) {
    int k;
    scanf ("%d", &k);
    int tmp = 0;
    for (int j = 0; j < k; j++) {
      int a;
      scanf ("%d", &a); a--;
      tmp += (1 << a);
    }
    for (int j = tmp; j > 0; j = (j - 1) & tmp)
      use[j] = 1;
    use[0] = 1;
  }
  for (int i = 0; i < y; i++) {
    int k;
    scanf ("%d", &k);
    int tmp = 0;
    for (int j = 0; j < k; j++) {
      int a;
      scanf ("%d", &a); a--;
      tmp += (1 << a);
    }
    for (int j = tmp; j > 0; j = (j - 1) & tmp)
      use[j] = 0;
    use[0] = 0;
  }
  int ans = 0;
  for (int j = 0; j < (1 << n); j++) ans += use[j];
  printf ("%d\n", ans);
}