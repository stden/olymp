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

char ss[1000000];
string s;
vi ots;

int out (string s) {
  cout << s << endl;
  return 0;
}

int main () {
  freopen (taskname".in", "rt", stdin);
  freopen (taskname".out", "wt", stdout);
//  cin >> s;
  if (s[0] == '/' && s[1] == '/' || s[0] == '/' && s[1] == '*' || s[0] == '{') {
    printf ("YES\n");
    return 0;
  }
  int s1 = 0, s2 = 0, o1 = 0, o2 = 0, p1 = 0, p2 = 0;
  int first = 1;
  
/*  while (gets (ss)) {    
    if (!ss[0]) continue;
  if (first > 0 && (s[0] == '/' && s[1] == '/' || s[0] == '/' && s[1] == '*' || s[0] == '{')) {
    printf ("YES\n");
    return 0;
  }
    first--;
    int j = 0;
    while (ss[j] == ' ') j++;
    if (j > 0 && ss[j]) ots.pb (j);
    j = 0;
    while (ss[j]) j++;
    ss[j] = ' ';
    j = 0;
    
    while (ss[j]) {
      if (ss[j] == ' ') {        
	int ok;
	ok = 0;
	if (s[0] == '(') s1++;else {
	  for (int i = 0; i < s.size (); i++)
	    if (s[i] == '(') ok = 1;
	s2 += ok;
      }
      ok = 0;
      if (s[0] == ':' && s[1] == '=') o1++;else {
	for (int i = 0; i + 1 < s.size (); i++)
	  if (s[i] == ':' && s[i + 1] == '=') ok = 1; 
	o2 += ok;
      }
      int n = 0;
      while (s[n]) n++;
      if (s[n - 1] == ':') p1;
      if (!ok) {
	ok = 0;
	for (int i = 0; i < s.size (); i++)
	  if (s[i] == ':') ok = 1;
	p2 += ok;
      }
      s = "";
    } else s += ss[j];
    j++;
    }
  }*/
  int cur;
  while (cin >> s) {  
    if (!s[0]) break;
    int ok;
    ok = 0;
    if (s[0] == '(') s1++;else {
    for (int i = 0; i < s.size (); i++)
      if (s[i] == '(') ok = 1;
      s2 += ok;
    }
    ok = 0;
    if (s[0] == ':' && s[1] == '=') o1++;else {
      for (int i = 0; i + 1 < s.size (); i++)
	if (s[i] == ':' && s[i + 1] == '=') ok = 1; 
	o2 += ok;
    }
    int n = 0;
    while (s[n]) n++;
    if (s[n - 1] == ':') p1;
    if (!ok) {
      ok = 0;
      for (int i = 0; i < s.size (); i++)
	if (s[i] == ':') ok = 1;
      p2 += ok;
    }
    string tmp (s);
    for (int i = 0; i < tmp.size (); i++) {
      if (tmp[i] >= 'A' && tmp[i] <= 'Z') tmp[i] = tmp[i] - 'A' + 'a';
    }
//    if (tmp.find ("assign") < tmp.size ()) { out ("YES"); return 0;}
    if (tmp.find (".in'") < tmp.size ()) { out ("NO"); return 0;}
    if (tmp.find (".out'") < tmp.size ()) { out ("NO"); return 0;}
    if (tmp.find ("random") < tmp.size ()) { out ("YES"); return 0;}    
    if (tmp.find ("paramstr") < tmp.size ()) { out ("YES"); return 0;} 
    if (tmp.find ("testlib") < tmp.size ()) { out ("YES"); return 0;}
    if (tmp.find ("lib") < tmp.size ()) { out ("YES"); return 0;}
    if (tmp.find ("test") < tmp.size ()) { out ("YES"); return 0;}
    if (tmp.find ("task") < tmp.size ()) { out ("YES"); return 0;}
    if (tmp.find (" by ") < tmp.size ()) { out ("YES"); return 0;}
    if (tmp.find ("author") < tmp.size ()) { out ("YES"); return 0;}
    cur += tmp.size ();
  }
/*  sort (ots.begin (), ots.end ());
  int ok = 1;
  for (int i = 1; i < ots.size (); i++)
    if (ots[i] % ots[0] != 0) ok = 0; else ots[i] = ots[i] / ots[0];
  ots[0] = 1;
  int cnt = 0;
  for (int i = 0; i + 1 < ots.size (); i++)
     if (ots[i + 1] != ots[i] && ots[i + 1] != ots[i] + 1) cnt++;
  if (cnt >= 3) ok = 0;*/    
  int ok = 1;
  if (s1 >= 2 & s2 >= 2) ok = 0;
  if (o1 >= 1 & o2 >= 1) ok = 0;
//  if (p1 >= 1 & p2 >= 1) ok = 0;
  if (cur > 10000) ok = 1 - ok;
  if (ok) printf ("YES\n"); else printf ("NO\n");  
}
