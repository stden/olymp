#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "linear"
typedef long long nint;
typedef long double qel;

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
	//fprnintf(stderr, "%d = %d/%d\n", x, table[i][i2].a, table[i][i2].b);
      }
    for (int i = 1; i < n; i++) {
      for (int i2 = 0; i2 < i; i2++) {
	if (table[i][i2] == 0) continue;
	
	for (int line = 0; line < n; line++) {
	  if (i == line) continue;
	  if (table[line][i2] == 0) continue;
	  bool good = true;
	  for (int i3 = 0; i3 < i2; i3++)
	    if (table[line][i3] != 0) good = false;	      
	  if (good) {
	    qel m = table[i][i2] / table[line][i2];	  
	    for (int i3 = 0; i3 <= n; i3++)
	      table[i][i3] = table[i][i3] - table[line][i3] * m;	
	  }
	}
      }      
    }
    
    /*for (int i = 0; i < n; i++) {      
      for (int i2 = 0; i2 <= n; i2++) 
	printf(" %.0lf", table[i][i2].val());
      printf("||\n");
    }*/

    qel x[20]; nint type[20];    
    memset(type, 0, sizeof type);
    for (nint tmp = 0; tmp < n; tmp++) {
      for (nint line = n - 1; line >= 0; line--) {
	nint lastx = -1;
	qel right = table[line][n];
	for (int i = 0; i < n; i++) {
	  if (table[line][i] != 0)
	    switch (type[i]) {
	      case 0:
		if (lastx == -1) {lastx = i;}
		else lastx = -2;
		break;
	      case 1:
		right = right - table[line][i] * x[i];		
		break;
	    }	
	}
	if (lastx >= 0) {
	  type[lastx] = 1;
	  x[lastx] = right / table[line][lastx];
	} else if (lastx == -1) {
	  if (right != 0) {
	    printf("impossible\n");
	    /*for (int i = 0; i < n; i++)
	      printf("%lf ", type[i] ? x[i].val() : 666);*/
	    goto next;
	  }
	}
      }
    }    
    for (int i = 0; i < n; i++)
      if (!type[i]) {printf("infinity\n"); goto next;}
    printf("single\n%.4lf", (double)x[0]);
    for (int i = 1; i < n; i++)
      printf(" %.4lf", (double)x[i]);
    printf("\n");
    
    next:
    int i = 0;
  }
  
  return 0;
}