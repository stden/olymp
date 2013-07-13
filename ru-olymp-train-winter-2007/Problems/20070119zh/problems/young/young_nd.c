#include <assert.h>
#include <stdio.h>

#define MULTI 1
#define MAXN 50
#define MAXL 100
#define BASE 1000000

int L, A[MAXL+1];
int XL, X[MAXN+1], N;
int PC, P[MAXN], V[MAXN];

void muld (int x, int k) {
  int i = 0;
  while (x > 1) {
    while (x % P[i]) i++;
    do { V[i] += k;  x /= P[i]; } while (!(x % P[i]));
  }
}

void muls (int x) {
  int c = 0, i, t;
  for (i = 0; i < L; i++) {
    t = c + A[i] * x;
    c = t / BASE;
    A[i] = t - c * BASE;
  }
  if (c) {
    assert (L < MAXL);
    A[L++] = c;
  }
} 

int main (void) {
  int i, j, k, p, v, q = 0;
  PC = 1;  P[0] = 2;
  for (p = 3; p <= MAXN; p += 2) {
    for (i = 2; i < p; i++)
      if (!(p % i)) break;
    if (i == p) P[PC++] = p;
  }
  assert (freopen ("young.in", "rt", stdin));
  assert (freopen ("young.out", "wt", stdout));
  do {
    i = scanf ("%d", &XL);
    if (i == EOF && q) break;
    q++;
    assert (i == 1);
    assert (XL > 0 && XL <= MAXN);
    N = 0;
    for (i = 0; i < XL; i++) {
      assert (scanf ("%d", &v) == 1);
      assert (v > 0 && v <= MAXN);
      assert (!i || v <= X[i-1]);
      N += X[i] = v;
    }
    X[i] = 0;
    assert (N <= MAXN);
    for (i = 0; i < PC; i++) V[i] = 0;
    for (i = 1; i <= N; i++) muld (i, 1);
    for (i = 0; i < XL; i++)
      for (j = 0; j < X[i]; j++) {
	for (k = i; j < X[k]; k++);
	muld ((X[i] - j) + (k - i) - 1, -1);
      }
    L = 1;  A[0] = 1;
    for (i = 0; i < PC; i++) {
      assert (V[i] >= 0);
      for (j = 0; j < V[i]; j++) muls (P[i]);
    }
    printf ("%d", A[L-1]);
    for (i = L - 2; i >= 0; i--) printf ("%06d", A[i]);
    printf ("\n");
  } while (MULTI);
  return 0;
}
