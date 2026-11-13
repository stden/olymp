#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sstream>
#include <string>

using namespace std;

#define TASKNAME "lcm"

enum {OK, WA, PE, JE, PC, NUM};
const char err [NUM] [4] = {"OK", "WA", "PE", "JE", "PC"};
const int START = 50, RANGE = 200;
typedef long double real;

FILE * fin, * fout, * fstat;

void chkexit (const char * msg, int code)
{
 fprintf (stderr, "%s: %s\n", err[(code >= 0 && code < NUM) ? code : PC], msg);
 exit (code);
}

const int MaxN = 1003, MaxD = 1003, Base = 10, LogBase = 1;
typedef int bignum [MaxD + 1];

int u [MaxN];
bignum a, d;
int n, k, test;

bool equ (const bignum & a, const bignum & b)
{
 int i;
 if (a[0] != b[0]) return false;
 for (i = a[0]; i >= 1; i--)
  if (a[i] != b[i]) return false;
 return true;
}

void multc (bignum & a, const bignum & b, const int c)
{
 int i, p;
 p = 0;
 for (i = 1; i <= b[0]; i++)
 {
  p += b[i] * c;
  a[i] = p % Base;
  p /= Base;
 }
 while (p > 0)
 {
  a[i] = p % Base;
  p /= Base;
  i++;
 }
 while (i > 0 && a[i] == 0) i--;
 a[0] = i;
}

int divc (bignum & a, const bignum & b, const int c)
{
 int i, p;
 p = 0;
 a[0] = b[0];
 for (i = b[0]; i >= 1; i--)
 {
  p = p * Base + b[i];
  a[i] = p / c;
  p %= c;
 }
 while (a[0] > 0 && a[a[0]] == 0) a[0]--;
 return p;
}

void inbln (FILE * f, bignum & a)
{
 int i, j, k;
 char ch;
 a[0] = 0;
 while (1)
 {
  fscanf (f, "%c", &ch);
  if (ch <= 32) break;
  if (ch < '0' || ch > '9') chkexit ("Not a digit.", PE);
  if (a[0] >= MaxD) chkexit ("Number too long.", PE);
  a[++a[0]] = ch - '0';
 }
 if (a[1] == 0) chkexit ("Leading zeroes are not allowed.", PE);
 i = 1; j = a[0];
 while (i < j)
 {
  k = a[i]; a[i] = a[j]; a[j] = k;
  i++; j--;
 }
}

void foutbln (FILE * f, const bignum & a)
{
 int i;
 fprintf (f, "%d", a[a[0]]);
 for (i = a[0] - 1; i >= 1; i--)
  fprintf (f, "%0*d", LogBase, a[i]);
 fprintf (f, "\n");
}

int gcd (const bignum & a, int b)
{
 int c, t;
 bignum t1;
 c = divc (t1, a, b);
 while (c > 0)
 {
  t = b % c;
  b = c;
  c = t;
 }
 return b;
}

void answer (FILE * f)
{
 int i, j;
 char ch;
 memset (a, 0, sizeof (a));
 inbln (f, a);
 for (i = 0; i < k; i++)
 {
  if (fscanf (f, " %d", &u[i]) != 1)
   chkexit ("More numbers are required.", PE);
 }
 if (fscanf (f, " %c", &ch) != EOF)
  chkexit ("Extra info present.", PE);
 for (i = 0; i < k; i++)
 {
  if (u[i] < 1 || u[i] > n)
   chkexit ("Number not in range.", WA); // WA
  if (i && u[i - 1] >= u[i])
   chkexit ("Duplicate numbers or sequence not sorted.", WA); // WA
 }
 memset (d, 0, sizeof (d));
 d[0] = d[1] = 1;
 for (i = 0; i < k; i++)
 {
  j = gcd (d, u[i]);
  assert (!(u[i] % j));
  j = u[i] / j;
  multc (d, d, j);
 }
 if (!equ (a, d))
  chkexit ("LCM given does not match numbers.", WA); // WA
}

int getreal (FILE * f, real & g)
{
 int ch;
 g = 0.0;
 while (1)
 {
  ch = getc (f);
  if (ch < '0' || ch > '9') break;
  g = g * 10.0 + (ch - '0');
 }
 return ch;
}

int main (int argc, char * argv [])
{
 char fn [128];
 real f, m, g;
 assert (argc >= 3);
 if (argc >= 5) freopen (argv[4], "w", stderr);
 if ((fin = fopen (argv[1], "r")) == NULL) chkexit ("No input file!", JE);
 if ((fout = fopen (argv[2], "r")) == NULL) chkexit ("No output file!", WA);
 // Having no such file is allowed.
 fscanf (fin, " %d %d %d", &n, &k, &test);
 answer (fout);
 fclose (fout);

 if ((fout = fopen (argv[2], "r")) == NULL) chkexit ("No output file!", WA);
 getreal (fout, g);
 fclose (fout);

 sprintf (fn, "C:\\teststat\\%02d.stat", test);
 if ((fstat = fopen (fn, "a+")) == NULL)
  chkexit ("Cannot write statistics!", JE);
 foutbln (fstat, d);
 fclose (fstat);

 if ((fstat = fopen (fn, "r")) == NULL)
  chkexit ("Cannot read statistics!", JE);
 m = g;
 while (getreal (fstat, f) != EOF)
  if (m < f)
   m = f;
 fclose (fstat);

 // Currently, judge accepts Partially Correct codes in range
 // [START..START + RANGE].
 char buf [1024];
 int i;
 bool msvcrt;
 msvcrt = (g > 1E302);
 if (msvcrt) g /= 1E200;
 sprintf (buf, "LCM = %.8lG\n", double (g));
 fflush (stdout);
 if (msvcrt)
 {
  g *= 1E200;
  for (i = 0; buf[i] != 'E'; i++) ;
  i++;
  if (buf[i] == '+') i++;
  buf[i] += 2;
 }
 fprintf (stderr, buf);
 return (START + int (RANGE * (g / m)));
}
