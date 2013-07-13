#include <cstdio>
#include <cstring>

using namespace std;

char s[200];

int main () {
  freopen ("calls.in", "rt", stdin);
  freopen ("calls.out", "wt", stdout);
  int start = -1, sm, sd, sy, ssh, ssm, sss, wr, rd, twr = 0, trd = 0, all = 0, cost = 0, speed, ss, time, ok = 0; 
  while (1) {
    if (!gets (s)) break;
    if (!s[0]) continue;
    int mon, day, year, hour, min, sec, msec;
    if (!sscanf (s, "%d-%d-%d %d:%d:%d.%d", &mon, &day, &year, &hour, &min, &sec, &msec)) continue;
    int n = 0;
    while (!s[n]) n++;
    while (s[n - 1] == ' ') {
      s[n - 1] = 0;
      n--;
    }
    int cur = hour * 60 * 60 + min * 60 + sec;
    char scur[200];
    memset (scur, 0, sizeof (scur));
    int m = 0;
    for (int i = 25; s[i]; i++) { scur[m] = s[i]; m++; }
    if (start == -1 && sscanf (scur, "Connection established at %dbps.\n", &speed)) {
      char tmp[200];
      memset (tmp, 0, sizeof (tmp));
      int m = 0;
      for (int i = 25; s[i]; i++) { if (s[i] < '0' || s[i] > '9') {tmp[m] = s[i]; m++;} }
      if (strcmp (tmp, "Connection established at bps.") == 0) {
	start = cur;
	sm = mon;
	sd = day;
	sy = year;
	ssh = hour;
	ssm = min;
	sss = sec;
	ss = speed;
      }
    }
    if (start != -1 && strcmp (scur, "Hanging up the modem.") == 0) {
      time = (cur - start);
      if (time < 0) time += 24 * 60 * 60;
      all += time;
      if (time >= 60) cost += time;
      start = -1;
      ok = 2;
    }
    memset (scur, 0, sizeof (scur));
    m = 0;
    for (int i = 25; s[i]; i++) { if (s[i] != ' ') {scur[m] = s[i]; m++;} }
    if (ok > 0 && sscanf (scur, "Writes:%dbytes", &wr)) {
      char tmp[200];
      memset (tmp, 0, sizeof (tmp));
      int m = 0;
      for (int i = 25; s[i]; i++) { if ((s[i] < '0' || s[i] > '9') && s[i] != ' ') {tmp[m] = s[i]; m++;} }
      if (strcmp (tmp, "Writes:bytes") == 0 || strcmp (tmp, "Writes:bytes.") == 0) {
      ok--;
      if (!ok) {
	if (sm < 10) printf ("0");printf ("%d-", sm);
	if (sd < 10) printf ("0");printf ("%d-", sd);
	if (sy < 1000) printf ("0");
	if (sy < 100) printf ("0");
	if (sy < 10) printf ("0");
	printf ("%d ", sy);
	if (ssh < 10) printf ("0");printf ("%d:", ssh);
	if (ssm < 10) printf ("0");printf ("%d:", ssm);
	if (sss < 10) printf ("0");printf ("%d    ", sss);      
	printf ("%d %d %d/%d\n", time, ss, rd, wr);
	trd += rd;
	twr += wr;
      } }
    }
    if (ok > 0 && sscanf (scur, "Reads:%dbytes", &rd)) {
      char tmp[200];
      memset (tmp, 0, sizeof (tmp));
      int m = 0;
      for (int i = 25; s[i]; i++) { if ((s[i] < '0' || s[i] > '9') && s[i] != ' ') {tmp[m] = s[i]; m++;} }
      if (strcmp (tmp, "Reads:bytes") == 0 || strcmp (tmp, "Reads:bytes.") == 0) {
      ok--;
      if (!ok) {
	if (sm < 10) printf ("0");printf ("%d-", sm);
	if (sd < 10) printf ("0");printf ("%d-", sd);
	if (sy < 1000) printf ("0");
	if (sy < 100) printf ("0");
	if (sy < 10) printf ("0");
	printf ("%d ", sy);
	if (ssh < 10) printf ("0");printf ("%d:", ssh);
	if (ssm < 10) printf ("0");printf ("%d:", ssm);
	if (sss < 10) printf ("0");printf ("%d    ", sss);      
	printf ("%d %d %d/%d\n", time, ss, rd, wr);
	trd += rd;
	twr += wr;
      }}
    }
  }
  printf ("Total seconds to pay = %d, total seconds = %d; total bytes %d/%d\n", cost, all, trd, twr);
}