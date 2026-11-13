#include <cstdio>
#include <iostream>

using namespace std;

char s[20000];
int p[20000];
int n;

int can (int i) {
/*  int ok = 0;
  for (int j = 0; j + 1 < i; j++) {
    int k = p[j];
    while (k != -1 && s[k + 1] <= s[j + 1]) k = p[k];
    if (k != -1) return 0;
  }*/
//  printf ("cool\n");
  int cur = p[i - 1];
  for (int j = i; j < n; j++) {
    while (cur != -1 && s[cur + 1] != '1') cur = p[cur];
    if (s[cur + 1] == '1') cur++;
    if (cur == -1) break;
  }
  if (cur == -1) return 1;
  return 0;
}

int main () {
  freopen ("next.in", "rt", stdin);
  freopen ("next.out", "wt", stdout);
  cin >> s;
  n = 0;
  while (s[n]) n++;
  p[0] = -1;
  for (int i = 1; i < n; i++) {
    int k = p[i - 1];
    while (k != -1 && s[k + 1] != s[i]) k = p[k];
    if (s[k + 1] == s[i]) k++;
    p[i] = k;
  }
  int ii = 0;
  for (int i = n - 2; i > 0; i--) 
    if (s[i] == '0') {
//      printf ("%d %d\n", i, can (i));
      if (!can (i)) continue;
      ii = i;
      break;
    }  
//  printf ("%d\n", ii);
  for (int i = ii; i < n - 1; i++) {
    char min = '0';
    for (int j = p[i - 1]; j != -1; j = p[j])
      if (s[j + 1] > min) {
	min = s[j + 1];
	break;
      }
    if (i > ii && min == '0') {
      s[i] = '0';
      int k = p[i - 1];
      while (k != -1 && s[k + 1] != '0') k = p[k];
      if (s[k + 1] == '0') k++;
      p[i] = k;
//      printf ("check0 %d\n", i);
      if (can (i + 1)) continue;
    }
    s[i] = '1';
    int k = p[i - 1];
    while (k != -1 && s[k + 1] != '1') k = p[k];
    if (s[k + 1] == '1') k++;
    p[i] = k;
  }
  s[n - 1] = '1';
  cout << s << endl;
}
