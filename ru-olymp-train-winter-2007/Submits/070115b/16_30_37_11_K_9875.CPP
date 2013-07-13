#include <cstdio>
#include <algorithm>

using namespace std;

#define m 110000

int st[m], en[m], n;

int main( void )
{
  freopen("segments.in", "rt", stdin);
  freopen("segments.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
  {
    scanf("%d%d", &st[i], &en[i]);
    if (st[i] > en[i])
      swap(st[i], en[i]);
  }
  sort(st, st + n);
  sort(en, en + n);
  int i, j, nu, ans, xx;
  i = j = nu = ans = xx = 0;
  while (i < n || j < n)
    if (i < n && (j >= n || st[i] <= en[j]))
    {
      nu++;
      if (ans < nu)
        ans = nu, xx = st[i];
      i++;
    }
    else
      nu--, j++;
  printf("%d %d", ans, xx);
  return 0;
}
