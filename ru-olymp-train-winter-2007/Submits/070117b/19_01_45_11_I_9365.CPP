#include <cstdio>
#include <cstring>
#include <vector>

using namespace std;

#define m 300300

int f[m], a[m], n, pa[m];

int main( void )
{
  freopen("subseq.in", "rt", stdin);
  freopen("subseq.out", "wt", stdout);
  scanf("%d", &n);
  for (int i = 0; i < n; i++)
    scanf("%d", &a[i]);
  memset(f, -1, sizeof(f));
  memset(pa, -1, sizeof(pa));
  for (int i = 0; i < n; i++)
  {
    int mi, ma, av;
    mi = 0, ma = n;
    while (mi < ma)
    {
      av = (mi + ma + 1) >> 1;
      if (f[av] == -1 || a[i] > a[f[av]])
        ma = av - 1;
      else
        mi = av;
    }
//    fprintf(stderr, "%d %d %d %d\n", i, mi, f[mi], f[mi + 1]);
    if (f[mi + 1] == -1 || a[f[mi + 1]] <= a[i])
      f[mi + 1] = i, pa[i] = f[mi];
  }
  vector <int> ans;
  int t;
  for (t = n; t >= 0; t--)
    if (f[t] != -1)
      break;
  for (t = f[t]; t != -1; t = pa[t])
    ans.push_back(t);
  printf("%d\n", ans.size());
  for (int i = 0; i < ans.size(); i++)
    printf("%d\n", ans[ans.size() - 1 - i] + 1);
  return 0;
}
