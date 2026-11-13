#include <cstdio>
#include <cstring>
#include <algorithm>
#include <iostream>

using namespace std;

int ec[1000], ee[1000], es[1000];
int n, m;
string ss[1000000];
int sp[1000000]; 
long long sl[1000000];

bool myless (int i, int j) { return (sl[i] < sl[j]); }

int main () {
  freopen ("cuts.in", "rt", stdin);
  freopen ("cuts.out", "wt", stdout);
  scanf ("%d%d", &n, &m);
  for (int i = 0; i < m; i++) {
    int a, b, c;
    scanf ("%d%d%d", &a, &b, &c);
    ee[i] = b;
    es[i] = a;
    ec[i] = c;
  }
  int tt;
  scanf ("%d", &tt);
  int o = 0;
  for (int i = (1 << (n - 1)); i < (1 << n); i += 2) {
    int cut[100];
    string scut;
    for (int j = 0; j < n; j++) {
      cut[j + 1] = ((i >> j) & 1);
      scut += cut[j + 1] + '0';
    }
    long long tmp = 0;
    for (int j = 0; j < m; j++)
      if (ec[j] > 0 && cut[es[j]] == 0 && cut[ee[j]] == 1) tmp += ec[j];
    ss[o] = scut;
    sl[o] = tmp;
    sp[o] = o;
    o++;
  }
  sort (sp, sp + o, myless);
   for (int i = 0; i < tt; i++) {
//  printf ("%lld\n", sl[sp[i]]);
  cout << ss[sp[i]] << endl;
  }
}