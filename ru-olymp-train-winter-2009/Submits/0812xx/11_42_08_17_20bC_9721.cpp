#include <cstdio>
#include <iostream>
#include <algorithm>
#include <vector>
#include <set>
#include <map>
#include <string>
#include <cstring>
#include <ctime>
#include <cmath>

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
typedef int ar[1000];

const int inf = (1 << 30) - 1;
const double eps = 1e-9;

char c[1000];

void read_long (ar &a)
{
  memset (a, 0, sizeof (a));
  memset (c, 0, sizeof (c));
  scanf ("%s\n", &c);
  a[0] = strlen (c);
  for (int i = 1; i <= a[0]; i ++)
    a[i] = c[a[0]-i] - '0';    
}

bool more (ar &a, ar &b, int d)
{
  if (a[0]+d != b[0])
    return a[0]+d > b[0];
  for (int i = a[0]; i > 0; i --)
    if (a[i] != b[i+d])
      return a[i] > b[i+d];
  return false;
}

void print (ar &a)
{
  printf ("%d", a[a[0]]);
  for (int i = a[0]-1; i > 0; i --)
    printf ("%d", a[i]);
}

void sub (ar &a, ar &b, int d)
{
  for (int i = 1; i <= b[0]; i ++)
    {
      a[i+d] -= b[i];
      while (a[i+d] < 0)
        {
	  a[i+d] += 10;
	  a[i+d+1] --;
	}
    }
  while (a[0] > 0 && a[a[0]] == 0)
    a[0] --;
}

void mult (ar &a, int d)
{
  int o = 0;
  for (int i = 1; i <= a[0]; i ++)
    {
      a[i] = a[i] * d + o;
      o = a[i] / 10;
      a[i] %= 10;
    }
  if (o)
    {
      a[0] ++;
      a[a[0]] = o;
    }
  while (a[a[0]] == 0 && a[0] > 0)
    a[0] --;
}

void printc (char c, int t)
{
  forn (i, t)
    printf ("%c", c);
}

ar a, b, r, d, cc;

int main ()
{
  freopen ("division.in", "r", stdin);
  freopen ("division.out", "w", stdout);
  read_long (a);
  memcpy (d, a, sizeof (a));
  read_long (b);
  memset (r, 0, sizeof (r));
  r[0] = a[0];
  for (int i = a[0]; i > 0; i --)
    {
      while (!more (b, a, i-1))
        {
	  r[i] ++;
	  sub (a, b, i-1);
	}
    }
  while (r[0] > 0 && r[r[0]] == 0)
    r[0] --;  
  int l1 = 1;
  int r1 = 1;
  print (d);
  int d1;
  d1 = max (b[0], r[0]);
  printf (" |");
  print (b);
  printf ("\n");
  if (r[0] == 0)
    {
      printc (' ', d[0]+1);
      printf ("+");
      printc ('-', d1);
      printf ("\n");
      printc (' ', d[0]+1);
      printf ("|0\n");
      return 0;
    }
  memcpy (cc, b, sizeof (cc));
  mult (cc, r[r[0]]);
  if (cc[0] + r[0] - 1 < d[0])
    printf (" ");
  print (cc);
  if (cc[0] + r[0] - 1 < d[0])
    printc (' ', d[0] - cc[0]);
   else 
    printc (' ', d[0]+1 - cc[0]);
  printf ("+");
  printc ('-', d1);
  printf ("\n");
  int ks = 0;
  memcpy (a, d, sizeof (d));
  sub (a, cc, r[0]-1);
  int p2 = d[0] - a[0];
  for (int i = r[0]-1; i > 0; i --)
    if (r[i] != 0)
      { 
        p2 = d[0] - a[0];
        int p1;
        ks ++;
	r1 = d[0]-i+1;
	printc (' ', l1-1);
	printc ('-', r1-l1+1);
	if (ks == 1)
	  {
	    printc (' ', d[0]+1-r1);
	    printf ("|");
	    print (r);
	  }
        printf ("\n");
	memcpy (cc, b, sizeof (cc));
	mult (cc, r[i]);
	p1 = r1 - cc[0] + 1;
	printc (' ', p2);
	for (int j = a[0]; j >= i; j--)
	  printf ("%d", a[j]);
	printf ("\n");  
	sub (a, cc, i-1);
	printc (' ', p1-1);
	print (cc);
	printf ("\n");
	l1 = p2+1;
      }
  r1 = d[0];    
  printc (' ', l1-1);
  printc ('-', r1-l1+1);
  if (ks == 0)
    {
       printc (' ', d[0]+1-r1);
       printf ("|");
       print (r);
    }
  printf ("\n");
  if (a[0] == 0)
    a[0] ++;
  printc (' ', d[0]-a[0]);
  print (a);
  printf ("\n");
  return 0;
}