#include <algorithm>
#include <cmath>
#include <cstdio>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

#define eps 1e-9

int main( void )
{
  freopen("triangle.in", "rt", stdin);
  freopen("triangle.out", "wt", stdout);

  double AX1, AX2, AX3, AY1, AY2, AY3, BX1, BX2, BX3, BY1, BY2, BY3;
  scanf("%lf%lf%lf%lf%lf%lf", &AX1, &AY1, &AX2, &AY2, &AX3, &AY3);
  scanf("%lf%lf%lf%lf%lf%lf", &BX1, &BY1, &BX2, &BY2, &BX3, &BY3);

  double a, b, c;
  vector <double> A(0), B(0), C(0), X(0), Y(0), RX(0), RY(0);

  a = AY1 - AY2;
  b = AX2 - AX1;
  c = -(a * AX1 + b * AY1);
  if (a * AX3 + b * AY3 + c < 0)
    a = -a, b = -b, c = -c;
  A.PB(a), B.PB(b), C.PB(c);
  a = AY2 - AY3;
  b = AX3 - AX2;
  c = -(a * AX2 + b * AY2);
  if (a * AX1 + b * AY1 + c < 0)
    a = -a, b = -b, c = -c;
  A.PB(a), B.PB(b), C.PB(c);
  a = AY3 - AY1;
  b = AX1 - AX3;
  c = -(a * AX3 + b * AY3);
  if (a * AX2 + b * AY2 + c < 0)
    a = -a, b = -b, c = -c;
  A.PB(a), B.PB(b), C.PB(c);
  a = BY1 - BY2;
  b = BX2 - BX1;
  c = -(a * BX1 + b * BY1);
  if (a * BX3 + b * BY3 + c < 0)
    a = -a, b = -b, c = -c;
  A.PB(a), B.PB(b), C.PB(c);
  a = BY2 - BY3;
  b = BX3 - BX2;
  c = -(a * BX2 + b * BY2);
  if (a * BX1 + b * BY1 + c < 0)
    a = -a, b = -b, c = -c;
  A.PB(a), B.PB(b), C.PB(c);
  a = BY3 - BY1;
  b = BX1 - BX3;
  c = -(a * BX3 + b * BY3);
  if (a * BX2 + b * BY2 + c < 0)
    a = -a, b = -b, c = -c;
  A.PB(a), B.PB(b), C.PB(c);

  vector <pair <double, double> > T(0);
  T.PB(MP(AX1, AY1)), T.PB(MP(AX2, AY2)), T.PB(MP(AX3, AY3));
  T.PB(MP(BX1, BY1)), T.PB(MP(BX2, BY2)), T.PB(MP(BX3, BY3));

  int N = A.size();
  for (int i = 0; i < N; i++)
    for (int j = i + 1; j < N; j++)
    {
      double D = A[i] * B[j] - A[j] * B[i];
      if (fabs(D) < eps)
        continue;
      double x = -(C[i] * B[j] - C[j] * B[i]) / D;
      double y = -(A[i] * C[j] - A[j] * C[i]) / D;
      int f = 1;
      for (int k = 0; k < N && f; k++)
        if (x * A[k] + y * B[k] + C[k] < -eps)
          f = 0;
      if (f)
        X.PB(x), Y.PB(y);
    }

  for (int i = 0; i < T.size(); i++)
  {
    double x = T[i].FI, y = T[i].SE;
    int f = 1;
    for (int k = 0; k < N && f; k++)
      if (x * A[k] + y * B[k] + C[k] < -eps)
        f = 0;
    if (f)
      X.PB(x), Y.PB(y);
  }

  N = 0;

  for (int i = 0; i < X.size(); i++)
  {
    int f = 1;
    for (int j = 0; j < N && f; j++)
      if (fabs(RX[j] - X[i]) < 100 * eps && fabs(RY[j] - Y[i]) < 100 * eps)
        f = 0;
    if (f)
      N++, RX.PB(X[i]), RY.PB(Y[i]);
  }

/*
  for (int i = 0; i < N; i++)
    fprintf(stderr, "(%.2lf, %.2lf)\n", RX[i], RY[i]);
*/

  double Ans = 0;
  if (N)
  {
    vector <int> P(N + 1);
    for (int i = 0; i < N; i++)
      P[i] = i;
    do
    {
      double Res = 0;
      for (int i = 0; i < N; i++)
        Res += RX[P[i]] * RY[P[(i + 1) % N]] - RX[P[(i + 1) % N]] * RY[P[i]];
      Ans = max(Ans, Res / 2);
    } while (next_permutation(P.begin(), P.end()));
  }

  fprintf(stderr, "Ans = %.2lf\n", Ans);
///*
  fprintf(stderr, "S1 = %.2f\n", fabs(AX1 * AY2 - AX2 * AY1 + AX2 * AY3 - AX3 * AY2 + AX3 * AY1 - AX1 * AY3) / 2);
  fprintf(stderr, "S2 = %.2f\n", fabs(BX1 * BY2 - BX2 * BY1 + BX2 * BY3 - BX3 * BY2 + BX3 * BY1 - BX1 * BY3) / 2);
//*/

  Ans = fabs(AX1 * AY2 - AX2 * AY1 + AX2 * AY3 - AX3 * AY2 + AX3 * AY1 - AX1 * AY3) / 2
      + fabs(BX1 * BY2 - BX2 * BY1 + BX2 * BY3 - BX3 * BY2 + BX3 * BY1 - BX1 * BY3) / 2 - Ans;

  printf("%.3lf\n", Ans);

  return 0;
}
