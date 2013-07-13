#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "room"

#define BASE 10

typedef struct bigint {
  int len;
  char dig[1000];

  bigint() {len = 0;}
  bigint(int a) {
    len = 0;
    while (a) {
      dig[len++] = a % BASE;
      a /= BASE;
    }    
  }
  bigint operator=(int a) {    
    len = 0;
    while (a) {
      dig[len++] = a % BASE;
      a /= BASE;
    }
    return *this;
  }
} *pbigint;

void readbigint(pbigint n) {
  memset(n->dig, 0, sizeof n->dig);
  fgets(n->dig, sizeof n->dig, stdin);
  n->len = strlen(n->dig);
  while ((n->dig[n->len - 1] == 10) || (n->dig[n->len - 1] == 13))
    n->dig[--(n->len)] = 0;
  int noff = 0; while (n->dig[noff] == '0') if (++noff >= n->len) break;
  n->len -= noff;  
  for (int i = 0; i < n->len; i++) n->dig[i] = n->dig[i + noff];
  for (int i = 0; i < n->len; i++) n->dig[i] -= '0';
  
  int a = 0, b = n->len - 1;
  for (; a < b; a++, b--) {
    int t = n->dig[a];
    n->dig[a] = n->dig[b];
    n->dig[b] = t;
  }
}

void writebigint(pbigint n) {
  if (n->len) {
    for (int i = n->len - 1; i >= 0; i--)
      printf("%d", n->dig[i] % 10);
  } else 
    printf("0");
  printf("\n");
}

bigint operator+(bigint a, bigint b) {
  pbigint n = (pbigint)malloc(sizeof(bigint));
  
  n->len = max(a.len, b.len);
  int c = 0;
  for (int i = 0; i < n->len; i++) {
    if (a.len <= i) a.dig[i] = 0;
    if (b.len <= i) b.dig[i] = 0;
    
    n->dig[i] = a.dig[i] + b.dig[i] + c;
    c = n->dig[i] / BASE;
    n->dig[i] %= BASE;
  }
  while (c > 0) n->dig[n->len++] = c, c /= 10;
  while (!(n->dig[n->len - 1])) {
    n->len--;
    if (!n->len) break;
  }  
  return *n;
}

bigint operator*(bigint a, int b) {
  pbigint n = (pbigint)malloc(sizeof(bigint));
  
  n->len = a.len;
  int c = 0;
  for (int i = 0; i < n->len; i++) {
    if (a.len <= i) a.dig[i] = 0;
    
    n->dig[i] = a.dig[i] * b + c;
    c = n->dig[i] / BASE;
    n->dig[i] %= BASE;
  }
  while (c > 0) n->dig[n->len++] = c, c /= 10;
  while (!(n->dig[n->len - 1])) {
    n->len--;
    if (!n->len) break;
  }  
  return *n;
}

bigint pow10(bigint a, int b) {
  pbigint res = (pbigint)malloc(sizeof(bigint));
  res->len = a.len + b;
  for (int i = 0; i < b; i++) res->dig[i] = 0;
  for (int i = 0; i < a.len; i++)
    res->dig[i + b] = a.dig[i];
  return *res;
}

bigint operator*(bigint a, bigint b) {
  pbigint res = (pbigint)malloc(sizeof(bigint));
  res->len = 0;
  for (int i = 0; i < b.len; i++)
    *res = *res + pow10(a * b.dig[i], i);
  return *res;
}

bigint div3(bigint a) {
  pbigint res = (pbigint)malloc(sizeof(bigint));
  res->len = 0;
  if (!a.len) return *res;
  res->len = a.len;
  
  int c = 0;
  if (a.dig[a.len - 1] > 2) res->len = a.len;
  else {res->len = a.len - 1; c = a.dig[a.len - 1];}
  for (int i = res->len - 1; i >= 0; i--) {
    res->dig[i] = c * 10 + a.dig[i];
    c = res->dig[i] % 3;
    res->dig[i] /= 3;
  }
  return *res;
}

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

  bigint n;
  readbigint(&n);
  bigint x = div3(n * n + n + bigint(1));
  writebigint(&x);
  return 0;
}