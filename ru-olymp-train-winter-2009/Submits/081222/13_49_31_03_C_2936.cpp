#include <cstdio>
#include <cstring>
#include <iostream>

using namespace std;

char n[1000];
int a[1000], b[1000], c[1000], d[1000], ans[1000];

int print (int a[]) {
  for (int i = a[0]; i > 0; i--)
    printf ("%d", a[i]);
  printf ("\n");
  return 0;
}

int cpy (int* a, int* b) {
  for (int i = 0; i < 1000; i++)
    b[i] = a[i];  
  return 0;
}

int rotate (int* a) {
  int n = a[0];
  for (int i = 1; i < n - i + 1; i++) {
    int t = a[i];
    a[i] = a[n - i + 1];
    a[n - i + 1] = t;
  }
  return 0;
} 

int normalize (int* a) {
  int n = a[0];
  int r = 0; 
  for (int i = 1; i <= n; i++) {
    a[i] += r;
    r = 0;
    if (a[i] < 0) {
      a[i] += 10;
      r = -1;
    }
    if (a[i] > 9) {
      r = a[i] / 10;
      a[i] %= 10;
    }
  }
  while (r) {
    n++;
    a[n] = r % 10;
    r /= 10;
  }
  while (n > 1 && !a[n]) n--;
  a[0] = n;
  return 0;
}

int longnum (int x, int* b) {
  for (int i = 0; i < 1000; i++) b[i] = 0;
  b[0] = 1;
  b[1] = x;
  return 0;
}

int mul (int a[], int b[], int* d) {
  int c[1000];
  memset (c, 0, sizeof (c));
  c[0] = a[0] + b[0] - 1;
  for (int i = 1; i <= a[0]; i++)
    for (int j = 1; j <= b[0]; j++)
      c[i + j - 1] += a[i] * b[j];
  normalize (c);
  cpy (c, d);
  return 0;
}

int div (int a[], int x, int* b) {
  int c[1000];
  memset (c, 0, sizeof (c));
  c[0] = a[0];
  int tmp = 0;
  for (int i = a[0]; i > 0; i--) {
    tmp = tmp * 10 + a[i];
    c[i] = tmp / x;
    tmp %= x;
  }
  normalize (c);
  cpy (c, b);
  return 0;
}

int addshort (int* a, int b) {
  a[1] += b;
  normalize (a);
  return 0;
}

int add (int a[], int b[], int* c) {
  int d[1000];
  memset (d, 0, sizeof (d));
  d[0] = max (a[0], b[0]);
  for (int i = 1; i <= d[0]; i++) d[i] = a[i] + b[i];
  normalize (d);
  cpy (d, c);
  return 0;
}

int main () {
  freopen ("room.in", "rt", stdin);
  freopen ("room.out", "wt", stdout);
  cin >> n;
  int m = 0;
  while (n[m]) m++;
  for (int i = m; i > 0; i--) a[i] = n[i - 1] - '0';
  a[0] = m;
  rotate (a);
  int sum = 0;
  for (int i = 1; i <= a[0]; i++) sum = (sum + a[i]) % 3;
  longnum (2, b);
  mul (a, b, a);
  addshort (a, 1);
  div (a, 3, a);
  cpy (a, b);
  addshort (b, 1);
  mul (a, b, c);
  div (c, 2, c);

  int tmp = 0;
  if (sum == 1) tmp = -1;
  if (sum == 2) tmp = 1;
  addshort (a, tmp);
  div (a, 2, a);
  mul (a, a, d);
  add (c, d, ans);
  print (ans);
}
