#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "next"

int n;
char str[10005];
int z[10005];

bool check() {
  z[0] = 0;
  int lzp = 0, r = 0;
  for (int i = 1; i < n; i++) { //Щитаем z-функцию
    if (r < i) {
      z[i] = 0; int i1 = 0, i2 = i;
      while (str[i1] == str[i2])
	z[i]++, i1++, i2++;
    } else
      z[i] = min(z[i - lzp], r - i + 1);
    if (r < i + z[i] - 1) {
      r = i + z[i] - 1;
      lzp = i;
    }
  }
    
  for (int i = 1; i < n; i++) { //Идем по суффиксам
    if (i + z[i] >= n) return false;
    if (str[i + z[i]] == '0') return false;
  }
  return true;
}

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  while (1) {
    memset(str, 0, sizeof str);
    fgets(str, sizeof str, stdin);
    n = strlen(str); if (!n) break;
    while ((str[n - 1] == 10) || (str[n - 1] == 13)) {
      str[--n] = 0; if (!n) break;
    }
    if (!n) continue;
       
    int i;
    for (i = n - 1; i >= 0; i--) {
      if (str[i] == '1') continue;
      str[i] = '1';
      if (check()) break;
    }
    for (i++; i < n; i++) {
      if (str[i] == '0') continue;
      str[i] = '0';
      if (!check()) str[i] = '1';
    }
    printf("%s\n", str);
  }
  return 0;
}