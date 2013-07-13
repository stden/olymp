#include <cstdio>
#include <cstring>

using namespace std;

int n, m, k;
int tree[300000][5], down[300000];

int init (int x, int l, int r) {
  tree[x][0] = r - l + 1;
  if (l == r) return 0;
  int s = (l + r) / 2;
  init (x * 2, l, s);
  init (x * 2 + 1, s + 1, r);
  return 0;
}

int update (int x, int l, int r) {
  down[x] %= k;
  if (!down[x]) return 0;
  int tmp[5];
  for (int i = 0; i < k; i++) tmp[i] = tree[x][i];
//  for (int i = 0; i < k; i++) printf ("%d ", tmp[i]);
//  printf ("\n");
  for (int i = 0; i < k; i++) tree[x][i] = tmp[(k + i - down[x]) % k];
  if (l < r) {
    down[x * 2] += down[x];
    down[x * 2 + 1] += down[x];
  }
  down[x] = 0;
  return 0;
}

int add (int x, int l, int r, int lc, int rc) {
  if (r < lc || l > rc) return 0;
  if (l >= lc && r <= rc) {
    down[x]++;
//    printf ("%d %d\n", l, r);
//    for (int i = 0; i < k; i++) printf ("%d: %d\n", i, tree[x][i]);
    update (x, l, r);
//    printf ("%d %d\n", l, r);
//    for (int i = 0; i < k; i++) printf ("%d: %d\n", i, tree[x][i]);
    return 0;
  }
  if (down[x] > 0) 
    update (x, l, r);
  int s = (l + r) / 2;
  add (x * 2, l, s, lc, rc);
  add (x * 2 + 1, s + 1, r, lc, rc);
  if (down[x * 2] % k) update (x * 2, l, s);
  if (down[x * 2 + 1] % k) update (x * 2 + 1, s + 1, r);
  for (int i = 0; i < k; i++) tree[x][i] = tree[x * 2][i] + tree[x * 2 + 1][i];
//    printf ("%d %d\n", l, r);
//    for (int i = 0; i < k; i++) printf ("%d: %d\n", i, tree[x][i]);
}

int get (int x, int l, int r, int lc, int rc) {
  if (r < lc || l > rc) return 0;
  if (down[x] > 0) 
    update (x, l, r);
  if (l >= lc && r <= rc) {
    int tmp = 0;
    for (int i = 1; i < k; i++) tmp += i * tree[x][i];
    return tmp;
  }
  int s = (l + r) / 2;
  int tmp = get (x * 2, l, s, lc, rc) + get (x * 2 + 1, s + 1, r, lc, rc);
  return tmp;
}

int main () {
  freopen ("sum.in", "rt", stdin);
  freopen ("sum.out", "wt", stdout);
  scanf ("%d%d%d", &n, &k, &m);
  memset (tree, 0, sizeof (tree));
  int nn = n;
  while (nn & (nn - 1)) nn++;
  init (1, 1, nn);
  for (int i = 0; i < m; i++) {
    int a, b, c;
    scanf ("%d%d%d", &a, &b, &c);
    if (a == 1) {
//      printf ("add: %d %d\n", b, c);
      add (1, 1, nn, b, c);
    } else {
      printf ("%d\n", get (1, 1, nn, b, c));
    }
  }
}