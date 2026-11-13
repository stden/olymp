#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;
 
#define TASKNAME "apache"

typedef char char4[4];

int _dinm[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
char4 month[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
inline int dinm(int mo, int ye) {
  return ((mo == 1) && !(ye & 3)) ? 29 : _dinm[mo];
}
void nextdate(int *da, int *mo, int *ye) {
  (*da)++;
  if (*da > dinm(*mo, *ye)) {*da = 1; (*mo)++;}
  if (*mo > 12) {*mo = 0; (*ye)++;}
}
void prevdate(int *da, int *mo, int *ye) {
  (*da)--;
  if (*da < 1) {
    (*mo)--; if (*mo < 0) {*mo = 11; (*ye)--;}
    *da = dinm(*mo, *ye);
  }
}

char buf[1024];
int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  char nc[16];
  fgets(nc, sizeof nc, stdin);  
  int nh = (nc[1] - '0') * 10 + (nc[2] - '0');
  int nm = (nc[3] - '0') * 10 + (nc[4] - '0');  
  nc[5] = 0;
  if (nc[0] == '-') nh = -nh, nm = -nm;  
  while (1) {
    int ia, ib, ic, id;
    int da, mo, ye, h, m, s;
    char c[5];
    memset(buf, 0, sizeof buf);

    if (scanf("%d", &ia) == EOF) break;
    scanf(".%d.%d.%d - ", &ib, &ic, &id);
    printf("%d.%d.%d.%d - ", ia, ib, ic, id);
    while (1) {
      scanf("%s", buf); printf(buf);
      if (strlen(buf) < sizeof buf) break;
      char ch;
      scanf("%c", &ch); if (ch <= 32) break;
      fseek(stdin, -1, SEEK_CUR);
    }
    char _mo[4]; _mo[3] = 0;
    scanf(" [%d/%c%c%c/%d:%d:%d:%d %c%c%c%c%c]",
	   &da, &_mo[0], &_mo[1], &_mo[2],
	    &ye, &h, &m, &s, &c[0], &c[1], &c[2], &c[3], &c[4]);
    for (mo = 0; mo < 12; mo++)
      if (!strcmp(_mo, month[mo])) break;
    int curh = (c[1] - '0') * 10 + (c[2] - '0');
    int curm = (c[3] - '0') * 10 + (c[4] - '0');
    if (c[0] == '-') curh = -curh, curm = -curm;
    
    int plush, plusm;
    plush = nh - curh; plusm = nm - curm;
    plush += plusm / 60; plusm %= 60;
    if (plusm < 0) {plusm += 60; plush--;}
    
    h += plush; m += plusm;
    if (m >= 60) {m -= 60; h++;}
    while (h < 0) {prevdate(&da, &mo, &ye); h += 24;}
    while (h >= 24) {nextdate(&da, &mo, &ye); h -= 24;}
    
    printf(" [%02d/%s/%04d:%02d:%02d:%02d %s]", da, month[mo], ye, h, m, s, nc);
    while (1) {
      fgets(buf, sizeof buf, stdin); printf(buf);
      int l = strlen(buf);
      if (l + 1 < sizeof buf) break;
    }
  }
  
  return 0;
}