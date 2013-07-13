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
  
  n->len = max(a.len, b.len); n->sign = 1;
  int c = 0;
  for (int i = 0; i < n->len; i++) {
    if (a.len <= i) a.dig[i] = 0;
    if (b.len <= i) b.dig[i] = 0;
    
    //printf("%d: %d + %d + %d = ", i, a.dig[i] * a.sign, b.dig[i] * b.sign, c);
    n->dig[i] = a.dig[i] * a.sign + b.dig[i] * b.sign + c;
    c = n->dig[i] / BASE;
    n->dig[i] %= BASE;
    
    if (n->dig[i] < 0) {n->dig[i] += BASE; c--;}
    //printf("%d (%d)\n", n->dig[i], c);
  }
  if (c > 0) n->dig[n->len++] = c;
  //printf("%d\n", c);
  if (c < 0) {
    for (int i  = 0; i < n->len; i++)
      n->dig[i] = BASE - 1 - n->dig[i];
    n->dig[0]++; n->sign = -1;
  };
  while (!(n->dig[n->len - 1])) {
    n->len--;
    if (!n->len) break;
  }
  
  return *n;
}
bigint operator-(bigint a, bigint b) {b.sign = -b.sign; return a + b;}

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

  bigint a, b;
  readbigint(&a);
  readbigint(&b);
  bigint s = a - b;
  /*bigint s2 = s + b;
  if ((s2 < a) || (s2 > a))
    printf("Oops...\n");*/
  writebigint(&s);
  /*writebigint(&s2); printf("%d\n", s2.dig[s2.len - 1]);
  writebigint(&a); printf("%d\n", a.dig[a.len - 1]);*/
  return 0;
}