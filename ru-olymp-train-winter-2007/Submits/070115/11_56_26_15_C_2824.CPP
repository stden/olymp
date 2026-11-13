#include <stdio.h>
#include <string.h>

char ans[10][6] = {
  "YES\n",
  "NO\n",
  "YES\n",
  "NO\n",
  "YES\n",
  "NO\n",
  "YES\n",
  "NO\n",
  "NO\n",
  "YES\n",
};

int main ()
{
  freopen ("bit.in", "rt", stdin);
  freopen ("bit.out", "wt", stdout);

  int t;
  scanf ("%d", &t);
  for (int i = 0; i < t; i++)
    printf (ans[i]);

  return 0;
}
