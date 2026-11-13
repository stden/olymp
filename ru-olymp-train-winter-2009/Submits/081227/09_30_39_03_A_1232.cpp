#include <cstdio>
#include <vector>
#include <algorithm>
#include <set>
#include <iostream>
#include <cmath>

using namespace std;

#define ll long long
#define ld long double
#define mp make_pair
#define pb push_back
#define vi vector<int>

#define taskname "help"

string ss;
char s[1000000];

int main () {
  freopen (taskname".in", "rt", stdin);
  freopen (taskname".out", "w t", stdout);
  cin >> s;
  if (s[0] == '/' && s[1] == '/' || s[0] == '/' && s[1] == '*' || s[0] == '{') {
    printf ("YES\n");
    return 0;
  }
  int s1 = 0, s2 = 0, o1 = 0, o2 = 0, p1 = 0, p2 = 0;
  while (cin >> s) {    
    if (!s[0]) break;
//    int cur = 0;
//    while 
    int ok;
    ok = 0;
//    printf ("%s\n", s);
    if (s[0] == '(') s1++;else {
      for (int i = 0; s[i]; i++)
	if (s[i] == '(') ok = 1;
      s2 += ok;
    }
    ok = 0;
    if (s[0] == ':' && s[1] == '=') o1++;else {
      for (int i = 0; s[i + 1]; i++)
	if (s[i] == ':' && s[i + 1] == '=') ok = 1; 
      o2 += ok;
    }
    int n = 0;
    while (s[n]) n++;
    if (s[n - 1] == ':') p1;
    if (!ok) {
      ok = 0;
      for (int i = 0; s[i]; i++)
	if (s[i] == ':') ok = 1;
      p2 += ok;
    }
  }
//  fclose (stdin);
//  freopen (taskname".in", "rt", stderr);
/*  vi ots;
  while (gets (s)) {    
    if (!s[0]) continue;
    int n;
    while (s[n] == ' ') n++;
    if (s[n]) ots.pb (n);
  }
  sort (ots.begin (), ots.end ());*/
  int ok = 1;
/*  for (int i = 0; i < ots.size (); i++)
    if (ots[i] % ots[0] != 0) ok = 0; else ots[i] = ots[i] / ots[0];
  for (int i = 0; i + 1 < ots.size (); i++)
    if (ots[i + 1] != ots[i] || ots[i + 1] != ots[i] + 1) ok = 0;*/
  if (s1 >= 3 & s2 >= 3) ok = 0;
  if (o1 >= 3 & o2 >= 3) ok = 0;
  if (p1 >= 3 & p2 >= 3) ok = 0;
  if (ok) printf ("YES\n"); else printf ("NO");  
}
