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

typedef long long int64;
typedef long double ldb;

const int inf = (1 << 30) - 1;

int t1, t2, r1, r2, len, t3, t4, r;
bool u;
char s[4000000];

void read ()
{
  len = 0;
  char c;
  while (true)
    {
      if (!(scanf ("%c", &c) > 0))
        {
          u = true;
          break;
        }  
      if (c == '\n')
        break;
      s[len] = c;
      len ++;
    }
}

bool check ()
{
  if (len == 0)
    return false;
  forn (i, len)
    if (s[i] != '-')
      return false;
  return true;    
}

int read_1 (int tp)
{
  int i = 11;
  int res = 0;
  while (i < len && s[i] <= '9' && s[i] >= '0')
    {
      res = res * 10 + s[i] - '0';
      i ++;
    }
  if (tp == 1)
    {
      while (i < len)
        {
          if (s[i] != ' ')
            return -1;
          i ++;  
        }
    }
   else
    {
      if (i == len)
        return -1;
      if (s[i] == ',')
        {
          i ++;
          while (i < len && s[i] <= '9' && s[i] >= '0')
            i ++;
        }
      if (i + 2 >= len)
        return -1;
      if (s[i] != ' ' || s[i+1] != 'm' || s[i+2] != 's')
        return -1;
      i += 3;
      while (i < len)
        {
          if (s[i] != ' ')
            return -1;
          i ++;  
        }
    }
  return res;  
}

string st;

int main ()
{
  freopen ("stress.in", "r", stdin);
  freopen ("stress.out", "w", stdout);
  memset (s, 0, sizeof (s));
  u = false;
  t1 = t2 = r1 = r2 = 0;
  int k = 0;
  int x;
  while (true)
    {
      if (u)
        break;
      read ();
      if (check ())
        {
          k = (k + 1) & 1;
          if (!(k & 1))
            {
              printf ("At randseed = %d\n", r);
              printf ("First: %d ms\n", t3);
              printf ("Second: %d ms\n", t4);
              if (t3 > t1)
                {
                  t1 = t3;
                  r1 = r;
                }
              if (t4 > t2)
                {
                  t2 = t4;
                  r2 = r;
                }
            }
          t3 = t4 = r = 0;
        }
      st = s;  
      if (len > 10)
        {
          if (st.substr (0, 11) == "randseed = ")
            {
              x = read_1 (1);
              if (x != -1)
                r = x;
            }  
          if (st.substr (0, 11) == "Work time: ")
            {
              x = read_1 (2);
              if (x != -1)
                {
                  t3 = t4;
                  t4 = x;
                }
            }
        }  
    }
  printf ("Maximal work time for first: %d at randseed = %d\n", t1, r1);
  printf ("Maximal work time for second: %d at randseed = %d\n", t2, r2);
  return 0;
}