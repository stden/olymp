#include <cstdio>
#include <cmath>
#include <vector>

#define eps 1e-8

using namespace std;

int x[7], y[7];

int inside( double x, double y, int *xx, int *yy )
{
  double x1[3], y1[3];
  for (int i = 0; i < 3; i++)
    x1[i] = xx[i] - x, y1[i] = yy[i] - y;
  return (xx[0] * yy[1] - xx[1] * yy[0] < eps &&
          xx[1] * yy[2] - xx[2] * yy[1] < eps &&
          xx[2] * yy[0] - xx[0] * yy[2] < eps) ||
         (xx[0] * yy[1] - xx[1] * yy[0] > -eps &&
          xx[1] * yy[2] - xx[2] * yy[1] > -eps &&
          xx[2] * yy[0] - xx[0] * yy[2] > -eps);
}

double cprod( double x1, double y1, double x2, double y2 )
{
  return x1 * y2 - x2 * y1;
}

int main( void )
{
  freopen("triangle.in", "rt", stdin);
  freopen("triangle.out", "wt", stdout);
  for (int i = 0; i < 6; i++)
    scanf("%d%d", &x[i], &y[i]);
  vector <pair <double, double> > cu, cu1;
  for (int i = 0; i < 3; i++)
    if (inside(x[i], y[i], x + 3, y + 3))
      cu.push_back(make_pair(x[i] * 1.0, y[i] * 1.0));
  for (int i = 0; i < 3; i++)
    if (inside(x[3 + i], y[3 + i], x, y))
      cu.push_back(make_pair(x[3 + i] * 1.0, y[3 + i] * 1.0));
  for (int i = 0; i < 3; i++)
    for (int j = 0; j < 3; j++)
    {
      int a1, b1, c1, a2, b2, c2;
      a1 = y[i] - y[(i + 1) % 3], b1 = x[(i + 1) % 3] - x[i], c1 = -(a1 * x[i] + b1 * y[i]);
      a2 = y[3 + j] - y[3 + (j + 1) % 3], b2 = x[3 + (j + 1) % 3] - x[3 + j], c2 = -(a2 * x[3 + j] + b2 * y[3 + j]);
      if ((long long)a1 * b2 == (long long)b1 * a2)
        continue;
      double xx, yy;
      xx = (c2 * b1 - c1 * b2) / ((double)a1 * b2 - (double)a2 * b1);
      yy = (c1 * a2 - c2 * a1) / ((double)a1 * b2 - (double)a2 * b1);
      if (inside(xx, yy, x, y) && inside(xx, yy, x + 3, y + 3))
        cu.push_back(make_pair(xx, yy));
    }
  vector <int> u(cu.size(), 0);
  for (int i = 0; i < cu.size(); i++)
    for (int j = i + 1; j < cu.size(); j++)
      if (fabs(cu[i].first - cu[j].first) < eps && fabs(cu[i].second - cu[j].second) < eps)
        u[j] = 1;
  for (int i = 0; i < cu.size(); i++)
    if (!u[i])
      cu1.push_back(cu[i]);
  cu = cu1;
  vector <int> tt(cu.size());
  for (int i = 0; i < tt.size(); i++)
    tt[i] = i;
  double ans = fabs((double)(x[1] - x[0]) * (y[2] - y[0]) - (x[2] - x[0]) * (y[1] - y[0])) +
               fabs((double)(x[4] - x[3]) * (y[5] - y[3]) - (x[5] - x[3]) * (y[4] - y[3]));
  double s = 0;
  if (cu.size() > 2)
  {
    for (int i = 0; i < cu.size(); i++)
      fprintf(stderr, "%lf %lf\n", cu[i].first, cu[i].second);
    for (int i = 1; i < cu.size(); i++)
      cu[i].first -= cu[0].first, cu[i].second -= cu[0].second;
    for (int i = 0; i < cu.size(); i++)
      for (int j = 2; j < cu.size(); j++)
        if (cprod(cu[j].first, cu[j].second, cu[j - 1].first, cu[j - 1].second) < 0)
          swap(cu[j], cu[j - 1]);
    cu[0] = make_pair(0, 0);
    for (int i = 0; i < cu.size(); i++)
      s += cu[i].first * cu[(i + 1) % cu.size()].second - cu[i].second * cu[(i + 1) % cu.size()].first;
    s = fabs(s);
    fprintf(stderr, "s=%lf\n", s * 0.5);
  }
  ans -= s;
  printf("%.3lf", ans * 0.5);
  return 0;
}
