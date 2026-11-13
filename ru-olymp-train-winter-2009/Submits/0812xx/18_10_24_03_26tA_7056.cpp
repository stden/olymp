#include <cstdio>
#include <cstring>

using namespace std;

const int pat[2][8] = {{5, 0, 0, 1, 0, 1, 0, 0}, {7, 0, 0, 1, 0, 1, 0, 1}};

long long cnt[2][3][20];

int get (int p, int x, int l) {
  int sum = 0;
  while (1) {
//    printf ("%d %d %d %d\n", p, x, l, sum);
    if (x == 0) break;
    if (l == -1) { sum += p + 1; break; }
    int m = pat[p][0];
    for (int i = 1; i <= m; i++) {
      int j = pat[p][i];
      if (x > cnt[j][2][l]) {
	sum += cnt[j][0][l] + 2 * cnt[j][1][l];
	x -= cnt[j][2][l];
      } else {
	l--;
	p = j;
	break;
      }
    }
  }
  return sum;
}

int calc (int x) {
  if (x == 0) return 0;
  int ii = 0;
//  printf ("%d\n", cnt[0][2][0]);
  for (int i = 0; i < 20; i++)
    if (cnt[0][2][i] < x && cnt[0][2][i + 1] >= x) {
      ii = i;
      break;
    }
  return get (0, x, ii);
} 

int main () {
  freopen ("digitsum.in", "rt", stdin);
  freopen ("digitsum.out", "wt", stdout);
  memset (cnt, 0, sizeof (cnt));
  cnt[0][0][0] = cnt[0][2][0] = cnt[1][1][0] = cnt[1][2][0] = 1;
  for (int i = 1; i < 15; i++)
    for (int j = 0; j < 3; j++) {
      cnt[0][j][i] = 3 * cnt[0][j][i - 1] + 2 * cnt[1][j][i - 1];
      cnt[1][j][i] = 4 * cnt[0][j][i - 1] + 3 * cnt[1][j][i - 1];
    }
  int tt;
  scanf ("%d", &tt);
  for (int it = 0; it < tt; it++) {
    int a, b;
    scanf ("%d%d", &a, &b);
    printf ("%d\n", calc (b) - calc (a - 1));
  }
}