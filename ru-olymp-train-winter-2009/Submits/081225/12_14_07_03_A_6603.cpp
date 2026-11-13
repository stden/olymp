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
  int ans = 0;
  string atmp = "";
  for (int i = 0; i < n; i++)
    if (s[i] == '0') ans++; else atmp += s[i];
  memset (use, 0, sizeof (use));
  for (int i = 0; i < n; i++) {
    tt++;
    int l = i;
    int r = i;
    while (l >= 0 && r < n) {
      int tr = r;
      if (s[l] == '0' && s[tr] == '1') use[l] = tt; else r++;
      if (s[l] == '1' && s[tr] == '0') use[tr] = tt; else l--;
    }
    int ok = 1;
    for (int j = 0; j < n; j++)
      if ((j <= l || j >= r)) {
	if (s[j] == '1') ok = 0; else use[j] = tt;
      }
    if (ok) {
      int cur = 0;
      string tmp = "";
      for (int j = 0; j < n; j++)
	if (use[j] == tt) cur++; else tmp += s[j];
      if (cur < ans || cur == ans && tmp < atmp) {
	ans = cur;
	atmp = tmp;
      }
    }
    tt++;
    l = i;
    r = i + 1;
    while (l >= 0 && r < n) {
      int tr = r;
      if (s[l] == '0' && s[tr] == '1') use[l] = tt; else r++;
      if (s[l] == '1' && s[tr] == '0') use[tr] = tt; else l--;
    }
    ok = 1;
    for (int j = 0; j < n; j++)
      if ((j <= l || j >= r)) {
	if (s[j] == '1') ok = 0; else use[j] = tt;
      }
    if (ok) {
      int cur = 0;
      string tmp = "";
      for (int j = 0; j < n; j++)
	if (use[j] == tt) cur++; else tmp += s[j];
      if (cur < ans || cur == ans && tmp < atmp) {
	ans = cur;
	atmp = tmp;
      }
    }
  }
  printf ("2\n");
  for (int i = 0; i < ans; i++)
    printf ("0");
  printf ("\n");
  cout << atmp << endl;
}