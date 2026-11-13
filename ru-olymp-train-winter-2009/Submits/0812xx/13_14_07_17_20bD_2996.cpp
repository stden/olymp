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

typedef long long int64;
typedef long double ldb;

const int inf = (1 << 30) - 1;

struct rool
{
  int ip, mask, to;
  string id, pass;
};

struct state
{
  int port;
  vector <rool> q;
};

vector <state> a;
char s[100];
int n, f[33];

void parseip (int &ip, int &mask)
{
  int l = strlen (s);
  ip = 0;
  mask = 0;
  int i = 0;
  int x = 0;
  while (i < l && s[i] != '/')
    {
      if (isdigit (s[i]))
        x = x * 10 + s[i] - '0';
       else
        {
          ip <<= 8;
          ip += x;
          x = 0;
        }
      i ++;  
    }
  ip <<= 8;
  ip += x;
  if (i == l)
    mask = 0;
   else
    {
      i ++;
      mask = 0;
      while (i < l)
        {
          if (isdigit (s[i]))
            mask = mask * 10 + s[i] - '0';
          i ++;  
        }    
      mask = 32 - mask;
    }
}

rool next_rool ()
{
  rool res;
  res.id = "";
  res.pass = "";
  scanf ("%s", s);
  parseip (res.ip, res.mask);
  scanf ("%s", s);
  scanf ("%s", s);
  int q;
  parseip (res.to, q);
  scanf ("%s", s);
  if ((string)s != "I" && (string)s != "P")
    return res;
  if ((string)s == "I")
    {
      scanf ("%s", s);
      res.id = s;
      scanf ("%s", s);
    }
  if ((string)s != "P")
    return res;
  scanf ("%s", s);
  res.pass = s;
  scanf ("%s");
  return res;
}

string inttostring (int x)
{
  string res = "";
  while (x)
    {
      res += (char)(x % 10 + '0');
      x/= 10;
    }
  if (res == "")
    res ="0";
  return res;  
}

string parseint (int ip)
{
  string res;
  forn (i, 4)
    {
      res += inttostring (ip & 255);
      if (i < 3)
        res += '.';
      ip >>= 8;  
    }
  reverse (all (res));
  return res;
}

bool check1 (int ip, string id, string pass, rool a)
{
  if ((ip | f[a.mask]) != (a.ip | f[a.mask]))
    return false;
  if ((a.pass != "") && (a.pass != pass))
    return false;
  if (a.id == "")
    return true;
  if (id == "")
    return false;
  int x = a.id.find ('-');
  if (x != -1)
    {
      string l = a.id.substr (0, x);
      string r = a.id.substr (x+1);
      if (l.length() != r.length())
        cerr << "botva" << endl;
      forn (i, id.length())
        if (!isdigit (id[i]))
          return false;
      if (id.length() != l.length())
        return false;
      if (!(l <= id && id <= r))
        return false;
    }
   else 
    {
      if (a.id != id)
        return false;
    }
  return true;
}

void check (int ip, int port, string id, string pass)
{
  forn (i,n)
    if (port == a[i].port)
      {
        forn (j, a[i].q.size())
          if (check1 (ip, id, pass, a[i].q[j]))
            {
              printf ("%s\n", parseint (a[i].q[j].to).data());
              return;
            }  
        printf ("/dev/null\n");
        return;
      }
}

int main ()
{
  freopen ("multiplexor.in", "r", stdin);
  freopen ("multiplexor.out", "w", stdout);
  memset (s, 0, sizeof (s));
  a.clear ();
  n = 0;
  scanf ("%s", s);
  while (true)
    {
      if ((string)s == "---")
        break;
      if ((string)s == "A")
        {
          n ++;
          a.resize (n);
          scanf ("%d", &a[n-1].port);
          scanf ("%s", s);
        }
       else
        a[n-1].q.pb (next_rool ());
    }
  f[0] = 1;
  for (int i = 1; i <= 32; i ++)
    f[i] = f[i-1] * 2;
  for (int i = 0; i <= 32; i ++)
    f[i] --;

scanf ("%s", s);
  while (true)
    { 
      int ip, mask;
      if (scanf ("%s", s) <= 0)
        break;
      parseip (ip, mask);
      int port;
      scanf ("%s", s);
      scanf ("%d", &port);
      string id, pass;
      id = pass = "";
      
      scanf ("%s", s);
      if ((string)s != "I" && (string)s != "P")
        {
          check (ip, port, id, pass);
          continue;
        }
      if ((string)s == "I")
        {
          scanf ("%s", s);
          id = s;
          scanf ("%s", s);
        }
      if ((string)s != "P")
        {
          check (ip, port, id, pass);
          continue;
        }
      scanf ("%s", s);
      pass = s;
      scanf ("%s");
      check (ip, port, id, pass);
    }
  return 0;
}