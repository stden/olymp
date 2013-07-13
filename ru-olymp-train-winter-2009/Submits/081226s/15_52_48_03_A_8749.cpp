#include <cstdio>
#include <cmath>

using namespace std;

double a[30][30];
double c[30];

int main () {
  freopen ("linear.in", "rt", stdin);
  freopen ("linear.out", "wt", stdout);
  int n;
  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
    for (int j = 0; j < n + 1; j++)
      scanf ("%lf", &a[i][j]);
  for (int i = 0; i < n; i++) {
    int ok = 0;
    int ii = 0;
    for (int j = i; j < n; j++)
      if (abs (a[j][i]) > 1e-6 && (!ok || abs (a[j][i]) > abs (a[ii][i]))) {ok = 1; ii = j;}
    if (ok) {
      for (int j = 0; j < n + 1; j++) {
	double tmp = a[i][j];
	a[i][j] = a[ii][j];
	a[ii][j] = tmp;
      }
      for (int j = i + 1; j < n; j++) {
	double tmp = a[j][i] / a[i][i];
	for (int k = 0; k < n + 1; k++) 
	  a[j][k] -= a[i][k] * tmp;
      }
    }
  }
  for (int i = n - 1; i >= 0; i--) 
    if (abs (a[i][i]) > 1e-6)
      for (int j = i - 1; j >= 0; j--) {
	double tmp = a[j][i] / a[i][i];
	for (int k = 0; k < n + 1; k++) 
	  a[j][k] -= a[i][k] * tmp;
      }
  int inf = 0;
  int no = 0;
  for (int i = 0; i < n; i++)
    if (abs (a[i][i]) < 1e-6) {
      if (abs(a[i][n]) < 1e-6) inf = 1; else no = 1;
    } else c[i] = a[i][n] / a[i][i];
  if (no) printf ("impossible\n"); else
  if (inf) printf ("infinity\n"); else {
    printf ("single\n");
    for (int i = 0; i < n; i++) {
      if (abs (c[i]) < 1e-6) c[i] = abs (c[i]);
      printf ("%.10f ", c[i]);
    }
    printf ("\n");
  }
  
}