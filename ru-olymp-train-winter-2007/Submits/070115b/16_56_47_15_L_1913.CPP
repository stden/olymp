#include <stdio.h>
#include <string.h>
#include <string>
using namespace std;

string a, b;

bool acc (unsigned char c)
{
  return (c >= 33) && (c <= 126);
}

int main ()
{
  freopen ("substr.in", "rt", stdin);
  freopen ("substr.out", "wt", stdout);

  a = "";
  b = "";

  a.reserve (10001);
  b.reserve (200001);

  char last;
  while (!feof (stdin))
  {
    last = fgetc (stdin);
    if (last != '*')
    {
      if (acc (last))
        a += last;
    }
    else
      break;
  }
  while (!feof (stdin))
  {
    last = fgetc (stdin);
    if (acc (last) && !feof (stdin))
      b += last;
  }

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
