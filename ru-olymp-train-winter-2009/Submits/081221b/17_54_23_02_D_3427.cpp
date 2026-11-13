#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>
#include <time.h>

#define abs(x) ((x) < 0 ? -(x) : (x))

using namespace std;

#define TASKNAME "calls"

struct conn {
  int d, m, y, h, mi, s;
  int paylen, len, spd, read, wrote;
};

bool parse2(char ch[], int *res) {
  if ((ch[0] < '0') || (ch[0] > '9')) return false;
  if ((ch[1] < '0') || (ch[1] > '9')) return false;
  *res = (ch[0] - '0') * 10 + (ch[1] - '0');
  return true;
}
bool parse4(char ch[], int *res) {
  if ((ch[0] < '0') || (ch[0] > '9')) return false;
  if ((ch[1] < '0') || (ch[1] > '9')) return false;
  if ((ch[2] < '0') || (ch[2] > '9')) return false;
  if ((ch[3] < '0') || (ch[3] > '9')) return false;
  *res = (ch[0] - '0') * 1000 + (ch[1] - '0') * 100 + (ch[2] - '0') * 10 + (ch[3] - '0');
  return true;
}

int diff(int d, int m, int y, int h, int mi, int s, conn c) {
  tm t;
  t.tm_mday = d; t.tm_mon = m; t.tm_year = y - 1900;
  t.tm_hour = h; t.tm_min = mi; t.tm_sec = s;
  t.tm_wday = t.tm_yday = -1; t.tm_isdst = 0;
  time_t t1 = mktime(&t);
  
  t.tm_mday = c.d; t.tm_mon = c.m; t.tm_year = c.y - 1900;
  t.tm_hour = c.h; t.tm_min = c.mi; t.tm_sec = c.s;
  t.tm_wday = t.tm_yday = -1; t.tm_isdst = 0;  
  time_t t2 = mktime(&t);
  double res = abs(difftime(t1, t2));
  return int(res);
}

char buf[1024];
int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);

  vector<conn> conns;
  int connected = 0;
  while (1) {    
    if (!fgets(buf, sizeof buf, stdin)) break;
    
    int blen = strlen(buf);
    if (blen < 25) continue;
    if (blen > 200) {
      if (blen + 1 < sizeof buf) continue;
      while ((buf[blen - 1] != 10) && (buf[blen - 1] != 13)) {
	fgets(buf, sizeof buf, stdin);
	blen = strlen(buf);
      }
      char ch = getc(stdin);
      if ((ch != 10) && (ch != 13)) ungetc(ch, stdin);
      continue;
    }
    char m0[2], d0[2], y0[4], h0[2], mi0[2], sa0[2], sb0[2];

    int i = 0;
    d0[0] = buf[i++]; d0[1] = buf[i++];
    if (buf[i++] != '-') continue;
    m0[0] = buf[i++]; m0[1] = buf[i++];
    if (buf[i++] != '-') continue;
    y0[0] = buf[i++]; y0[1] = buf[i++]; y0[2] = buf[i++]; y0[3] = buf[i++];
    if (buf[i++] != ' ') continue;
    
    h0[0] = buf[i++]; h0[1] = buf[i++];
    if (buf[i++] != ':') continue;
    mi0[0] = buf[i++]; mi0[1] = buf[i++];
    if (buf[i++] != ':') continue;    
    sa0[0] = buf[i++]; sa0[1] = buf[i++];
    if (buf[i++] != '.') continue;        
    sb0[0] = buf[i++]; sb0[1] = buf[i++];
    if ((buf[i] != ' ') || (buf[i + 1] != '-') || (buf[i + 2] != ' ')) continue;
    i += 3;
    
    int d, m, y, h, mi, sa, sb;
    if (!parse2(d0, &d)) continue;
    if (!parse2(m0, &m)) continue;
    if (!parse4(y0, &y)) continue;
    if (!parse2(h0, &h)) continue;
    if (!parse2(mi0, &mi)) continue;
    if (!parse2(sa0, &sa)) continue;
    if (!parse2(sb0, &sb)) continue;      
    
    int spd; i--;
    if (sscanf(buf + i, " Connection established at %dbps.\n", &spd)) {
      conn nc;
      nc.d = d; nc.m = m; nc.y = y;
      nc.h = h; nc.mi = mi; nc.s = sa;
      nc.spd = spd;
      conns.push_back(nc);
      connected = 1;
    }
    if (!strcmp(buf + i, " Hanging up the modem.\n") && (connected == 1)) {
      int i = conns.size() - 1;
      conns[i].len = diff(d, m, y, h, mi, sa, conns[i]);
      conns[i].paylen = conns[i].len;
      if (conns[i].paylen < 60) conns[i].paylen = 0;
      connected = 3;
    }
    int rorw;
    if ((connected & 3) == 3) {
      if ((sscanf(buf + i, " Reads : %d bytes", &rorw) > 0) ||
	  (sscanf(buf + i, " Reads: %d bytes", &rorw) > 0)) {
	conns[conns.size() - 1].read = rorw;
	connected += 4;
      }
      if ((sscanf(buf + i, " Writes : %d bytes", &rorw) > 0) ||
	  (sscanf(buf + i, " Writes: %d bytes", &rorw) > 0)) {
	conns[conns.size() - 1].wrote = rorw;
	connected += 8;
      }
      if (connected == 15) connected = 0;
    }
  }
  int topay, total, read, wrote;
  topay = total = read = wrote = 0;
  for (int i = 0; i < conns.size(); i++) {
    topay += conns[i].paylen;
    total += conns[i].len;
    read += conns[i].read;
    wrote += conns[i].wrote;
    printf("%02d-%02d-%04d %02d:%02d:%02d    %d %d %d/%d\n",
	   conns[i].d, conns[i].m, conns[i].y,
	   conns[i].h, conns[i].mi, conns[i].s,
	   conns[i].len, conns[i].spd, conns[i].read, conns[i].wrote);
  }
  printf("Total seconds to pay = %d, total seconds = %d; total bytes %d/%d\n",
	  topay, total, read, wrote);
  
  return 0;
}