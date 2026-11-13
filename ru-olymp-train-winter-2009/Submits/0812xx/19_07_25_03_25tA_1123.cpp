#include <cstdio>
#include <vector>
#include <algorithm>
#include <cmath>
#include <cstring>
#include <iostream>

using namespace std;

#define taskname "palin"

char s[3001000];
int use[3001000];
int x[3001000];
int tt;


int main () {
  freopen (taskname".in", "rt", stdin);
  freopen (taskname".out", "wt", stdout);
  cin >> s;
  int n = 0;
  while (s[n]) n++;
  int ok = 1;
  for (int i = 0; n - i - 1 > i; i++)
    if (s[i] != s[n - i - 1]) ok = 0;
  if (ok) {
    printf ("1\n");
    printf ("%s\n", s);
    return 0;
  }
  int r = 1;
  x[0] = -1;
  for (int i = 0; i < n; i++)
    if (s[i] == '1') {
      r++;
      x[r] = i;
    }
  x[r] = n;
  int ans = 0;
  int a = 1;
  int b = n - 1;
  while (a < b) {
    int tmp = 0;
    if (x[a] - x[a - 1] > x[b + 1] - x[b]) {      
      tmp = (x[a] - x[a - 1]) - (x[b + 1] - x[b]);
      for (int i = 1; i <= tmp; i++)
	use[x[a - 1] + i] = 1;
    }
    if (x[a] - x[a - 1] < x[b + 1] - x[b]) {      
      tmp = (x[b + 1] - x[b]) - (x[a] - x[a - 1]);
      for (int i = 1; i <= tmp; i++)
	use[x[b] + i] = 1;
    }
    ans += tmp;
    a++; b--;    
  }
  printf ("2\n");
  for (int i = 0; i < ans; i++)
    printf ("0");
  printf ("\n");
  for (int i = 0; i < n; i++)
    if (!use[i]) printf ("%c", s[i]);
}