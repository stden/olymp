#include <algorithm>
#include <cstdio>
#include <cmath>

using namespace std;

#define eps 1e-9

int main( void )
{
  freopen("interseg.in", "rt", stdin);
  freopen("interseg.out", "wt", stdout);

  double AX1, AX2, AY1, AY2, BX1, BX2, BY1, BY2;
  scanf("%lf%lf%lf%lf", &AX1, &AY1, &AX2, &AY2);
  scanf("%lf%lf%lf%lf", &BX1, &BY1, &BX2, &BY2);
  double A1 = AY1 - AY2;
  double B1 = AX2 - AX1;
  double C1 = -(A1 * AX1 + B1 * AY1);
  double A2 = BY1 - BY2;
  double B2 = BX2 - BX1;
  double C2 = -(A2 * BX1 + B2 * BY1);
  double D = A1 * B2 - B1 * A2;
  if (fabs(D) > eps)
  {
    double IX =  (B1 * C2 - C1 * B2) / D;
    double IY = -(A1 * C2 - C1 * A2) / D;
    if (IX >= min(AX1, AX2) - eps && IY >= min(AY1, AY2) - eps &&
        IX <= max(AX1, AX2) + eps && IY <= max(AY1, AY2) + eps &&
        IX >= min(BX1, BX2) - eps && IY >= min(BY1, BY2) - eps &&
        IX <= max(BX1, BX2) + eps && IY <= max(BY1, BY2) + eps)
      printf("%.6lf %.6lf\n", IX, IY);
    else
      printf("Empty\n");
    return 0;
  }

  if (fabs(B1 * C2 - C1 * B2) > eps)
  {
    printf("Empty\n");
    return 0;
  }

  double IX1 = max(min(AX1, AX2), min(BX1, BX2));
  double IY1 = max(min(AY1, AY2), min(BY1, BY2));
  double IX2 = min(max(AX1, AX2), max(BX1, BX2));
  double IY2 = min(max(AY1, AY2), max(BY1, BY2));

  if (IX1 < IX2 - eps || IY1 < IY2 - eps)
  {
    if (A1 * B1 > eps)
      swap(IY1, IY2);
    if (IX1 > IX2 + eps || (fabs(IX1 - IX2) < eps && IY1 > IY2 + eps))
    {
      swap(IX1, IX2);
      swap(IY1, IY2);
    }
    printf("%.6lf %.6lf %.6lf %.6lf\n", IX1, IY1, IX2, IY2);
  }
  else if (IX1 <= IX2 + eps || IY1 <= IY2 + eps)
    printf("%.6lf %.6lf\n", IX1, IY1);
  else
    printf("Empty\n");

  return 0;
}
