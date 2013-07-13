#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "aplusminusb"

#define BASE 10000
#define BASEPOW 4

typedef struct __bigint {
  int len; short sign;
  int dig[10000];
} bigint, *pbigint;

char buf[20000];
bool readbigint(bigint *n) {
  memset(buf, 0, sizeof buf);
  fgets(buf, sizeof buf, stdin);
  for (int i = strlen(buf) - 1; i >= 0; i--) {
    if ((buf[i] == 10) || (buf[i] == 13)) buf[i] = 0;
    break;
  }
  int l = strlen(buf);
  if (!l) return false;
  n->len = l / BASEPOW + !!(l % BASEPOW);
  n->sign = 1;
    
  int pos = 0;
  for (int i = l - 1; i >= 0; pos++) {
    n->dig[pos] = 0;
    for (int off = 1; off < BASE; off *= 10, i--)
      if (i >= 0) n->dig[pos] += (buf[i] - '0') * off;
  }
  return true;
}

void writebigint(bigint *n) {
  if (n->len) {
    if (n->sign < 0) printf("-");
    printf("%d", n->dig[n->len - 1]);
    for (int i = n->len - 2; i >= 0; i--) {
      printf("%d", (n->dig[i] / 1000) % 10);
      printf("%d", (n->dig[i] / 100) % 10);
      printf("%d", (n->dig[i] / 10) % 10);
      printf("%d", n->dig[i] % 10);
    }
  } else 
    printf("0");
  printf("\n");
}

bool operator>(bigint a, bigint b) {
  if (a.len > b.len) return true;
  if (a.len < b.len) return false;
  for (int i = 0; i < a.len; i++) {
    if (a.dig[i] > b.dig[i]) return true;
    if (a.dig[i] < b.dig[i]) return false;
  }
  return false;
}
bool operator<(bigint a, bigint b) {return b > a;}

bigint operator+(bigint a, bigint b) {
  pbigint n = (pbigint)malloc(sizeof(bigint));
  
  bool swapped = false;
  if (a < b) {
    a.sign = -a.sign;
    b.sign = -b.sign;
    swapped = true;
  }
  
  n->len = max(a.len, b.len);
  int c = 0;
  for (int i = 0; i < n->len; i++) {
    if (a.len <= i) a.dig[i] = 0;
    if (b.len <= i) b.dig[i] = 0;
    
    n->dig[i] = a.dig[i] * a.sign + b.dig[i] * b.sign + c;
    c = n->dig[i] / BASE;
    n->dig[i] %= BASE;
    if (n->dig[i] < 0) {n->dig[i] += BASE; c--;}
  }
  if (c > 0) n->dig[n->len++] = c;
  if (swapped) n->sign = -1; else n->sign = 1;
  while (!n->dig[n->len - 1] ) if (--n->len) break;
  
  return *n;
}
bigint operator-(bigint a, bigint b) {b.sign = -b.sign; return a + b;}

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

  bigint a, b;
  while (readbigint(&a)) {
    readbigint(&b);
    bigint s = a - b;
    writebigint(&s); printf("\n");
  }
  return 0;
}