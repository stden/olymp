#include <cassert>
#include <cmath>
#include <cstdarg>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#define TASKNAME "path"

#define stdchk stdout

enum {OK, WA, PE, JE, NUM};
const char err [NUM] [4] = {"OK", "WA", "PE", "JE"};
typedef long long int64;
typedef double real;

FILE * fin, * fout, * fans, * flog;

void chkexit (int code, const char * msg, ...)
{
 va_list args;
 va_start (args, msg);
 fprintf (flog, "%s: ", err[code]);
 vfprintf (flog, msg, args);
 fprintf (flog, "\n");
 va_end (args);
 exit (code);
}

const int MinN = 1, MaxN = 22, MinM = 0, MaxM = 1000;

int a [MaxN] [MaxN];
int m, n;

int answer (FILE * f, int mask)
{
 int p [MaxN];
 int ans, i, j;
 char ch;

 // Read the input
 if (fscanf (f, " %d", &ans) != 1)
  chkexit (PE | mask, "cannot read length");
 if (ans >= n)
  chkexit (WA | mask, "path too long");
 for (i = 0; i <= ans; i++)
 {
  if (fscanf (f, " %d", &j) != 1)
   chkexit (PE | mask, "cannot read vertex %d", i + 1);
  if (j < 1 || j > n)
   chkexit (WA | mask, "vertex %d not in bounds (%d should to be in [%d..%d])",
    i + 1, j, 1, n);
  j--;
  p[i] = j;
 }
 if (fscanf (f, " %c", &ch) != EOF)
  chkexit (PE | mask, "Extra information at end of file!");

 // Check the path
 for (i = 0; i < ans; i++)
  for (j = i + 1; j <= ans; j++)
   if (p[i] == p[j])
    chkexit (WA | mask, "Duplicate vertex %d in path!", p[i] + 1);
 for (i = 0; i < ans; i++)
  if (!a[p[i]][p[i + 1]])
   chkexit (WA | mask, "No edge from %d to %d!", p[i] + 1, p[i + 1] + 1);

 return ans;
}

int main (int argc, char * argv [])
{
 int rc, rj, i, j, k;
 char ch;
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
 if (fscanf (fin, " %d %d", &n, &m) != 2)
  chkexit (JE, "Cannot read n and m!");
 if (n < MinN || n > MaxN)
  chkexit (JE, "n = %d not in range [%d..%d]", n, MinN, MaxN);
 if (m < MinM || m > MaxM)
  chkexit (JE, "m = %d not in range [%d..%d]", m, MinM, MaxM);
 memset (a, 0, sizeof (a));
 for (i = 0; i < m; i++)
 {
  if (fscanf (fin, " %d %d", &j, &k) != 2)
   chkexit (JE, "Cannot read edge %d!", i + 1);
  if (j < 1 || j > n)
   chkexit (JE, "Edge %d: starting vertex %d not in range [%d..%d]!",
    i + 1, j, 1, n);
  if (k < 1 || k > n)
   chkexit (JE, "Edge %d: ending vertex %d not in range [%d..%d]!",
    i + 1, k, 1, n);
  j--; k--;
  a[j][k] = true;
 }
 if (fscanf (fin, " %c", &ch) != EOF)
  chkexit (JE, "Extra information at end of file!");
 rc = answer (fout, OK);
 rj = answer (fans, JE);
 if (rj < rc)
  chkexit (JE, "Contestant found a longer path: %d instead of %d!", rc, rj);
 if (rc < rj)
  chkexit (WA, "Jury found a longer path: %d instead of %d.", rj, rc);
 chkexit (OK, "Contestant and jury found paths of equal lengths (%d).", rc);
 return 0;
}
