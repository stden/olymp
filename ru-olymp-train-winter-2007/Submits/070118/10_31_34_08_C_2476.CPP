#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstring>

using namespace std;

#define eps 1e-9

void CalcPrefix( char *S, int *P)
{
  P[0] = 0;
  int L = strlen(S);
  for (int i = 1; i < L; i++)
  {
    P[i] = P[i - 1];
    while (P[i] != 0 && S[P[i]] != S[i])
      P[i] = P[P[i] - 1];
    if (S[P[i]] == S[i])
      P[i]++;
  }
}

#define maxl 310

char S[maxl], T[maxl + maxl];
int P[maxl + maxl];
double A[maxl][maxl], R[maxl];

int main( void )
{
  freopen("wordgame.in", "rt", stdin);
  freopen("wordgame.out", "wt", stdout);

  int K, N;
  scanf("%d%d", &K, &N);
  scanf("%s", S);
  int L = strlen(S);

  memset(A, 0, sizeof(A));
  for (int i = 0; i < L; i++)
    A[i][i] = 1.0;
  memset(R, 0, sizeof(R));
  for (int i = 0; i < L; i++)
    for (int j = 0; j < K; j++)
    {
      int Len = 0;
      for (int k = 0; k < L; k++)
        T[Len++] = S[k];
      T[Len++] = '$';
      for (int k = 0; k < i; k++)
        T[Len++] = S[k];
      T[Len++] = j + 'a';
      T[Len] = 0;
      CalcPrefix(T, P);
      int Target = P[Len - 1];
//      fprintf(stderr, "i = %d, j = %c, Target = %d\n", i, j + 'a', Target);
      if (Target < L)
      {
        A[Target][i] -= 1.0 / K;
        R[i] += 1.0 / K;
      }  
    }
  R[L - 1] += 1.0 / K;

/*
  for (int i = 0; i < L; i++)
  {
    fprintf(stderr, "|");
    for (int j = 0; j < L; j++)
      fprintf(stderr, "%6.2lf ", A[j][i]);
    fprintf(stderr, "| = %.2lf\n", R[i]);
  }
  fprintf(stderr, "\n");
*/

  for (int i = 0; i < L; i++)  
  {
    int k = -1;
    for (int j = i; j < L && k == -1; j++)
      if (fabs(A[i][j]) > eps)
        k = j;
    if (k == -1)
    {
      fprintf(stderr, "Все упало=(\n");
      return 666;
    }
    for (int j = 0; j < L; j++)
      swap(A[j][i], A[j][k]);
    swap(R[i], R[k]);
    double D = 1 / A[i][i];
    for (int j = 0; j < L; j++)
      A[j][i] *= D;
    R[i] *= D;

/*
    for (int ii = 0; ii < L; ii++)
    {
      fprintf(stderr, "|");
      for (int jj = 0; jj < L; jj++)
        fprintf(stderr, "%6.2lf ", A[jj][ii]);
      fprintf(stderr, "| = %.2lf\n", R[ii]);
    }
    fprintf(stderr, "\n");
*/

    for (int j = 0; j < L; j++)
      if (j != i && fabs(A[i][j]) > eps)
      {
        double C = A[i][j];
        for (int k = 0; k < L; k++)
          A[k][j] -= A[k][i] * C;
        R[j] -= R[i] * C;
      }

/*
    for (int ii = 0; ii < L; ii++)
    {
      fprintf(stderr, "|");
      for (int jj = 0; jj < L; jj++)
        fprintf(stderr, "%6.2lf ", A[jj][ii]);
      fprintf(stderr, "| = %.2lf\n", R[ii]);
    }
    fprintf(stderr, "\n");
*/
  }

/*
  for (int i = 0; i < L; i++)
    fprintf(stderr, "R[i = %d] = %.3lf\n", i, R[i]);
*/

  CalcPrefix(S, P);
  printf("%.6lf\n", R[0] + (N - 1) * R[P[L - 1]]);

  return 0;
}
