#include <cstdio>
#include <cstring>

using namespace std;

int cnt[100100];

int main () {
  freopen ("sum.in", "rt", stdin);
  freopen ("sum.out", "wt", stdout);
  int n, m, k;
  scanf ("%d%d%d", &n, &m, &k);
  memset (cnt, 0, sizeof (cnt));
  for (int i = 0; i < k; i++) {
    int a, b, c;
    scanf ("%d%d%d", &a, &b, &c);
    if (a == 1) {
      for (int j = b; j <= c; j++) cnt[j] = (cnt[j] + 1) % m;
    } else {
      int tmp = 0;
      for (int j = b; j <= c; j++) tmp += cnt[j];
      printf ("%d\n", tmp);
    }
  }
}