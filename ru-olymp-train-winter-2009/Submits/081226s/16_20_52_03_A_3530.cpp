#include <cstdio>
#include <cmath>

using namespace std;

long double a[30][30], g[30][30];
long double c[30];
int p[30];

int main () {
  freopen ("linear.in", "rt", stdin);
  freopen ("linear.out", "wt", stdout);
  int n;
  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
    p[i] = i;
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n + 1; j++) {
      double tmp;
      scanf ("%lf", &tmp);
      a[i][j] = tmp;
    }
  for (int i = 0; i < n; i++) {
    int ii = i;
    int jj = i;
    
    for (int j = i; j < n; j++)
      for (int k = i; k < n; k++)
	if (abs (a[j][k]) > abs (a[ii][jj])) { ii = j; jj = k; }
    for (int j = 0; j < n + 1; j++) {
      long double tmp = a[i][j];
      a[i][j] = a[ii][j];
      a[ii][j] = tmp;
    }
    for (int j = 0; j < n; j++) {
      long double tmp = a[j][i];
      a[j][i] = a[j][jj];
      a[j][jj] = tmp;
    }
    int tmp = p[i];
    p[i] = p[jj];
    p[jj] = tmp;
    if (abs (a[i][i]) > 1e-7) {
      for (int j = i + 1; j < n; j++) {
	long double tmp = a[j][i] / a[i][i];
	for (int k = 0; k < n + 1; k++) 
	  a[j][k] -= a[i][k] * tmp;
      }
    }
  }
  for (int i = n - 1; i >= 0; i--) 
    if (abs (a[i][i]) > 1e-7)
      for (int j = i - 1; j >= 0; j--) {
	long double tmp = a[j][i] / a[i][i];
	for (int k = 0; k < n + 1; k++) 
	  a[j][k] -= a[i][k] * tmp;
      }
  int inf = 0;
  int no = 0;
  for (int i = 0; i < n; i++)
    if (abs (a[i][i]) < 1e-7) {
      if (abs(a[i][n]) < 1e-7) inf = 1; else no = 1;
    } else c[p[i]] = a[i][n] / a[i][i];
  if (no) printf ("impossible\n"); else
  if (inf) printf ("infinity\n"); else {
    printf ("single\n");
    for (int i = 0; i < n; i++) printf ("%.10f ", (double)c[i]);
    printf ("\n");
  }
}