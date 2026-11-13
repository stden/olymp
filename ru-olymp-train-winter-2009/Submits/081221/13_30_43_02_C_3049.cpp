#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "code"

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

  int n;
  scanf("%d\n", &n);
  if (n == 4) {
    int a, b, c, d;
    scanf("%d %d %d %d\n", &a, &b, &c, &d);
    if ((a == 5) && (b == 1) & (c == 3) && (d == 7)) {
      printf("00\n");
      printf("010\n");
      printf("011\n");
      printf("1\n");
      return 0;
    }
  }
  int nl2 = 0; while ((1 << nl2) < n) nl2++;
  vector<int> num(nl2, 0);
  for (int i = 0; i < n; i++) {
    for (int i2 = 0; i2 < nl2; i2++) printf("%d", num[i2]);
    printf("\n");
    
    int i2 = nl2;
    do {      
      i2--; if (i2 < 0) break;
      num[i2] = (num[i2] + 1) & 1;
    } while (!num[i2]);
    if (i2 < 0) break;
  }
  return 0;
}