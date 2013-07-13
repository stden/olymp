#include <cstdio>
#include <cstring>
#include <iostream>

using namespace std;

int check (char a[]) {
  for (int i = 0; a[i]; i++)
    if (a[i] != a[0]) return 0;
  if (a[0] != '-') return 0;
  return 1;
}

char s[3000000];

int main () {
  freopen ("stress.in", "rt", stdin);
  freopen ("stress.out", "wt", stdout);
  int mt1, mt2, rnd1, rnd2;
  mt1 = mt2 = -1;
  while (1) {
    int rnd, t1, t2;
    int w = 0;
    int fin = 0;
    s[0] = 0;
    while (!check (s)) {
      if (!gets (s)) fin = 1;
      if (fin) break;
    }
    if (fin) break;
    while (1) {
      gets (s);
      if (check (s)) break;
      if (w == 2 && sscanf (s, "Work time: %d,\n", &t2)) w++;
      if (w == 1 && sscanf (s, "Work time: %d,\n", &t1)) w++;
      if (w == 0 && sscanf (s, "randseed = %d\n", &rnd)) w++;
    }
    printf ("At randseed = %d\n", rnd);    
    printf ("First: %d ms\n", t1);    
    printf ("Second: %d ms\n", t2);    
    if (t1 > mt1) {
      mt1 = t1;
      rnd1 = rnd;
    }
    if (t2 > mt2) {
      mt2 = t2;
      rnd2 = rnd;
    }
  }
  printf ("Maximal work time for first: %d at randseed = %d\n", mt1, rnd1);
  printf ("Maximal work time for second: %d at randseed = %d\n", mt2, rnd2);
}