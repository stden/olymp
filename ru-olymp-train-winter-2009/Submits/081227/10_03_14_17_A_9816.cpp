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
int cr = 0;
bool a;

void ans (string s)
{
  cout << s << endl;
  exit (0);
}

void check ()
{
  if (cr)
    {
      if (cr == 1)
        {
          if (s.substr (0, 6) == "assign")
            cr ++;
           else
            ans ("YES");
        }
       else
      if (cr == 2)
        {
          if (s.substr (0, 5) == "reset")
            cr ++;
           else
            ans ("YES");
        }
       else
      if (cr == 3)  
        {
          if (s.substr (0, 7) == "rewrite")
            cr ++;
           else
            ans ("YES");
        }
    }
   else 
  if (s.substr (0, 6) == "assign")
    cr = 1;
  if (s.find ("random") != -1)
    ans ("YES");
  if ((s.substr (0, 5) == "reset") && (s.find (',') != -1))
    ans ("YES");
  if ((s.substr (0, 7) == "rewrite") && (s.find (',') != -1))
    ans ("YES");
  if (s.substr (0, 6) == "assign")
    {
      s.erase (0, 12);
      if (s.find ("in") != -1)
        a = 0;
       else
      if (s.find ("out") != -1)
        a = 0;
       else
        ans ("YES");
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
  while (s.length() < 20)
    s += ' ';
}

int main ()
{
  freopen ("help.in", "r", stdin);
  freopen ("help.out", "w", stdout);
  srand (634634);
  memset (c, 0, sizeof (c));
  a = 1;
  int cs = 0;
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
      cs ++;
    }
  ans ("NO");
  return 0;
}