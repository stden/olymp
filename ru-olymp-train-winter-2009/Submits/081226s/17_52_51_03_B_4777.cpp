#include <cstdio>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

#define mp make_pair
#define pb push_back

int o;
int p, k, a;
int q[10000];
vector< pair<int, int> > qs;

int power (int x, int y, int p) {
  int tmp = 1;
  while (y) {
    if (y % 2) tmp = (((long long)(tmp)) * x) % p;
    y /= 2;
    x = (((long long)(x)) * x) % p;
  }
  return tmp;
}

int check (int x) {
  for (int i = 0; i < o; i++)
    if (power (x, (p - 1) / q[i], p) == 1) return 0;
  return 1;
}

bool myless (pair <int, int> a, pair <int, int> b) {
  return (a.first < b.first || a.first == b.first && a.second < b.second);
}

int dlog (int x, int y, int p) {
  int dt = sqrt (p) + 1;
  int pdt = power (x, dt, p);
  int cur = 1;
  for (int i = 1; i < dt + 3; i++) {
    cur = ((long long)(cur) * pdt) % p;
    qs.pb (mp (cur, i * dt));
  }
  cur = y;
  for (int i = 0; i < dt + 3; i++) {
    qs.pb (mp (cur, -i));
    cur = ((long long)(cur) * x) % p;
  }
  sort (qs.begin (), qs.end (), myless);
  int ans = 0;
  for (int i = 0; i + 1 < qs.size (); i++)
    if (qs[i].first == qs[i + 1].first && qs[i].second <= 0 && qs[i + 1].second > 0) 
      return qs[i + 1].second + qs[i].second;
  return 0;
}

int gcd (int a, int b) { if (a == 0) return b; else return gcd (b % a, a); }

int get (int a, int b, int* aa, int* bb) {
  if (a == 0) {
    *aa = 0;
    *bb = 1;
//    printf ("%d * %d + %d * %d = %d\n", a, *aa, b, *bb, b);
    return b;
  } else {
    int d = get (b % a, a, aa, bb);
    int tmp = b / a;
    int cc = *aa;
    *aa = ((*bb) - tmp * (*aa));
    *bb = cc;
//    printf ("%d * %d + %d * %d = %d\n", a, *aa, b, *bb, d);
    return d;
  }
}

int main () {
  freopen ("roots.in", "rt", stdin);
  freopen ("roots.out", "wt", stdout);
  scanf ("%d%d%d", &p, &k, &a);
  if (!a) {
    printf ("1\n0\n");
    return 0;
  }
  int pp = p - 1;
  for (int i = 2; i * i < p; i++)
    if (pp % i == 0) {
      q[o] = i;
      while (pp % i == 0) pp /= i;
      o++;
    }
  if (pp > 1) {
    q[o] = pp;
    o++;
  }
  int root = 1;
  while (!check (root)) root++;
  int sa = dlog (root, a, p);
  if (power (root, sa, p) != a) return 239;
  sa %= (p - 1);
  int d = gcd (k, p - 1);
//  printf ("%d %d\n", root, sa);
  int kk = k;
/*  if (sa % d == 0) {
    int tmp = (p - 1) / d;
    k /= d; sa /= d;
    int aa, bb;
    get (k, tmp, &aa, &bb);
//    printf ("%d * %d + %d * %d = %d\n", aa, k, bb, tmp, 1);
    aa *= sa;
    aa %= (p - 1);
    if (aa < 0) aa += (p - 1);
    vector<int> ans;
    int paa = aa; 
    while (1) {
      ans.pb (power (root, aa, p));
      aa += tmp;
      if (aa >= p - 1) aa %= (p - 1);
      if (aa == paa) break;
    }
    sort (ans.begin (), ans.end ());
    printf ("%d\n", ans.size ());
    for (int i = 0; i < ans.size (); i++)
      printf ("%d\n", ans[i]);
  } else printf ("0\n");*/
  vector<int> ans;
  for (int s = 0; s < p - 1; s++)
    if ((s * kk) % (p - 1) == sa) ans.pb(power (root, s, p));
    sort (ans.begin (), ans.end ());
    printf ("%d\n", ans.size ());
    for (int i = 0; i < ans.size (); i++)
      printf ("%d\n", ans[i]);
}