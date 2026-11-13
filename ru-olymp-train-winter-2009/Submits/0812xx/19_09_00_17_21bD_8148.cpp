#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cstring>
#include <ctime>

using namespace std;

#define y1 botva
#define forn(i,n) for (int i = 0; i < (int)n; i ++)
#define ford(i,n) for (int i = n-1; i >= 0; i --)
#define fs first
#define sc second
#define all(x) x.begin(), x.end()
#define last(x) (int)x.size()-1
#define pb push_back
#define mp make_pair
#define ws botva1
#define min botva
#define pay botva3
#define time botva4

typedef long long int64;
typedef long double ldb;

const int inf = (1 << 30) - 1;

char ct[10];
char s[400];
int64 len, pay, time, bin, bout, o, speed, in1, out1;
map <string, int64> m;
string mn[12];

string st, st1;

void cut (string &s)
{
  int64 i = 0;
  while (i < s.length())
    if (s[i] == ' ')
      s.erase (i, 1);
     else
      i ++;
}

int64 check1 (string s)
{
  if (s.length() < 26)
    return -1;
  if (s.substr (0, 26) != "Connection established at ")
    return -1;
  s.erase (0, 26);
  if (s.length() < 4)
    return -1;
  if (s.substr (s.length()-4, 4) != "bps.")
    return -1;
  s.erase (s.length()-4, 4);
  int64 res = 0;
  while (s != "" && isdigit(s[0]))
    {
      res = res * 10 + (int64)(s[0] - '0');
      s.erase (0, 1);
    }
  cut (s);  
  if (s != "")
    return -1;
  return res;  
}

int64 calc1 (string s)
{
  int64 i = 11;
  int64 res = (s[i] - '0') * 10 + s[i+1] - '0';
  i += 3;
  res *= 60;
  res += (s[i] - '0') * 10 + s[i+1] - '0';
  i += 3;
  res *= 60;
  res += (s[i] - '0') * 10 + s[i+1] - '0';
  return res;
}

int64 count1 (string s1, string s2)
{
  int64 t1 = calc1 (s1);
  int64 t2 = calc1 (s2);
  if (t1 >= t2)
    return t1 - t2;
   else
    return t1 + 60 * 60 * 24 - t2;
}

int64 check2 (string s)
{
  if (s.length() < 5)
    return -1;
  if (s.substr (s.length()-5, 5) != "bytes")
    return -1;
  s.erase (s.length()-5, 5);  
  int64 res = 0;
  while (s != "" && isdigit(s[0]))
    {
      res = res * 10 + s[0] - '0';
      s.erase (0, 1);
    }
  cut (s);  
  if (s != "")
    return -1;
  return res;  
}

void calc ()
{
  if (len < 25)
    return;
  int64 i = 0;  
  if (!isdigit (s[i]) || !isdigit (s[i+1]) || s[i+2] != '-')
    return;
  i += 3;
  if (!isdigit (s[i]) || !isdigit (s[i+1]) || s[i+2] != '-')
    return;
  i += 3;
  if (!isdigit (s[i]) || !isdigit (s[i+1]) || !isdigit (s[i+2]) || !isdigit (s[i+3]) || s[i+4] != ' ')
    return;
  i += 5;
  if (!isdigit (s[i]) || !isdigit (s[i+1]) || s[i+2] != ':')
    return;
  i += 3;
  if (!isdigit (s[i]) || !isdigit (s[i+1]) || s[i+2] != ':')
    return;
  i += 3;
  if (!isdigit (s[i]) || !isdigit (s[i+1]) || s[i+2] != '.')
    return;
  i += 3;
  if (!isdigit (s[i]) || !isdigit (s[i+1]) || s[i+2] != ' ')
    return;
  i += 3;
  if (s[i] != '-' || s[i+1] != ' ')
    return;
  st = s;
  st.erase (0, 25);
  int64 x = check1 (st);
  if (x != -1)
    {
      o = 1;
      st = s;
      printf ("%s    ", st.substr(0, 19).data());
      st1 = st;
      speed = x;
    }
   else 
  if (st == "Hanging up the modem." && o == 1)
    {
      o = 2;
      st = s;
      int64 tm1 = count1 (st, st1);
      printf ("%lld %lld ", tm1, speed);
      time += tm1;
      if (tm1 >= 60)
        pay += tm1;
    }
   else
  if (st == "Standart Modem closed.")
    {
      if (o == 2)
        {
          printf ("%lld/%lld\n", in1, out1);
          bin += in1;
          bout += out1;
          in1 = out1 = 0;
        }
      o = 0;
    }  
   else
  if (o == 2)
    {
      cut (st);
      if (st.length() >= 6 && st.substr (0, 6) == "Reads:")
        {
          st.erase (0, 6);
          int64 x = check2 (st);
          if (x != -1)
            in1 = x;
        }  
       else
      if (st.length() >= 7 && st.substr (0, 7) == "Writes:")
        {
          st.erase (0, 7);
          int64 x = check2 (st);
          if (x != -1)
            out1 = x;
        }  
    }
}

void read ()
{
  forn (i, len)
    s[i] = 0;
  len = 0;
  char ch;
  while (true)
    {
      if (scanf ("%c", &ch) <= 0)
        break;
      if (ch == '\n')
        break;
      s[len] = ch;
      len ++;
    }
}

int main ()
{
  freopen ("calls.in", "r", stdin);
  freopen ("calls.out", "w", stdout);
  memset (s, 0, sizeof (s));
  pay = time = 0;
  bin = bout = 0;
  o = 0;
  len = 0;
  in1 = out1 = 0;
  while (true)
    {
      read ();
      if (len == 0)
        break;
      calc ();  
    }
  printf ("Total seconds to pay = %lld, total seconds = %lld; total bytes %lld/%lld\n", pay, time, bin, bout);  
  return 0;
}