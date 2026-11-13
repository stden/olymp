/* Compilation options:
 Comment FINAL, XMLWRITE and DO0 to get preliminary version for testsys.
 Define FINAL, comment XMLWRITE and DO0 to get final version for testsys.
 Define FINAL and D00, comment XMLWRITE to get verbose output to stdout.
 Define FINAL and XMLWRITE, comment DO0 to get XML output to stderr.
*/
#define FINAL
#define XMLWRITE
// #define DO0
#include <cassert>
#include <cmath>
#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cstring>

typedef double real;
typedef long long int64;

// Directory for storing temporary files
#ifdef WIN32
#define FN_PREFIX "C:/stat/"
#else
#define FN_PREFIX "/home/judge/stat/"
#endif

#define TASKNAME "baiocchi"

#ifdef FINAL
#define WRONG WA
#define WPE PE
#else
#define WRONG START
#define WPE START
#endif

#define stdchk stdout

enum {OK, WA, PE, JE, PC, NUM};
const char err [NUM] [5] = {"OK", "WA", "PE", "JE", "PC"};
const int START = 50, RANGE = 200;
const real TOTAL = 300.0;

FILE * fin, * fout, * fans, * fstat, * flog;

void chkexit (int code, const char * msg, ...)
{
 va_list args;
 va_start (args, msg);
 fprintf (flog, "%s: ", err[code > JE ? PC : code]);
 vfprintf (flog, msg, args);
 fprintf (flog, "\n");
 va_end (args);
 exit (code);
}

void chkend (FILE * f, int mask)
{
 char ch;
 if (mask >= START) mask = PE;
 if (fscanf (f, " %c", &ch) == 1)
  chkexit (PE | mask, "Extra information given!");
}

const int MinN = 1, MaxN = 8, MaxL = 200, IncL = MaxL + 5, MaxA = 540;
const int MaxBuf = 256, MaxC = 1000000000, NA = -1, MaxD = 4;
const int dx [MaxD] = {-1,  0,  1,  0},
          dy [MaxD] = { 0, -1,  0,  1};
enum {WA_NOT_SQUARE = -1, WA_NOT_SYMMETRIC = -2, WA_NOT_CONNECTED = -3};

struct poly
{
 char a [MaxN] [MaxN];
 int x, y;
 char * operator [] (int k) {return a[k];}
 void init (void) {memset (a, '.', sizeof (a));}
 poly (void) {init ();}
 poly & operator = (poly & b)
 {
  memmove (this, &b, sizeof (poly));
  return *this;
 }
};

poly pbest [MaxA];
int rbest [MaxA];
poly p [MaxA];
int q [MaxA], r [MaxA], num [MaxA];
real sc [MaxA];
char s [MaxBuf + 2];
char buf [MaxBuf + 2];
char t [IncL] [IncL];
char b [IncL] [IncL];
poly c;
real score, mult;
int k, m, n, v;
int xmin, xmax, ymin, ymax, count;
char cur;

inline bool ispolychar (char c)
{
 return (c >= 'A') && (c <= 'Z');
}

bool check (poly & a, poly & b)
{
 int i, j;
 if (a.x != b.x || a.y != b.y) return false;
 for (i = 0; i < a.x; i++)
  for (j = 0; j < a.y; j++)
   if ((a[i][j] == '.') ^ (b[i][j] == '.'))
    return false;
 return true;
}

void rotate90 (poly & a)
{
 poly t;
 int i, j;
 for (i = 0; i < a.x; i++)
  for (j = 0; j < a.y; j++)
   t[a.y - j - 1][i] = a[i][j];
 t.x = a.y;
 t.y = a.x;
 a = t;
}

void flip (poly & a)
{
 poly t;
 int i, j;
 for (i = 0; i < a.x; i++)
  for (j = 0; j < a.y; j++)
   t[j][i] = a[i][j];
 t.x = a.y;
 t.y = a.x;
 a = t;
}

bool isequal (poly & a, poly & b)
{
 if (check (a, b)) return true;
 rotate90 (b);
 if (check (a, b)) return true;
 rotate90 (b);
 if (check (a, b)) return true;
 rotate90 (b);
 if (check (a, b)) return true;
 flip (b);
 if (check (a, b)) return true;
 rotate90 (b);
 if (check (a, b)) return true;
 rotate90 (b);
 if (check (a, b)) return true;
 rotate90 (b);
 if (check (a, b)) return true;
 return false;
}

void recur (int x, int y)
{
 if (b[x][y]) return;
 if (t[x][y] != cur) return;
 b[x][y] = 1;
 count++;
 if (count > MaxN)
  chkexit (PE, "Polyomino with more than %d tiles: figure %d", MaxN, k + 1);
 if (xmin > x) xmin = x;
 if (xmax < x) xmax = x;
 if (ymin > y) ymin = y;
 if (ymax < y) ymax = y;
 int d;
 for (d = 0; d < MaxD; d++)
  recur (x + dx[d], y + dy[d]);
}

void remark (int x, int y)
{
 if (b[x][y] != 1) return;
 b[x][y] = 2;
 int d;
 for (d = 0; d < MaxD; d++)
  remark (x + dx[d], y + dy[d]);
}

void dfs (int x, int y)
{
 if (t[x][y] == '.') return;
 if (b[x][y]) return;
 b[x][y] = true;
 int d;
 for (d = 0; d < MaxD; d++)
  dfs (x + dx[d], y + dy[d]);
}

bool check_baiocchi (void)
{
 int i, j;
 bool ok;
 if (m != n) {q[k] = WA_NOT_SQUARE; return false;}
 for (i = 1; i <= m; i++)
  for (j = 1; j <= n; j++)
   if (((t[i][j] == '.') ^ (t[j][i] == '.')) ||
       ((t[m - i + 1][j] == '.') ^ (t[j][i] == '.')))
   {
    q[k] = WA_NOT_SYMMETRIC;
    return false;
   }
 memset (b, 0, sizeof (b));
 ok = false;
 for (i = 1; i <= m; i++)
  for (j = 1; j <= n; j++)
   if (!b[i][j] && t[i][j] != '.')
   {
    if (!ok)
    {
     dfs (i, j);
     ok = true;
    }
    else
    {
     q[k] = WA_NOT_CONNECTED;
     return false;
    }
   }
 return true;
}

void xml_write_test_ans (int i)
{
 if (q[i] == WA_NOT_SQUARE)
 {
  sprintf (buf, "WA");
  sprintf (s, "[Polyomino %03d] Not a square", num[i]);
 }
 else if (q[i] == WA_NOT_SYMMETRIC)
 {
  sprintf (buf, "WA");
  sprintf (s, "[Polyomino %03d] Not symmetric", num[i]);
 }
 else if (q[i] == WA_NOT_CONNECTED)
 {
  sprintf (buf, "WA");
  sprintf (s, "[Polyomino %03d] Not connected", num[i]);
 }
 else if (q[i] == r[i])
 {
  sprintf (buf, "OK");
  sprintf (s, "[Polyomino %03d] Best solution found: %d tiles", num[i], q[i]);
 }
 else
 {
  sprintf (buf, "PC");
  sprintf (s, "[Polyomino %03d] Suboptimal solution found: %d tiles, "
   "best: %d tiles", num[i], q[i], r[i]);
 }
 fprintf (stderr, "\t\t\t<result number=\"%d\" outcome=\"%s\" pc-type=\"0\" "
  "comment=\"%s\" score=\"%.6lf\" max-score=\"%.6lf\">\n",
  i + 1, buf, s, (double) (sc[i] * mult), (double) (mult));
 fprintf (stderr, "\t\t\t</result>\n");
}

void xml_write (void)
{
 int i;
 fprintf (stderr, "<?xml version=\"1.0\" encoding=\"windows-1251\"?>\n");
 fprintf (stderr, "<results-envelope test-datetime=\"23.12.2008 14:00:00\" "
  "tester=\"testsys\">\n");
 fprintf (stderr, "\t<results tests=\"1-%d\" max-score=\"300\" score=\"%d\" "
  "bonus-score=\"0\" time-limit=\"0\" memory-limit=\"0\" complete=\"true\" "
  "problem-name=\"Ôèãóðû Áàéî÷÷è\">\n", k, (int) (floor (score + 0.5)));
 fprintf (stderr, "\t\t<incremental-results>\n");
 for (i = 0; i < k; i++)
  xml_write_test_ans (i);
 fprintf (stderr, "\t\t</incremental-results>\n");
 fprintf (stderr, "\t\t<final-results>\n");
 for (i = 0; i < k; i++)
  xml_write_test_ans (i);
 fprintf (stderr, "\t\t</final-results>\n");
 fprintf (stderr, "\t</results>\n");
 fprintf (stderr, "</results-envelope>\n");
}

int main (int argc, char * argv [])
{
 int lines, i, j, u, x, y;
 assert (argc >= 4);
 if (argc >= 5)
 {
  if ((flog = fopen (argv[4], "w")) == NULL)
  {
   flog = stdchk;
   chkexit (JE, "Can not open log file!");
  }
 }
 else
 {
  flog = stdchk;
 }
 if ((fin = fopen (argv[1], "r")) == NULL) chkexit (JE, "No input file!");
 if ((fout = fopen (argv[2], "r")) == NULL) chkexit (PE, "No output file!");
 if ((fans = fopen (argv[3], "r")) == NULL) chkexit (JE, "No answer file!");

 for (v = 0; v < MaxA; v++)
 {
  sprintf (s, FN_PREFIX "%03d", v);
  if ((fstat = fopen (s, "r")) == NULL) break;
  poly & cur = pbest[v];
  fscanf (fstat, " %d %d %d", &cur.x, &cur.y, &rbest[v]);
  for (i = 0; i < cur.x; i++)
   for (j = 0; j < cur.y; j++)
    fscanf (fstat, " %c", &(cur[i][j]));
  fclose (fstat);
 }
 
 lines = 0;
 k = 0;
 while (1)
 {
  memset (t, '.', sizeof (t));
  m = 0;
  int ns = NA;
  while (1)
  {
   if (fgets (s, MaxBuf, fout) == NULL) break;
   lines++;
   n = strlen (s);
   if (n > 0 && s[n - 1] == '\n') s[--n] = '\0';
   if (n == 0) break;
   if (n > MaxL)
    chkexit (PE, "String too long: figure %d, line %d, string %d",
     k + 1, lines, m + 1);
   if (ns == NA) ns = n;
   if (n != ns)
    chkexit (PE, "String length mismatch: figure %d, line %d, string %d",
     k + 1, lines, m + 1);
   for (i = 0; i < n; i++)
    if (!ispolychar (s[i]) && s[i] != '.')
     chkexit (PE, "Unexpected symbol `%c': figure %d, line %d, "
      "string %d, symbol %d", s[i], k + 1, lines, m + 1, i + 1);
   strcpy (t[m + 1] + 1, s);
   m++;
   if (m > MaxL)
    chkexit (PE, "Too many strings: figure %d, line %d", k + 1, lines);
  }
  n = ns;
  if (!m) break;
  memset (b, 0, sizeof (b));
  q[k] = 0;
  for (i = 1; i <= m; i++)
   for (j = 1; j <= n; j++)
    if (!b[i][j] && t[i][j] != '.')
    {
     xmin = xmax = i;
     ymin = ymax = j;
     count = 0;
     cur = t[i][j];
     recur (i, j);
     c.init ();
     for (x = xmin; x <= xmax; x++)
      for (y = ymin; y <= ymax; y++)
       if (b[x][y] == 1)
        c[x - xmin][y - ymin] = t[x][y];
     c.x = xmax - xmin + 1;
     c.y = ymax - ymin + 1;
     remark (i, j);
     if (!q[k])
     {
      p[k] = c;
      for (x = 0; x < k; x++)
       if (isequal (p[x], c))
        chkexit (PE, "Two figures with the same polyomino: "
         "figures %d and %d, line %d", x + 1, k + 1, lines);
     }
     q[k]++;
     if (!isequal (p[k], c))
      chkexit (PE, "Unequal polyominoes, cannot determine type: "
       "figure %d, line %d", k + 1, lines);
    }
  if (q[k] == 0)
   chkexit (PE, "No polyominoes, cannot determine type: figure %d, line %d",
    k + 1, lines);

  for (u = 0; u < v; u++)
   if (isequal (pbest[u], c))
    break;
  num[k] = u;
  if (check_baiocchi ())
  {
   if (u == v || rbest[u] > q[k])
   {
    sprintf (s, FN_PREFIX "%03d", v);
    if ((fstat = fopen (s, "w")) == NULL)
     chkexit (JE, "Cannot store statistics: file `%s' could not be opened", s);
    fprintf (fstat, "%d %d %d\n", c.x, c.y, q[k]);
    for (i = 0; i < c.x; i++)
    {
     for (j = 0; j < c.y; j++)
      putc (c[i][j], fstat);
     putc ('\n', fstat);
    }
    fprintf (fstat, "%d %d\n", m, n);
    for (i = 1; i <= m; i++)
    {
     for (j = 1; j <= n; j++)
      putc (t[i][j], fstat);
     putc ('\n', fstat);
    }
    fclose (fstat);
    rbest[u] = q[k];
    pbest[u] = c;
    v++;
   }
  }
#ifdef DO0
  if (q[k] < 0)
   printf ("Polyomino number %03d, wrong answer, best %d\n", u, rbest[u]);
  else
   printf ("Polyomino number %03d, score %d, best %d\n", u, q[k], rbest[u]);
#endif
  r[k] = rbest[u];
  k++;
 }
 char ch;
 if (fscanf (fout, " %c", &ch) == 1)
  chkexit (PE, "File should end after figure %d, line %d", k, lines);

 if (!v) v = 1;
 score = 0.0;
 mult = (real) TOTAL / v;
 for (i = 0; i < k; i++)
  if (q[i] >= 0)
  {
   sc[i] = pow (2, (r[i] - q[i]) * 0.25);
   score += sc[i];
  }
 score *= mult;

#ifdef XMLWRITE
 xml_write ();
#endif

#ifdef FINAL
 chkexit (START + score * RANGE / TOTAL,
  "Format appears to be right, total %d figures, score = %.6lf", k, score);
#else
 chkexit (OK, "Format appears to be right, total %d figures, score = %.6lf",
  k, score);
#endif
 return 0;
}
