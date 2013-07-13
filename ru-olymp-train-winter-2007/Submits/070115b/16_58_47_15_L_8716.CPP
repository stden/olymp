#include <stdio.h>
#include <string.h>
#include <string>
using namespace std;

string a, b;

bool acc (unsigned char c)
{
  return (c >= 33) && (c <= 126);
}

char x[10001];
char y[200001];
int cx = 0, cy = 0;

int main ()
{
  freopen ("substr.in", "rt", stdin);
  freopen ("substr.out", "wt", stdout);

  a = "";
  b = "";

  char last;
  while (!feof (stdin))
  {
    last = fgetc (stdin);
    if (last != '*')
    {
      if (acc (last))
        x[cx++] = last;
    }
    else
      break;
  }
  while (!feof (stdin))
  {
    last = fgetc (stdin);
    if (acc (last) && !feof (stdin))
      y[cy++] = last;
  }
  x[cx] = 0;
  y[cy] = 0;
  a = x;
  b = y;

  int cur = 0;
  while (true)
  {
    int pos = b.find (a, cur);
    if (pos == string::npos)
      break;
    printf ("%d ", pos + 1);
    cur = pos + 1;
  }

  return 0;
}
