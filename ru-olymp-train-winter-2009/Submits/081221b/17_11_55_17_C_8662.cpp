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

typedef long long int64;
typedef long double ldb;

const int inf = (1 << 30) - 1;

char ct[10];
char s[4000000];
int len;
map <string, int> m;
string mn[12];
int days[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

string st;

int parse (int &i, int k)
{
  int res = 0;
  forn (j, k)
    {
      res = res * 10 + s[i] - '0';
      i ++;
    }
  i ++;
  return res;
}

int parse1 (int v)
{
  int x, res;
  if (s[v] == '+')
    x = 1;
   else
    x = -1;
  v ++;
  res = (s[v] - '0') * 10 + s[v+1] - '0';
  res *= 60;
  v += 2;
  res += (s[v] - '0') * 10 + s[v+1] - '0';
  return res * x;
}

void put (int &v, int x, int k)
{
  v += k;
  forn (i, k)
    {
      v --;
      s[v] = (x % 10) + '0';
      x /= 10;
    }
  v += k + 1;  
}

void calc ()
{
  int i = 0;
  while (s[i] != '[')
    i ++;
  i ++;
  int j = i;
  int day, month, year, h, min, sec;
  day = parse (i, 2);
  st = "";
  forn (k, 3)
    {
      st += s[i];
      i ++;
    }
  month = m[st];
  i ++;
  year = parse (i, 4);
  h = parse (i, 2);
  min = parse (i, 2);
  sec = parse (i, 2);
  int cz = parse1 (i);
  forn (k, 5)
    s[i+k] = ct[k];
  int oz = parse1 (i);
  min = min - cz + oz;
  if (min < 0)
    {
      while (min < 0)
        {
          min += 60;
          h --;
        }
      while (h < 0)
        {
          h += 24;
          day --;
        }  
      if (day <= 0)
        month --;
      if (month < 0)
        {
          month += 12;
          year --;
        }
      if (day <= 0)
        {
          day += days[month];
          if (!(year % 4) && days[month] == 28)
            day ++;
        }  
    }
   else
    {
      while (min >= 60)
        {
          min -= 60;
          h ++;
        }
      while (h >= 24)
        {
          h -= 24;
          day ++;
        }
      if (!(year % 4))
        days[1] = 29;
      if (day > days[month])
        {
          day -= days[month];
          month ++;
        }  
      if (month == 12)
        {
          month = 0;
          year ++;
        }
      days[1] = 28;  
    }
  i = j;
  put (i, day, 2);
  st = mn[month];
  forn (k, 3)
    {
      s[i] = st[k];
      i ++;
    }
  i ++;
  put (i, year, 4);
  put (i, h, 2);
  put (i, min, 2);
  put (i, sec, 2);
  forn (k, 5)
    {
      s[i] = ct[k];
      i ++;
    }
}

void read ()
{
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
  freopen ("apache.in", "r", stdin);
  freopen ("apache.out", "w", stdout);
  scanf ("%s           \n\n\n\n\n\n\n", &ct);
  memset (s, 0, sizeof (s));
  m.clear ();

  m["Jan"] = 0;
  m["Feb"] = 1;
  m["Mar"] = 2;
  m["Apr"] = 3;
  m["May"] = 4;
  m["Jun"] = 5;
  m["Jul"] = 6;
  m["Aug"] = 7;
  m["Sep"] = 8;
  m["Oct"] = 9;
  m["Nov"] = 10;
  m["Dec"] = 11;
  for (map <string, int> :: iterator it = m.begin(); it != m.end(); it ++)
    mn[(*it).sc] = (*it).fs;
  
  while (true)
    {
      read ();
      if (len == 0)
        break;
      calc ();
      forn (i, len)
        printf ("%c", s[i]);
      printf ("\n");  
    }
  return 0;
}