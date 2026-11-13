#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "lcm"

enum {OK, WA, PE, JE, NUM};
const char err [NUM] [4] = {"OK", "WA", "PE", "JE"};

FILE * fin, * fout, * fans;

void chkexit (char * msg, int code)
{
 fprintf (stderr, "%s: %s\n", err[code], msg);
 exit (code);
}

const int MaxN = 1003, MaxD = 1003, Base = 10, LogBase = 1;
typedef int bignum [MaxD + 1];

int u [MaxN];
bignum a;
int n, k;

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

void answer (FILE * f)
{
 int i;
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
}

int main (int argc, char * argv [])
{
 assert (argc >= 3);
 if ((fin = fopen (argv[1], "r")) == NULL) chkexit ("No input file!", JE);
 if ((fout = fopen (argv[2], "r")) == NULL) chkexit ("No output file!", OK);
 // Having no such file is allowed.
 if (argc >= 5) freopen (argv[4], "w", stderr);
 fscanf (fin, " %d %d", &n, &k);
 answer (fout);
 chkexit ("The format is correct.", OK);
 assert (false);
 return 0;
}
