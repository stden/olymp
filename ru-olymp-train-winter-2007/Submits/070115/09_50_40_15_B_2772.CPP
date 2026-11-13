#include <stdio.h>
#include <string.h>

bool _solve (char* seq, int n, int c)
{
  if (n == 0)
    return false;
  if (c)
  {
    if (n == 1)
      return ((seq[0] - '0') & 1) == 0;
    else if (n == 2)
      return (seq[0] == seq[1] + 1);
    else if (seq[0] == seq[n - 1] + 1)
    {
      seq[n - 2]--;
      bool r = _solve (seq + 1, n - 2, 1);
      seq[n - 2]++;
      return r;
    }
    else if (seq[0] == seq[n - 1] && seq[0] != '9')
    {
      seq[n - 2]--;
      bool r = _solve (seq + 1, n - 2, 0);
      seq[n - 2]++;
      return r;
    }
    else
      return false;
  }
  else
  {
    if (n == 1)
      return ((seq[0] - '0') & 1) == 0;
    else if (n == 2)
      return (seq[0] == seq[1]);
    else if (seq[0] == seq[n - 1] + 1)
      return _solve (seq + 1, n - 2, 1);
    else if (seq[0] == seq[n - 1])
      return _solve (seq + 1, n - 2, 0);
    else
      return false;
  }
}

char seq[16384];

int main ()
{
  freopen ("reverse.in", "rt", stdin);
  freopen ("reverse.out", "wt", stdout);

  while (true)
  {
    scanf ("%s", seq);
    if (seq[0] == '0' && seq[1] == 0)
      return 0;
    int len = (int) strlen (seq);
    if (_solve (seq, len, 0))
      printf ("YES\n");
    else if (seq[0] == '1' && _solve (seq + 1, len - 1, 1))
      printf ("YES\n");
    else
      printf ("NO\n");
  }

  return 0;
}
