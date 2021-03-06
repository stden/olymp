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

int check() {
  z[0] = 0;
  int lzp = 0, r = 0;
  for (int i = 1; i < n; i++) { //������ z-�������
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
    
  for (int i = 1; i < n; i++) { //���� �� ���������
    if (i + z[i] >= n) return n - 1;
    if (str[i + z[i]] == '0') return i + z[i];
  }
  return n;
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
    
    str[n - 1]++;
    for (int i = n - 1; (i >= 0) && (str[i] > '1'); i--) {
      str[i] = '0'; str[i - 1]++;
    }
   
    int add = 0;
    while (1) {
      add = check();
      if (add < n) {
        while (str[add] == '1') add--;
	str[add] = '1';
	for (int i = add + 1; i < n; i++)
	  str[i] = '0';
      } else break;
    }
    printf("%s\n", str);
  }
  return 0;
}