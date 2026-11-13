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

char ans[1000][1000];
int aa[10000], bb[10000];
char a[10000], b[10000];

int add (int i, int j, int a[], int n) {
//  printf ("%d %d %d\n", i, j, n);
// for (int k = 0; k < n; k++)
//    printf ("%d", a[k]);
//  printf ("\n");
  for (int k = n - 1; k >= 0; k--)
    ans[i][j + n - k - 1] = a[k] + '0';
  return 0;
}

int equal (int aa[], int n, int bb[], int m) {
  if (n < m) return -1;
  if (n > m) return 1;
  for (int i = n - 1; i >= 0; i--) {
    if (aa[i] < bb[i]) return -1;
    if (aa[i] > bb[i]) return 1;
  }
  return 0;
}


int main () {
  freopen ("division.in", "rt", stdin);
  freopen ("division.out", "wt", stdout);
  cin >> a >> b;
  int n = 0, m = 0;
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
  memset (ans, ' ', sizeof (ans));
  add (0, 0, aa, n);
  for (int i = 0; n - i - 1 > i; i++) {
    int tmp = aa[i];
    aa[i] = aa[n - i - 1];
    aa[n - i - 1] = tmp;
  }
  int k = 0;
  int cur[1000];
  int y = 0;
  int first = 0;
  int o = 0;
  int div[200];
  for (int i = 0; i < n; i++) {
    for (int j = k; j > 0; j--)
      cur[j] = cur[j - 1];
    k++;
    cur[0] = aa[i];
    while (k > 1 && !cur[k - 1]) k--;
    int tmp = 0;
    int kk = k;
    int mul[200], l = 0;
    int ocur[200];
    for (int j = 0; j < k; j++)
      ocur[j] = cur[j];
    if (equal (cur, k, bb, m) >= 0) {
      memset (mul, 0, sizeof (mul));
      while (equal (cur, k, bb, m) >= 0) {
	tmp++;
	for (int i = 0; i < k; i++) {
	  cur[i] -= bb[i];
	  if (cur[i] < 0) {
	    cur[i] += 10;
	    cur[i + 1] -= 1;
	  }
	}	
	while (k > 1 && !cur[k - 1]) k--;
	if (m > l) l = m;
	int r = 0;
	for (int i = 0; i < l; i++) {
	  mul[i] += bb[i] + r;
	  r = mul[i] / 10;
	  mul[i] %= 10;
	}
	if (r) {
	  mul[l] = r;
	  l++;
	}
      }
    } else tmp = 0;
    if (tmp > 0) {
      if (y > 0)
	add (y, i - kk + 1, ocur, kk);
      add (y + 1, i - l + 1, mul, l);      
      if (y > 0) {
	int min = 10000;
	int max = -10000;
	for (int t = 0; t < 1000; t++) {
	  if (ans[y][t] != ' ' && t > max) max = t;
	  if (ans[y - 2][t] != ' ' && t < min) min = t;
	  if (ans[y - 3][t] != ' ' && t < min) min = t;
	}
	for (int t = min; t <= max; t++)
	  ans[y - 1][t] = '-';
      }
      y += 3;     
      first = 1;
    }
    if (first) {
      div[o] = tmp;
      o++;
    }
  }
  if (y > 0) {
    add (y, n - k, cur, k);
    int min = 10000;
    int max = -10000;
    for (int t = 0; t < 1000; t++) {
      if (ans[y][t] != ' ' && t > max) max = t;
      if (ans[y - 2][t] != ' ' && t < min) min = t;
      if (ans[y - 3][t] != ' ' && t < min) min = t;      
    }
    for (int t = min; t <= max; t++)
      ans[y - 1][t] = '-';
  }
  int max = 0;
  for (int i = 0; i <= y; i++)
    for (int t = 0; t < 1000; t++)
      if (ans[i][t] != ' ' && t > max) max = t; 
  ans[0][max + 2] = '|';
  ans[1][max + 2] = '+';
  ans[2][max + 2] = '|';
  for (int i = 0; i < m; i++)
    ans[0][max + 3 + i] = bb[m - i - 1] + '0';
  if (o == 0) {
    div[0] = 0;
    o = 1;
  }
  for (int i = 0; i < o; i++)
    ans[2][max + 3 + i] = div[i] + '0';  
  int omax = max + 3;
  if (m > o) max = max + 3 + m; else max = max + 3 + o;
  for (int i = omax; i < max; i++)
    ans[1][i] = '-';
  if (y < 2) y = 2;
  for (int i = 0; i <= y; i++) {
    for (int j = 0; j < max; j++)
      cout << ans[i][j];
    cout << endl;
  }
}