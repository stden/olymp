#include <stdio.h>
#include <string.h>

bool acc (unsigned char c)
{
  return (c >= 33) && (c <= 126);
}



char x[10001];
char y[200001];
int kmp[10001];
int cx = 0, cy = 0;

int main ()
{
  freopen ("substr.in", "rt", stdin);
  freopen ("substr.out", "wt", stdout);

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
  x[cx++] = ' ';
  x[cx] = 0;
  y[cy] = 0;

  kmp[0] = 0;
  for (int i = 1; x[i]; i++)
  {
    int cur = kmp[i - 1];
    while (cur > 0 && x[cur] != x[i])
      cur = kmp[cur - 1];
    if (x[cur] == x[i])
      kmp[i] = cur + 1;
    else
      kmp[i] = 0;
  }
  int lval = 0;
  for (int i = 0; y[i]; i++)
  {
    int cur = lval;
    while (cur > 0 && x[cur] != y[i])
      cur = kmp[cur - 1];
    if (x[cur] == y[i])
      lval = cur + 1;
    else
      lval = 0;
    if (lval == cx - 1)
      printf ("%d\n", i - cx + 3);
  }
/*
  int cur = 0;
  while (true)
  {
    int pos = b.find (a, cur);
    if (pos == string::npos)
      break;
    printf ("%d ", pos + 1);
    cur = pos + 1;
  }
  */
  return 0;
}
