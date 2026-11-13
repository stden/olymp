#include <cstdio>
#include <cstring>
#include <iostream>
#include <algorithm>

using namespace std;

int ec[2000], ef[2000], pr[2000], next[2000], ee[2000], es[2000];
int first[100], mark[100], prev[100], cut[100];
int n, m;

string ss[1000000];
int sp[1000000]; 
long long sl[1000000];

bool myless (int i, int j) { return (sl[i] < sl[j]); }

int calc (int a, int b) {
  int q[100];
  int r = 1;
  int l = 0;
  q[0] = a;
  for (int i = 1; i <= n; i++) mark[i] = 0;
  mark[a] = 1;
  while (l < r) {
    int x = q[l];
    l++;
    int j = first[x];
    while (j) {
      if (ef[j] > 0 && !mark[ee[j]]) {
	q[r] = ee[j];
	prev[ee[j]] = pr[j];
	mark[ee[j]] = 1;
	r++;
      }
      j = next[j];
    }
    if (mark[b]) break;
  }
  if (!mark[b]) return 0; else return 1;
}

int dfs (int x) {
  cut[x] = 1;
  int j = first[x];
  while (j) {
    int i = ee[j];
    if (!cut[i] && ef[j] > 0) dfs (i);
    j = next[j];
  }
}

int main () {
  freopen ("cuts.in", "rt", stdin);
  freopen ("cuts.out", "wt", stdout);
  scanf ("%d%d", &n, &m);
  int o = 0;
  for (int i = 0; i < m; i++) {
    int a, b, c;
    scanf ("%d%d%d", &a, &b, &c);
    o++;
    ee[o] = b;
    es[o] = a;
    ec[o] = c;
    ef[o] = c;
    next[o] = first[a];
    first[a] = o;
    pr[o] = o + 1;
    o++;
    ee[o] = a;
    es[o] = b;
    ec[o] = 0;
    ef[o] = 0;
    next[o] = first[b];
    first[b] = o;
    pr[o] = o - 1;
  }
  int tt;
  scanf ("%d", &tt);
  if (tt == 1) {
  while (calc (1, n)) {
    int tmp = 2000000000;
    int i = n;
    while (i != 1) {
      int j = prev[i];
      if (ef[pr[j]] < tmp) tmp = ef[pr[j]];
      i = ee[j];
    }
    i = n;
    while (i != 1) {
      int j = prev[i];
      ef[j] += tmp;
      ef[pr[j]] -= tmp;
      i = ee[j];
    }
  }
  memset (cut, 0, sizeof (cut));
  dfs (1);
  for (int i = 1; i <= n; i++) cut[i] = 1 - cut[i];
  long long ans = 0;
  for (int i = 1; i <= o; i++)
    if (ec[i] > 0 && cut[es[i]] == 0 && cut[ee[i]] == 1) ans += ec[i];
//  printf ("%lld\n", ans);
  for (int i = 1; i <= n; i++)
    printf ("%d", cut[i]);
  } else {
    int qo = 0;
    for (int i = (1 << (n - 1)); i < (1 << n); i += 2) {
      int cut[100];
      string scut;
      for (int j = 0; j < n; j++) {
	cut[j + 1] = ((i >> j) & 1);
	scut += cut[j + 1] + '0';
      }
      long long tmp = 0;
      for (int j = 0; j < o; j++)
	if (ec[j] > 0 && cut[es[j]] == 0 && cut[ee[j]] == 1) tmp += ec[j];
      ss[qo] = scut;
      sl[qo] = tmp;
      sp[qo] = qo;
      qo++;
    }
    sort (sp, sp + qo, myless);
    for (int i = 0; i < tt; i++) {
//      printf ("%lld\n", sl[sp[i]]);
      cout << ss[sp[i]] << endl;
    }  
  }
}