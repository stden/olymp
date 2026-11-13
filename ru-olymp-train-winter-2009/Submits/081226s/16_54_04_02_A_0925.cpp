#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "linear"

struct qel {
  int a, b;
  qel() {a = 0; b = 1;}
  qel(const int& x) {
    a = x; b = 1;
  }  
  void normalize() {
    if (b < 0) {a = -a; b = -b;}
    if (a == 0) {b = 1;}
  }
  double val() {return (double)a / (double)b;}
};
int D(int a, int b) {
  a = abs(a); b = abs(b);
  while (1) {
    if (!a) return b;
    if (!b) return a;
    if (!(a - 1) || !(b - 1)) return 1;
    if (a > b) a %= b; else b %= a;
  }
}
int K(int a, int b) {
  return abs(a) / D(a, b) * abs(b);
}
qel operator+(qel a, qel b) {
  qel res;
  res.b = K(a.b, b.b);
  res.a = (a.a * b.b + a.b * b.a) / D(a.b, b.b);
  return res;
}
qel operator*(qel a, qel b) {
  qel res;
  res.a = a.a * b.a;
  res.b = a.b * b.b;
  int gcd = D(res.a, res.b);
  res.a /= gcd; res.b /= gcd;
  res.normalize();
  return res;
}
qel operator/(qel a, qel b) {
  qel b2; b2.a = b.b; b2.b = b.a;
  if (b2.b < 0) {b2.a = -b2.a; b2.b = -b2.b;}
  qel res = a * b2; res.normalize();
  return res;
}
qel operator-(qel a, qel b) {
  b.a = -b.a;
  return a + b;
}
bool operator==(qel a, qel b) {
  a.normalize(); b.normalize();
  return (a.a == b.a) && (a.b == b.b);
}
bool operator!=(qel a, qel b) {
  a.normalize(); b.normalize();
  return (a.a != b.a) || (a.b != b.b);
}
bool operator<(qel a, qel b) {
  a.normalize(); b.normalize();
  return (a.a * b.b) < (b.a * a.b);
}
bool operator>(qel a, qel b) {
  a.normalize(); b.normalize();
  return (a.a * b.b) > (b.a * a.b);
}

qel table[20][21];

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  int n;
  while (scanf("%d", &n) != EOF) {
    for (int i = 0; i < n; i++)
      for (int i2 = 0; i2 <= n; i2++) {
	int x; scanf("%d", &x);
	table[i][i2] = x;	
	//fprintf(stderr, "%d = %d/%d\n", x, table[i][i2].a, table[i][i2].b);
      }
    for (int i = 1; i < n; i++) {
      for (int i2 = 0; i2 < i; i2++) {
	if (table[i][i2] == 0) continue;
	
	for (int line = 0; line < n; line++) {
	  if (table[line][i2] == 0) continue;
	  qel m = table[i][i2] / table[line][i2];	  
	  for (int i3 = 0; i3 <= n; i3++)
	    table[i][i3] = table[i][i3] - table[line][i3] * m;	
	}
      }      
    }
    
    /*for (int i = 0; i < n; i++) {      
      for (int i2 = 0; i2 <= n; i2++) 
	printf(" %.3lf", table[i][i2].val());
      printf("\n");
    }*/

    qel x[20]; int type[20];    
    memset(type, 0, sizeof type);
    for (int tmp = 0; tmp < n; tmp++) {
      for (int line = 0; line < n; line++) {
	int lastx = -1;
	qel right = table[line][n];
	for (int i = 0; i < n; i++) {
	  if (table[line][i] != 0)
	    switch (type[i]) {
	      case 0:
		if (lastx < 0) {lastx = i;}
		else {lastx = -2; break;}
		break;
	      case 1:
		right = right - table[line][i] * x[i];		
		break;
	    }	
	}
	//printf("%d: %d; %.3lf\n", line, lastx, right.val());
	if (lastx >= 0) {
	  type[lastx] = 1;
	  //fprintf(stderr, "x[%d] = %.3lf / %.3lf = ", lastx, right.val(), table[line][lastx].val());
	  x[lastx] = right / table[line][lastx];
	  //fprintf(stderr, "%.3lf\n", x[lastx].val());
	}
	if (lastx == -1)
	  if (right != 0) {
	    printf("impossible\n");
	    goto next;
	  }
      }
    }    
    for (int i = 0; i < n; i++)
      if (!type[i]) {printf("infinity\n"); goto next;}
    printf("single\n%.3lf", x[0].val());
    for (int i = 1; i < n; i++)
      printf(" %.3lf", x[i].val());
    printf("\n");
    
    next:
    int i = 0;
  }
  
  return 0;
}