#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "next"

int n;
char str[10005];

int check(int &last_suf) {
  for (int i = last_suf; i < n; i++) {
    bool good = false;
    for (int i2 = i; i2 < n; i2++) {
      if (str[i2] < str[i2 - i]) {last_suf = i; return i2;}
      if (str[i2] > str[i2 - i]) {good = true; break;}
    }
    if (!good) {last_suf = i; return n - 1;}
  }
  last_suf = n;
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
    int last_suf = 1;
    while (1) {
      add = check(last_suf);
      if (add < n) {
        int oadd = add;
        while (str[add] == '1') str[add--] = '0';
	str[add] = '1';
	for (int i = oadd + 1; i < n; i++)
	  str[i] = '0';
      } else break;
    }
    printf("%s\n", str);
  }
  return 0;
}