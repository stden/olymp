#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <cstring>
#include <ctime>

using namespace std;

#define forn(i,n) for (int i = 0; i < (int)n; i ++)
#define all(x) x.begin(), x.end()
#define pb push_back
#define cut1 botva

char c[300000];
string s;
int n;
bool a;

void ans (string s)
{
  cout << s << endl;
  exit (0);
}

void check ()
{
  if (s.substr (0, 5) == "reset" && s.find (',') != -1)
    ans ("YES");
  if (s.substr (0, 7) == "rewrite" && s.find (',') != -1)
    ans ("YES");
  if (s.substr (0, 6) == "assign")
    {
      s.erase (0, 12);
      if (s.find (".in") != -1)
        a = 0;
      if (s.find (".out") != -1)
        a = 0;
    }
}

void cut1 (string &s)
{
  int i = 0;
  while (i < s.length())
    if (s[i] == ' ')
      s.erase (i, 1);
     else
      i ++;
}

int main ()
{
  freopen ("help.in", "r", stdin);
  freopen ("help.out", "w", stdout);
  memset (c, 0, sizeof (c));
  a = 1;
  while (true)
    {
      gets (c);
      s = c;
      n = s.length();
      int x = clock ();
      x /= 1000;
      if (x > 900)
        break;
      cut1 (s);
      check ();
    }
  if (a)  
    ans ("YES");  
   else
    ans ("NO");
  return 0;
}