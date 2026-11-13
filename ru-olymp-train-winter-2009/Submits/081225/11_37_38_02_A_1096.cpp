#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "palin"
#define MAXN 3000000

char str[MAXN + 10];
bool where[MAXN];
int n;

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  while (1) {
    memset(str, 0, sizeof str);
    fgets(str, sizeof str, stdin);
    n = strlen(str); if (!n) break;
    while ((str[n - 1] == 10) || (str[n - 1] == 13))
      if (--n >= 0) str[n] = 0; else break;
    if (!n) continue;
    
    bool ispal = true;
    int a = 0, b = n - 1;
    for (; a < b; a++, b--) ispal = ispal && (str[a] == str[b]);
    if (ispal) {
      printf("1\n%s\n", str);
      continue;
    }
    int c0, c1;
    memset(where, 0, sizeof where);
    
    int ans1 = 0, ans2 = 0;
    a = 0; b = n -1;
    while (a < b) {      
      if (str[a] == str[b]) {a++; b--; continue;}
      if (str[a] == '0') {where[a++] = 1; ans1++;}
      else {where[b--] = 1; ans1++;}
    }
    a = 0; b = n - 1;
    while (a < b) {
      if (str[a] == str[b]) {a++; b--; continue;}
      if (str[a] == '1') {a++; ans2++;}
      else {b--; ans2++;}
    }
    if (ans2 < ans1) {
      memset(where, 0, sizeof where);
      a = 0; b = n - 1;
      while (a < b) {
	if (str[a] == str[b]) {a++; b--; continue;}
	if (str[a] == '1') {where[a++] = 1; ans2++;}
	else {where[b--] = 1; ans2++;}
      }      
    }
    
    printf("2\n");
    for (int i = 0; i < n; i++)
      if (where[i]) printf("%c", str[i]); printf("\n");
    for (int i = 0; i < n; i++)
      if (!where[i]) printf("%c", str[i]); printf("\n");
  }
  return 0;
}