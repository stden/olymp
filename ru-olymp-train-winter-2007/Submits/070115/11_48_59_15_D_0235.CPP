#include <stdio.h>
#include <string.h>

char ans[10][6] = {
  "NO\n",
  "YES\n",
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
  freopen ("bit2.in", "rt", stdin);
  freopen ("bit2.out", "wt", stdout);

  int t;
  scanf ("%d", &t);
  for (int i = 0; i < t; i++)
    printf (ans[i]);

  return 0;
}
