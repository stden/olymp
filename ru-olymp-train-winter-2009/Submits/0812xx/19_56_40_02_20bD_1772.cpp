#include <cstdio>
#include <cstdlib>
#include <memory.h>
#include <algorithm>
#include <vector>

using namespace std;

#define TASKNAME "multiplexor"

struct id_list {
  char* id;
  int start, end, len;
};
  
unsigned int masks[32];
struct rule {
  unsigned int ip, mask; int port;
  id_list *ids; char* pass;
  unsigned int to;
};

int rid;
bool match(rule rule, rule req) {  
  if ((rule.ip & rule.mask) != (req.ip & rule.mask))
    return false;
  if (rule.port != req.port) return false;
  if (rule.pass) {
    if (!req.pass) return false;
    if (strcmp(rule.pass, req.pass)) return false;
  }

  if (rule.ids) {
    if (!req.ids) return false;
    if (!req.ids->id) return false;
    if (rule.ids->id) {
      if (strcmp(rule.ids->id, req.ids->id)) return false;
    } else {      
      if (strlen(req.ids->id) != rule.ids->len) return false;
      int id; sscanf(req.ids->id, "%d", &id);
      if ((id < rule.ids->start) || (rule.ids->end < id)) return false;
    }
  }
  return true;
}

void readrule(int port, rule &nr) {
  int a, b, c, d; char ch;
  scanf("%d.%d.%d.%d%c", &a, &b, &c, &d, &ch);
  nr.ip = (a << 24) | (b << 16) | (c << 8) | d;
  nr.port = port;
  nr.mask = 0xFFFFFFFF;
  if (ch == '/') {
    int tmp;
    scanf("%d", &tmp);
    if (tmp && (tmp <= 32))
      nr.mask ^= (1 << (32 - tmp)) - 1;    
    if (!tmp) nr.mask = 0;
  }
	
  if (port >= 0) {
    scanf(" T %d.%d.%d.%d", &a, &b, &c, &d); 
    nr.to = (a << 24) | (b << 16) | (c << 8) | d;
  } else {
    scanf(" T %d", &a);
    nr.port = a;
  }
	
  bool cont = true;
  while (cont) {
    do {
      ch = getc(stdin);
    } while ((ch == 32) || (ch == 9));
    int l = 0;
    switch (ch) {
      case 'I':
	nr.ids = (id_list*)malloc(sizeof(id_list));
	nr.ids->id = (char*)malloc(65);
	nr.ids->len = 0;
	
	memset(nr.ids->id, 0, sizeof nr.ids->id);
	scanf(" ");
	while (1) {
	  ch = getc(stdin);
	  if ((ch > 32) && (ch < 128)) {
	    nr.ids->id[nr.ids->len++] = ch;
	  } else break;
	};
	if (sscanf(nr.ids->id, "%d-%d", 
	           &nr.ids->start, &nr.ids->end) >= 2) {
	  char buf[30]; memset(buf, 0, sizeof buf);
	  char format[] = "%0*d-%0*d";
	  int l = (nr.ids->len - 1) >> 1;
	  if (l <= 5)  {
	    format[2] = l + '0';
	    format[7] = l + '0';
	    sprintf(buf, format,
		     nr.ids->start, nr.ids->end);
            if (!strcmp(nr.ids->id, buf)) {
	      free(nr.ids->id); nr.ids->id = 0;
	      nr.ids->len = l;
	    }
	  }
	};
        ungetc(ch, stdin);
	break;
      case 'P':
	nr.pass = (char*)malloc(65);
	memset(nr.pass, 0, sizeof nr.pass);
	scanf(" ");
	while (1) {
	  ch = getc(stdin);
	  if ((ch > 32) && (ch < 128))
	    nr.pass[l++] = ch;
	  else break;
	}
	ungetc(ch, stdin);
	break;
      default:cont = false; break;
    }
  }
}

int main() {
  freopen(TASKNAME ".in", "r", stdin);
  freopen(TASKNAME ".out", "w", stdout);
  
  vector<rule> rs;
  int port = 0;
  bool cont0 = true;
  while (cont0) {
    rule nr;
    memset(&nr, 0, sizeof nr);
    char ch; scanf(" %c", &ch);
    switch (ch) {
      case 'A':scanf("%d\n", &port); break;
      case 'F':{
	readrule(port, nr);
	rs.push_back(nr);
	break;}
      default:cont0 = false; break;
    }
    /*if (nr.ids) {
      if (nr.ids->id)
        printf("|%s|\n", nr.ids->id);
      else
	printf("%d-%d (%d)\n",
		nr.ids->start,
		nr.ids->end,
		nr.ids->len);
    }*/
    fflush(stdout);
  }
  scanf("--\n"); rid = -1;
  //printf("+\n"); fflush(stdout);
  while (1) {
    rule req;
    memset(&req, 0, sizeof req);
    char ch; if (scanf(" %c", &ch) == EOF) break;
    //printf("|%c|\n", ch); fflush(stdout);
    readrule(-1, req); rid++;
    //printf("F %d/%d\n", req.ip, req.mask);
    bool good = false;
    for (int i = 0; i < rs.size(); i++)
      if (match(rs[i], req)) {
	int a, b, c, d;
	a = (rs[i].to >> 24) & 0xFF;
	b = (rs[i].to >> 16) & 0xFF;
	c = (rs[i].to >>  8) & 0xFF;
	d =  rs[i].to        & 0xFF;
	printf("%d.%d.%d.%d\n", a, b, c, d); good = true;
        break;
      }
    if (!good) printf("/dev/null\n");
  }
  return 0;
}