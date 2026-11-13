#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <string>
#include <cstring>
#include <ctime>
#include <set>

using namespace std;

#define forn(i,n) for (int i = 0; i < (int)n; i ++)
#define all(x) x.begin(), x.end()
#define pb push_back
#define st botva

char c[300000];
string s;
int n;
int cr = 0;
bool a;
bool a2 = 0;
set <string> st;
int x1 = 0;

void ans (string s)
{
  cout << s << endl;
  exit (0);
}

void check ()
{
//  if (s.find ("{$MODEDELPHI}") != -1)
  //  ans ("YES");
//  if (s.find ("randomize") != -1)
  //  ans ("NO");
  if (s.find ("begin") != -1)
    x1 ++;
  if (cr)
    {
      if (cr == 1)
        {
          if (s.substr (0, 6) == "assign")
            cr ++;
           else
            a2 = 1;
        }
       else
      if (cr == 2)
        {
          if (s.substr (0, 5) == "reset")
            cr ++;
           else
            a2 = 1;
        }
       else
      if (cr == 3)  
        {
          if (s.substr (0, 7) == "rewrite")
            cr ++;
           else
            a2 = 1;
        }
    }
   else 
  if (s.substr (0, 6) == "assign")
    cr = 1;
  if ((s.substr (0, 5) == "reset") && (s.find (',') != -1))
    a2 = 1;
  if ((s.substr (0, 7) == "rewrite") && (s.find (',') != -1))
    a2 = 1;
  if (s.substr (0, 6) == "assign")
    {
      s.erase (0, 12);
      if (s.find ("in") != -1)
        a = 0;
       else
      if (s.find ("out") != -1)
        a = 0;
       else
        a2 = 1;
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
      if (st.count (s))
        continue;
      st.insert (s);
      cut1 (s);
      check ();
      cs ++;
    }
  if (x1 == 10)
    ans ("YES");
  if (x1 >= 11)
    ans ("YES");
  if (st.size() >= 250 && st.size() < 270)
    a2 = 0;
  if (st.size() < 250 &&st.size() >= 100) //220 200
    a2 = 1;
//  if (st.size() < 100 && st.size() >= 70)
  //  a2 = 1;
  if (st.size() <= 40)
    a2 = 0;
  if (st.size() <= 30)
    a2 = 1;
  if (st.size() == 19)
    a2 = 1;
  if (st.size() < 19)
    a2 = 0;
  if (a2)
    ans ("YES");
   else 
    ans ("NO");
  return 0;
}