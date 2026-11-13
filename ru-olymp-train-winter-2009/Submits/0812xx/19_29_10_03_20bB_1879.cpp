#include <cstdio>
#include <iostream>
#include <cstring>
#include <cmath>

using namespace std;

#define hmod 999983

char a[4], b[4], c[4], d[4];
const int di[8] = {1, 0, -1, 0, 1, 1, -1, -1};
const int dj[8] = {0, 1, 0, -1, 1, -1, -1, 1};

char qi1[2000000], qj1[2000000], qi2[2000000], qj2[2000000], qi3[2000000], qj3[2000000], qi4[2000000], qj4[2000000], qs2[2000000], qs4[2000000], qm[2000000];
int first[999983];
int next[2000000];
int ht[2000000];
int pprev[2000000];
int l, r;

int abs (int a) { if (a > 0) return a; else return -a; }

int check (int i1, int j1, int i2, int j2, char ta, int i3, int j3, int i4, int j4) {
  if (i1 == i2 && (i3 != i1 || (i3 == i1 && (j3 < min (j1, j2) || j3 > max (j1, j2)))) && (i4 != i1 || (i4 == i1 && (j4 < min (j1, j2) || j4 > max (j1, j2))))) return 1;
  if (j1 == j2 && (j3 != j1 || (j3 == j1 && (i3 < min (i1, i2) || i3 > max (i1, i2)))) && (j4 != j1 || (j4 == j1 && (i4 < min (i1, i2) || i4 > max (i1, i2))))) return 1;
  if (ta == 'Q') {
    if (i1 + j1 == i2 + j2 && (i1 + j1 != i3 + j3 || (i1 + j1 == i3 + j3 && (i3 < min (i1, i2) || i3 > max (i1, i2)))) && (i1 + j1 != i4 + j4 || (i1 + j1 == i4 + j4 && (i4 < min (i1, i2) || i4 > max (i1, i2))))) return 1;
    if (i1 - j1 == i2 - j2 && (i1 - j1 != i3 - j3 || (i1 - j1 == i3 - j3 && (i3 < min (i1, i2) || i3 > max (i1, i2)))) && (i1 - j1 != i4 - j4 || (i1 - j1 == i4 - j4 && (i4 < min (i1, i2) || i4 > max (i1, i2))))) return 1;
  }
  return 0;
}

int cool (int i1, int j1, int i2, int j2, int i3, int j3, int i4, int j4) {
  if (abs (i1 - i2) <= 1 && abs (j1 - j2) <= 1)  return 0;
  if (i1 >= 0 && i1 <= 7 && j1 >= 0 && j1 <= 7 && (i1 != i2 || j1 != j2) && (i1 != i3 || j1 != j3) && (i1 != i4 || j1 != j4)) return 1;
  return 0;
}

int cool2 (int i1, int j1, int i2, int j2, int i3, int j3, int i4, int j4) {
  if (i1 >= 0 && i1 <= 7 && j1 >= 0 && j1 <= 7 && (i1 != i2 || j1 != j2) && (i1 != i3 || j1 != j3) && (i1 != i4 || j1 != j4)) return 1;
  return 0;
}

int was (int i1, int j1, int i2, int j2, int s2, int i3, int j3, int i4, int j4, int s4, int mm) {
  int h = ((((((((((i1 * 17 + j1) % hmod * 17 + i2) % hmod * 17 + j2) % hmod * 17 + s2) % hmod * 17 + i3) % hmod * 17 + j3) % hmod * 17 + i4) % hmod * 17 + j4) % hmod * 17 + s4) % hmod * 17 + mm) % hmod;  
  int j = first[h];
  while (j) {
    int k = j;
    if (qi1[k] == i1 && qj1[k] == j1 && qi2[k] == i2 && qj2[k] == j2 && qs2[k] == s2 && qi3[k] == i3 && qj3[k] == j3 && qi4[k] == i4 && qj4[k] == j4 && qs4[k] == s4 && qm[k] == mm) return 1;
    j = next[j];
  }
  return 0;
}

int add (int r, int i1, int j1, int i2, int j2, int s2, int i3, int j3, int i4, int j4, int s4, int mm, int prev) {
  int h = ((((((((((qi1[r] * 17 + qj1[r]) % hmod * 17 + qi2[r]) % hmod * 17 + qj2[r]) % hmod * 17 + qs2[r]) % hmod * 17 + qi3[r]) % hmod * 17 + qj3[r]) % hmod * 17 + qi4[r]) % hmod * 17 + qj4[r]) % hmod * 17 + qs4[r]) % hmod * 17 + qm[r]) % hmod;    
  next[r] = first[h];
  first[h] = r;
  pprev[r] = prev;
}

int out (int i1, int j1, int i2, int j2, char ta, int s2, int i3, int j3, int i4, int j4, char tb, int s4, int mm, int tmp) {
//  int tmp = was2 (i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm);
//  cout << endl;
//    cout << i1 << " " << j1 << " " << i2 << " " << j2 << " " << i3 << " " << j3 << " " << i4 << " " << j4 << " " << mm << endl;
//  cout << tmp << endl;
  if (pprev[tmp] == -1) return 0;
  int tmp2 = pprev[tmp];
  int pi1 = qi1[tmp2];//p1[tmp] / 10;
  int pj1 = qj1[tmp2];//p1[tmp] % 10;
  int pi3 = qi3[tmp2];//p3[tmp] / 10;
  int pj3 = qj3[tmp2];//p3[tmp] % 10;
  int pi2 = qi2[tmp2];//(p2[tmp] / 10) % 10;
  int pj2 = qj2[tmp2];//p2[tmp] % 10;
  int ps2 = qs2[tmp2];//p2[tmp] / 100;
  int pi4 = qi4[tmp2];//(p4[tmp] / 10) % 10;
  int pj4 = qj4[tmp2];//p4[tmp] % 10;
  int ps4 = qs4[tmp2];//p4[tmp] / 100;
  out (pi1, pj1, pi2, pj2, ta, ps2, pi3, pj3, pi4, pj4, tb, ps4, 1 - mm, pprev[tmp]);
//    cout << i1 << " " << j1 << " " << i2 << " " << j2 << " " << i3 << " " << j3 << " " << i4 << " " << j4 << " " << mm << endl;
//     cout << pi1 << " " << pj1 << " " << pi2 << " " << pj2 << " " << pi3 << " " << pj3 << " " << pi4 << " " << pj4 << " " << mm << endl;
  if (!mm) {
    if (pi3 != i3 || pj3 != j3) {
      printf ("K%c%c-%c%c\n", pi3 + 'a', pj3 + '1', i3 + 'a', j3 + '1');
    } else {
      printf ("%c%c%c-%c%c\n", tb, pi4 + 'a', pj4 + '1', i4 + 'a', j4 + '1');
    }
  } else {
    if (pi1 != i1 || pj1 != j1) {
      printf ("K%c%c-%c%c\n", pi1 + 'a', pj1 + '1', i1 + 'a', j1 + '1');
    } else {
      printf ("%c%c%c-%c%c\n", ta, pi2 + 'a', pj2 + '1', i2 + 'a', j2 + '1');
    }
  }
}

int main () {
  freopen ("chess.in", "rt", stdin);
  freopen ("chess.out", "wt", stdout);
  cin >> a >> b >> c >> d;
  int i1 = a[1] - 'a';
  int j1 = a[2] - '1';
  char ta = b[0];
  int i2 = b[1] - 'a';
  int j2 = b[2] - '1';
  int i3 = c[1] - 'a';
  int j3 = c[2] - '1';
  char tb = d[0];
  int i4 = d[1] - 'a';
  int j4 = d[2] - '1';
  l = 1;
  r = 2;
  qi1[1] = i1;
  qj1[1] = j1;
  qi2[1] = i2;
  qj2[1] = j2;
  qs2[1] = 1;
  qi3[1] = i3;
  qj3[1] = j3;
  qi4[1] = i4;
  qj4[1] = j4;
  qs4[1] = 1;
  qm[1] = 1;
  add (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1);
  int s2, s4, mm;
  while (l < r) {
    i1 = qi1[l];
    j1 = qj1[l];
    i2 = qi2[l];
    j2 = qj2[l];
    s2 = qs2[l];
    i3 = qi3[l];
    j3 = qj3[l];
    i4 = qi4[l];
    j4 = qj4[l];
    s4 = qs4[l]; 
    mm = qm[l];
//    cout << i1 << " " << j1 << " " << i2 << " " << j2 << " " << i3 << " " << j3 << " " << i4 << " " << j4 << " " << mm << endl;
//    cout << s2 << " " << s4 << endl;
    if (!s2 && !s4) break;
    if (mm) {
      int ch = check (i3, j3, i2 * s2 + (1 - s2) * 100, j2 * s2 + (1 - s2) * 8, ta, i1, j1, i4 * s4 + (1 - s4) * 100, j4 * s4 + (1 - s4) * 8);
//      cout << ch << endl;
      int ok = 0;
      for (int i = 0; i < 8; i++) {
	if (cool (i3 + di[i], j3 + dj[i], i1, j1, s2 * i2 + (1 - s2) * 100, s2 * j2 + (1 - s2) * 8, s4 * i4 + (1 - s4) * 100, s4 * j4 + (1 - s4) * 8)) {
	  if (!check (i3 + di[i], j3 + dj[i], s2 * i2 + (1 - s2) * 100, s2 * j2 + (1 - s2) * 8, ta, i1, j1, s4 * i4 + (1 - s4) * 100, s4 * j4 + (1 - s4) * 8)) {
	    ok = 1;
	    if (!was (i1, j1, i2, j2, s2, i3 + di[i], j3 + dj[i], i4, j4, s4, mm)) {
	      qi1[r] = i1;
	      qj1[r] = j1;
	      qi2[r] = i2;
	      qj2[r] = j2;
	      qs2[r] = s2;
	      qi3[r] = i3 + di[i];
	      qj3[r] = j3 + dj[i];
	      qi4[r] = i4;
	      qj4[r] = j4;
	      qs4[r] = s4;
	      qm[r] = 1 - mm;
	      if (r < 1999000) {
		add (r, i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm, l);
		r++;
	      }
	    }
	  }
	} else
	if (cool (i3 + di[i], j3 + dj[i], i1, j1, -1, -1, i4 * s4 + (1 - s4) * 100, j4 * s4 + (1 - s4) * 8)) {
//	  cout << i3 + di[i] << " " << j3 + dj[i] << " " << i1 << " " << j1 << endl;
	  if (!check (i3 + di[i], j3 + dj[i], 100, 8, ta, s4 * i4 + (1 - s4) * 100, i1, j1, s4 * j4 + (1 - s4) * 8)) {
	    ok = 1;
	    if (!was (i1, j1, i2, j2, 0, i3 + di[i], j3 + dj[i], i4, j4, s4, mm)) {
	      qi1[r] = i1;
	      qj1[r] = j1;
	      qi2[r] = i2;
	      qj2[r] = j2;
	      qs2[r] = 0;
	      qi3[r] = i3 + di[i];
	      qj3[r] = j3 + dj[i];
	      qi4[r] = i4;
	      qj4[r] = j4;
	      qs4[r] = s4;
	      qm[r] = 1 - mm;
	      if (r < 1999000) {
		add (r, i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm, l);
		r++;
	      }
	    }
	  }	  
	}	
      }
      if (s4)
      for (int i = 0; i < 4 + 4 * int (tb == 'Q'); i++) {
	int ni4 = i4;
	int nj4 = j4;
	while (1) {
	  ni4 += di[i];
	  nj4 += dj[i];
	  if (ni4 < 0 || ni4 > 7 || nj4 < 0 || nj4 > 7) break;
	  if (cool2 (ni4, nj4, i1, j1, i3, j3, s2 * i2 + (1 - s2) * 100, s2 * j2 + (1 - s2) * 8)) {
	    if (!check (i3, j3, s2 * i2 + (1 - s2) * 100, s2 * j2 + (1 - s2) * 8, ta, i1, j1, ni4, nj4)) {
	      ok = 1;
	      if (!was (i1, j1, i2, j2, s2, i3, j3, ni4, nj4, s4, mm)) {
		qi1[r] = i1;
		qj1[r] = j1;
		qi2[r] = i2;
		qj2[r] = j2;
		qs2[r] = s2;
		qi3[r] = i3;
		qj3[r] = j3;
		qi4[r] = ni4;
		qj4[r] = nj4;
		qs4[r] = s4;
		qm[r] = 1 - mm;
		if (r < 1999000) {
		  add (r, i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm, l);
		  r++;
		}
	      }
	    }
	  } else
	  if (cool2 (ni4, nj4, i1, j1, i3, j3, 100, 8)) {
	    if (!check (i3, j3, 100, 8, ta, i1, j1, ni4, nj4)) {
	      ok = 1;
	      if (!was (i1, j1, i2, j2, 0, i3, j3, ni4, nj4, s4, mm)) {
		qi1[r] = i1;
		qj1[r] = j1;
		qi2[r] = i2;
		qj2[r] = j2;
		qs2[r] = 0;
		qi3[r] = i3;
		qj3[r] = j3;
		qi4[r] = ni4;
		qj4[r] = nj4;
		qs4[r] = s4;
		qm[r] = 1 - mm;
		if (r < 1999000) {
		  add (r, i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm, l);
		  r++;
		}
	      }
	    }	  
	  }
	  if (ni4 == i1 && nj4 == j1) break;
	  if (ni4 == i2 && nj4 == j2 && s2) break;
	  if (ni4 == i3 && nj4 == j3) break;
	}
      }
      if (!ok) break;
    } else {
      int ch = check (i1, j1, i4 * s4 + (1 - s4) * 100, j4 * s4 + (1 - s4) * 8, tb, i3, j3, i2 * s2 + (1 - s2) * 100, j2 * s2 + (1 - s2) * 8);
//      cout << ch << endl;
      int ok = 0;
      for (int i = 0; i < 8; i++) {
	if (cool (i1 + di[i], j1 + dj[i], i3, j3, s2 * i2 + (1 - s2) * 100, s2 * j2 + (1 - s2) * 8, s4 * i4 + (1 - s4) * 100, s4 * j4 + (1 - s4) * 8)) {
	  if (!check (i1 + di[i], j1 + dj[i], i4 * s4 + (1 - s4) * 100, j4 * s4 + (1 - s4) * 8, tb, i3, j3, s2 * i2 + (1 - s2) * 100, s2 * j2 + (1 - s2) * 8)) {
	    ok = 1;
	    if (!was (i1, j1, i2, j2, s2, i3 + di[i], j3 + dj[i], i4, j4, s4, mm)) {
	      qi1[r] = i1 + di[i];
	      qj1[r] = j1 + dj[i];
	      qi2[r] = i2;
	      qj2[r] = j2;
	      qs2[r] = s2;
	      qi3[r] = i3;
	      qj3[r] = j3;
	      qi4[r] = i4;
	      qj4[r] = j4;
	      qs4[r] = s4;
	      qm[r] = 1 - mm;
	      if (r < 1999000) {
		add (r, i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm, l);
		r++;
	      }
	    }
	  }
	} else
	if (cool (i1 + di[i], j1 + dj[i], i3, j3, -1, -1, i2 * s2 + (1 - s2) * 100, j2 * s2 + (1 - s2) * 8)) {
	  if (!check (i1 + di[i], j1 + dj[i], 100, 8, tb, i3, j3, s2 * i2 + (1 - s2) * 100, s2 * j2 + (1 - s2) * 8)) {
	    ok = 1;
	    if (!was (i1 + di[i], j1 + dj[i], i2, j2, s2, i3, j3, i4, j4, 0, mm)) {
	      qi1[r] = i1 + di[i];
	      qj1[r] = j1 + dj[i];
	      qi2[r] = i2;
	      qj2[r] = j2;
	      qs2[r] = s2;
	      qi3[r] = i3;
	      qj3[r] = j3;
	      qi4[r] = i4;
	      qj4[r] = j4;
	      qs4[r] = 0;
	      qm[r] = 1 - mm;
	      if (r < 1999000) {
		add (r, i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm, l);
		r++;
	      }
	    }
	  }	  
	}	
      }
      if (s2)
      for (int i = 0; i < 4 + 4 * int (ta == 'Q'); i++) {
	int ni2 = i2;
	int nj2 = j2;
	while (1) {
	  ni2 += di[i];
	  nj2 += dj[i];
	  if (ni2 < 0 || ni2 > 7 || nj2 < 0 || nj2 > 7) break;
	  if (cool2 (ni2, nj2, i3, j3, i1, j1, s4 * i4 + (1 - s4) * 100, s4 * j4 + (1 - s4) * 8)) {
	    if (!check (i1, j1, s4 * i4 + (1 - s4) * 100, s4 * j4 + (1 - s4) * j4, tb, i3, j3, ni2, nj2)) {
	      ok = 1;
	      if (!was (i1, j1, ni2, nj2, s2, i3, j3, i4, j4, s4, mm)) {
		qi1[r] = i1;
		qj1[r] = j1;
		qi2[r] = ni2;
		qj2[r] = nj2;
		qs2[r] = s2;
		qi3[r] = i3;
		qj3[r] = j3;
		qi4[r] = i4;
		qj4[r] = j4;
		qs4[r] = s4;
		qm[r] = 1 - mm;
		if (r < 1999000) {
		  add (r, i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm, l);
		  r++;
		}
	      }
	    }
	  } else
	  if (cool2 (ni2, nj2, i3, j3, i1, j1, 100, 8)) {
	    if (!check (i1, j1, 100, 8, tb, i3, j3, ni2, nj2)) {
	      ok = 1;
	      if (!was (i1, j1, ni2, nj2, s2, i3, j3, i4, j4, 0, mm)) {
		qi1[r] = i1;
		qj1[r] = j1;
		qi2[r] = ni2;
		qj2[r] = nj2;
		qs2[r] = s2;
		qi3[r] = i3;
		qj3[r] = j3;
		qi4[r] = i4;
		qj4[r] = j4;
		qs4[r] = 0;
		qm[r] = 1 - mm;
		if (r < 1999000) {
		  add (r, i1, j1, i2, j2, s2, i3, j3, i4, j4, s4, mm, l);
		  r++;
		}
	      }
	    }	  
	  }
	  if (ni2 == i1 && nj2 == j1) break;
	  if (ni2 == i4 && nj2 == j4 && s4) break;
	  if (ni2 == i3 && nj2 == j3) break;
	}
      }
      if (!ok) break;
    }
    l++;
  }
  out (i1, j1, i2, j2, ta, s2, i3, j3, i4, j4, tb, s4, mm, l);
}