#define FINAL
#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "words"
#ifdef FINAL
#define WRONG WA
#else
#define WRONG START
#endif

enum {OK, WA, PE, JE, PC, NUM};
const char err [NUM] [4] = {"OK", "WA", "PE", "JE", "PC"};
const int START = 50, RANGE = 200;
typedef long double real;

FILE * fin, * fout, * fstat;

void chkexit (char * msg, int code)
{
 fprintf (stderr, "%s: %s\n", err[(code >= 0 && code < NUM) ? code : PC], msg);
 exit (code);
}

const int MaxN = 4096, MaxP = 1024, MaxL = 55, MaxK = 20;

int a [MaxN] [MaxL];
int c [MaxN], d [MaxN];
bool b [MaxN];
int ans [MaxP];

int k, l, m, n, p, q, r, u, w, z;
int count [MaxN];

inline void add (int t)
{
 if (d[t])
  chkexit ("Some two balls intersect.", WRONG);
 d[t]++;
}

int answer (FILE * f)
{
 static char s [MaxN] [MaxL];
 int i, j, r, x;
 char ch;
 if (fscanf (f, " %d", &w) != 1)
  chkexit ("A number is required.", PE);
 for (i = 0; i < w; i++)
 {
  if (fscanf (f, " %25s", s[i]) != 1)
   chkexit ("More words are required.", PE);
  if (int (strlen (s[i])) != k)
   chkexit ("Incorrect word size.", PE);
 }
 if (fscanf (f, " %c", &ch) != EOF)
  chkexit ("Extra info present.", PE);

 for (i = 0; i < w; i++)
 {
  x = 0;
  for (j = 0; j < k; j++)
  {
   r = s[i][j] - 'A';
   if (r < 0 || r >= l)
    chkexit ("Incorrect symbol.", WRONG);
   x = (x << q) + r;
  }
  ans[i] = x;
 }

 memset (d, 0, sizeof (d));
 for (i = 0; i < w; i++)
 {
  x = ans[i];
  add (x);
  for (j = 0; j < m; j++)
   add (a[x][j]);
 }
 return w;
}

int main (int argc, char * argv [])
{
 char fn [128];
 real e;
 int f, g, h, i, j, test, t, x, y;
 if (argc >= 5) freopen (argv[4], "w", stderr);
 assert (argc >= 3);
 if ((fin = fopen (argv[1], "r")) == NULL) chkexit ("No input file!", JE);
 if (fscanf (fin, " %d %d %d", &k, &l, &test) != 3)
  chkexit ("Not enough arguments in input!", JE);
 fclose (fin);

 assert (k >= 1 && k <= MaxK);
 assert (l >= 2 && l <= MaxK);
 for (p = l; p != ((p ^ (p - 1)) & p); p++) ;
 for (q = 0; (1 << q) < p; q++) ;
 z = 1 << (q * k);
 r = 1;
 for (i = 0; i < k; i++)
  r *= l;
 p--;
 memset (b, 0, sizeof (b));
 if (q)
 {
  m = k * (k + 1);
  if (l == 2) m >>= 1;
  n = 0;
  for (x = 0; x < z; x++)
  {
   for (i = 0; i < k; i++)
    if (((x >> (q * i)) & p) >= l)
     break;
   if (i < k) continue;
   b[x] = true;
   n++;
   u = 0;
   for (i = 0; i < k; i++)
   {
    y = x;
    for (j = i; j < k; j++)
    {
     t = (y >> (q * j)) & p;
     t++; if (t == l) t = 0;
     y = (y & ~(p << (q * j))) + (t << (q * j));
     a[x][u++] = y;
    }
    if (l <= 2) continue;
    y = x;
    for (j = i; j < k; j++)
    {
     t = (y >> (q * j)) & p;
     t--; if (t < 0) t = l - 1;
     y = (y & ~(p << (q * j))) + (t << (q * j));
     a[x][u++] = y;
    }
   }
   assert (u == m);
  }
 }
 else
 {
  m = 0;
  n = 1;
  b[0] = true;
 }
 assert (n == r);

/*
 fprintf (stderr, "k = %2d, l = %2d, p = %2d, q = %2d, z = %4d, r = %4d, "
  "n = %4d, m = %3d\n", k, l, p, q, z, r, n, m);
 fflush (stderr);
*/
 if ((fout = fopen (argv[2], "r")) == NULL)
  chkexit ("No output file!", WRONG);
 // Having no such file is allowed.
 g = answer (fout);
 fclose (fout);

 sprintf (fn, "C:\\teststat\\%02d." TASKNAME ".stat", test);
 if ((fstat = fopen (fn, "a+")) == NULL)
  chkexit ("Cannot write statistics!", JE);
 fprintf (fstat, "%d\n", g);
 fclose (fstat);

 if ((fstat = fopen (fn, "r")) == NULL)
  chkexit ("Cannot read statistics!", JE);
 h = g;
 while (fscanf (fstat, " %d", &f) != EOF)
  if (h < f)
   h = f;
 fclose (fstat);
 f = g;
 for (e = 1.0; g < h; g++) e *= 0.5;

 // Currently, judge accepts Partially Correct codes in range
 // START..START + RANGE.
 fprintf (stderr, "Test %d %d: the result size is %d.", k, l, f);
 return START + int (RANGE * e);
// chkexit ("added to statistics.", START + int (RANGE * e));
// assert (false);
// return 0;
}
