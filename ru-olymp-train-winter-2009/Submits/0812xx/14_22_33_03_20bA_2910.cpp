#include <cstdio>
#include <iostream>
#include <cstring>
#include <set>
#include <cmath>
#include <vector>

using namespace std;

#define ll long long
#define ld long double
#define mp make_pair
#define pb push_back

char a[20000], b[20000];
int n = 0, m = 0;
int aa[20000], bb[20000];

int equal () {
  if (n < m) return -1;
  if (n > m) return 1;
  for (int i = n - 1; i >= 0; i--) {
    if (aa[i] < bb[i]) return -1;
    if (aa[i] > bb[i]) return 1;
  }
  return 0;
}

int main () {
  freopen ("aplusminusb.in", "rt", stdin);
  freopen ("aplusminusb.out", "wt", stdout);
  cin >> a >> b;
  while (a[n]) { aa[n] = a[n] - '0'; n++; }
  while (b[m]) { bb[m] = b[m] - '0'; m++; }
  for (int i = 0; n - i - 1 > i; i++) {
    int tmp = aa[i];
    aa[i] = aa[n - i - 1];
    aa[n - i - 1] = tmp;
  }
  for (int i = 0; m - i - 1 > i; i++) {
    int tmp = bb[i];
    bb[i] = bb[m - i - 1];
    bb[m - i - 1] = tmp;
  }
  while (m > 1 && !bb[m - 1]) m--;
  while (n > 1 && !aa[n - 1]) n--;
  if (equal () == -1) {
    for (int i = 0; i < m; i++) {
      bb[i] -= aa[i];
      if (bb[i] < 0) {
	bb[i] += 10;
	bb[i + 1] -= 1;
      }
    }
    printf ("-");
    while (m > 1 && !bb[m - 1]) m--;
    for (int i = m - 1; i >= 0; i--) printf ("%d", bb[i]);
  } else {
    for (int i = 0; i < n; i++) {
      aa[i] -= bb[i];
      if (aa[i] < 0) {
	aa[i] += 10;
	aa[i + 1] -= 1;
      }
    }
    while (n > 1 && !aa[n - 1]) n--;
    for (int i = n - 1; i >= 0; i--) printf ("%d", aa[i]);
  }
  printf ("\n");
}