#include <assert.h>
#include <stdio.h>

#define MAXN 50
#define MAXC 10000
#define MAXL 100
#define BASE 1000000000

int L, A[MAXL+1], M, P[MAXM], Q[MAXM];
int SH, S[MAXM*(MAXN+1)], RH, R[MAXM*(MAXL+1)];
int XL, X[MAXN+1], YL, Y[MAXN+1], N;

void rec (int k, int b) {
  int i;
  if (b > X[k]) b = X[k];
  Y[k] = 0;
  assert (M < MAXC);
  P[M++] = SH;  S[SH++] = k;
  for (i = 0; i < k; i++) S[SH++] = Y[i];
  for (i = 1; i <= b; i++) {
    Y[k] = i;
    rec (k+1, i);
  }
}

int main (void) {
  int i, v;
  assert (freopen ("young.in", "rt", stdin));
  assert (freopen ("young.out", "wt", stdout));
  assert (scanf ("%d", &XL) == 1);
  assert (XL > 0 && XL <= MAXN);
  N = 0;
  for (i = 0; i < XL; i++) {
    assert (scanf ("%d", &v) == 1);
    assert (v > 0 && v <= MAXN);
    N += X[i] = v;
  }
  X[i] = 0;
  assert (N <= MAXN);
  M = 0;
  rec (0, N);
  printf ("(M=%d)\n", M);

  /* .... */

  return 0;
}
