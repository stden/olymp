#include <cstdio>
#include <cstring>

using namespace std;

char time[10], otime[10];

char t1[1000000], t2[1000000], t3[1000000];
char tmp[1000000];

const char mn[12][4] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
int cmon[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

int gettime (char a[]) {
  int tmp = ((a[1] - '0') * 10 + a[2] - '0') * 60 + (a[3] - '0') * 10 + a[4] - '0';
  if (a[0] == '-') tmp = -tmp;
  return tmp;
}

char make (int x) { if (x < 10) return '0'; else return 0; }

int main () {
  freopen ("apache.in", "rt", stdin);
  freopen ("apache.out", "wt", stdout);
  scanf ("%s\n", otime);
  int fin = gettime (otime);
  while (1) {
    int day, year, hour, min, sec, mon;
    char m[3];
    int fed = 0;
    while (1) {
      if (!gets (tmp)) { fed = 1; break; }
      if (tmp[0]) break;
    }
    if (fed) break;
    sscanf (tmp, "%s %s %s [%d/%c%c%c/%d:%d:%d:%d %s]", t1, t2, t3, &day, &m[0], &m[1], &m[2], &year, &hour, &min, &sec, time);
    if (year % 4 == 0) cmon[1] = 29; else cmon[1] = 28;
    for (int i = 0; i < 12; i++)
      if (m[0] == mn[i][0] && m[1] == mn[i][1] && m[2] == mn[i][2]) mon = i;
    int cur = gettime (time);
    min = min + hour * 60;
    min = min - cur + fin;
    while (min < 0 || min >= 1440)
    if (min >= 1440) {
      min -= 1440;
      day += 1;
      if (day > cmon[mon]) {
	day = 1;
	mon++;
	if (mon >= 12) {
	  mon = 0;
	  year++;
	}
      }
    } else
    if (min < 0) {
      min += 1440;
      day -= 1;
      if (day == 0) {
	mon--;
	if (mon < 0) {
	  mon = 11;
	  year--;
	}
	day = cmon[mon];
      }    
    }
    hour = min / 60;
    min = min % 60;
    int i;
    for (i = 0; tmp[i]; i++) {
      printf ("%c", tmp[i]);
      if (tmp[i] == '[') break; 
    }
    if (day < 10) printf ("0"); printf ("%d/", day);
    printf ("%s/%d:", mn[mon], year);
    if (hour < 10) printf ("0"); printf ("%d:", hour);
    if (min < 10) printf ("0"); printf ("%d:", min);
    if (sec < 10) printf ("0"); printf ("%d ", sec);
    printf ("%s", otime);
    for (i; tmp[i]; i++)
      if (tmp[i] == ']') break;
    for (i; tmp[i]; i++)
      printf ("%c", tmp[i]);
    printf ("\n");
  }
}