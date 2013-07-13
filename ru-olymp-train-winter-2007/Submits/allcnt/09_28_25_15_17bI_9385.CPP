#include <stdio.h>
#include <string.h>

#include <algorithm>
using namespace std;

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

int n;

pair<int, int> ps[262144];
int seq[262144];
int prev[262144];

class tree
{
  enum {maxt = 262144};
public:
  int t[maxt + maxt];
  int v[maxt];
  
  void build ();
  int get (int l, int r);
  void set (int i, int a);
};

void tree::build ()
{
  for (int i = 0; i < n; i++)
    v[i] = 0, t[i + maxt] = i;
  for (int i = maxt - 1; i > 0; i--)
    t[i] = (v[t[i + i]] > v[t[i + i + 1]] ? t[i + i] : t[i + i + 1]);
}

int tree::get (int l, int r)
{
  int maxv = 0;
  int maxi = -1;
  l += maxt;
  r += maxt;
  if (v[t[l]] > maxv) maxi = t[l], maxv = v[maxi];
  if (v[t[r]] > maxv) maxi = t[r], maxv = v[maxi];
  while (l < r - 1)
  {
    if (v[t[l + 1]] > maxv)
      maxi = t[l + 1], maxv = v[maxi];
    if (v[t[r - 1]] > maxv)
      maxi = t[r - 1], maxv = v[maxi];
    l >>= 1, r >>= 1;
  }
  return maxi;
}

void tree::set (int i, int a)
{
  v[i] = a;
  i += maxt;
  i >>= 1;
  while (i > 0)
    t[i] = (v[t[i + i]] > v[t[i + i + 1]] ? t[i + i] : t[i + i + 1]), i >>= 1;
}

tree t;
int tg[262144];

int main ()
{
  freopen ("subseq.in", "rt", stdin);
  freopen ("subseq.out", "wt", stdout);

  scanf ("%d", &n);

  for (int i = 0; i < n; i++)
  {
    scanf ("%d", &seq[i]);
    ps[i] = make_pair (-seq[i], i);
  }
  sort (ps, ps + n);
  for (int i = 0; i < n; i++)
    tg[ps[i].second] = i;

  t.build ();

  for (int i = 0; i < n; i++)
  {
    int r = t.get (0, tg[i]);
    if (r < 0)
      t.set (tg[i], 1), prev[i] = -1;
    else
      t.set (tg[i], t.v[r] + 1), prev[i] = ps[r].second;
  }

  int mv = 0, mi = -1;
  for (int i = 0; i < n; i++)
    if (t.v[tg[i]] > mv)
      mv = t.v[tg[i]], mi = i;

  int ml = 0;
  int cur = mi;
  while (cur >= 0)
    seq[ml++] = cur, cur = prev[cur];
  sort (seq, seq + ml);
  printf ("%d\n", ml);
  for (int i = 0; i < ml; i++)
    printf ("%d ", seq[i] + 1);

  return 0;
}
