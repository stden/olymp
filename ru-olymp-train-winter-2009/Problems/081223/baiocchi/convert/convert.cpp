#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <io.h>
#include <assert.h>
#include <algorithm>
#include <vector>


using namespace std;

#define BOFFS 0x7a

unsigned char header[BOFFS];

unsigned char data[16777216];

int hsize, vsize, csize, ccolor;

inline int getpixel (int x, int y) {
  if (x < 0 || x >= hsize || y < 0 || y >= vsize) return -1;
  return *(int *)(data + y * hsize * 4 + x * 4);
}

inline void putpixel (int x, int y, int c) {
  assert (!(x < 0 || x >= hsize || y < 0 || y >= vsize));
  *(int *)(data + y * hsize * 4 + x * 4) = c;
  //printf ("now at %d %d we have %d", x, y, getpixel (x, y));
}

unsigned char F[2000][6000];

unsigned char C[200][200];


void dfs1 (int i, int j, int pi, int pj, int ex, int ey) {
  if (F[i][j] != 0) return;
  int s = getpixel (pi, pj);
  //printf ("analyzed dfs: at %d %d we have %d\n", pi, pj, s); fflush (stdout);
  if (s == 0) F[i][j] = 1; else
  if (s == ccolor) {
    F[i][j] = 2; 
    int xlim = (ex == 0) ? csize : 1;
    int ylim = (ey == 0) ? csize : 1;
    for (int x = 0; x < xlim; x++)
      for (int y = 0; y < ylim; y++)
        putpixel (x + pi, y + pj, -1);
  } else return;

  dfs1 (i - 1, j, pi - (ex?csize:1), pj, 1 - ex, ey);
  dfs1 (i + 1, j, pi + (ex?1:csize), pj, 1 - ex, ey);
  dfs1 (i, j - 1, pi, pj - (ey?csize:1), ex, 1 - ey);
  dfs1 (i, j + 1, pi, pj + (ey?1:csize), ex, 1 - ey);
}

char cc = 128;

int flag;


void dfs3 (int i, int j, int oi, int oj, int *px, int *py, int *pc) {
  if (F[i][j] == 0) return;
  F[i][j] = 0;
  for (int dx = -1; dx <= 1; dx++)
    for (int dy = -1; dy <= 1; dy++)
      if (abs (dx) + abs (dy) == 2)
        F[i + dx][j + dy] = 0;
  /*if (pc >= 6) {
    printf ("%c\n", cc);
    flag = 1;
  }*/
  assert (*pc < 8);
  px[*pc] = i;
  py[(*pc)++] = j;
  C[oi][oj] = cc;
  for (int dx = -1; dx <= 1; dx++)
    for (int dy = -1; dy <= 1; dy++)
      if (abs (dx) + abs (dy) == 1)
        if (F[i + dx][j + dy] == 2) {
          F[i + dx][j + dy] = 0;
          dfs3 (i + dx * 2, j + dy * 2, oi + dx, oj + dy, px, py, pc);
        };
}

void dfs2 (int i, int j, int oi, int oj) {
  int px[8], py[8], pc = 0;
  dfs3 (i, j, oi, oj, px, py, &pc);

  /*printf ("%d %d %d %d %d\n", i, j, oi, oj, pc);
  for (int k = 0; k < pc; k++)
    printf ("%d %d\n", px[k] - i, py[k] - j);*/

  for (int k = 0; k < pc; k++) {
    for (int dx = -1; dx <= 1; dx++)
      for (int dy = -1; dy <= 1; dy++)
        if (abs (dx) + abs (dy) == 1) {
          assert (F[px[k] + 2 * dx][py[k] + 2 * dy] != 1);
          if (F[px[k] + 2 * dx][py[k] + 2 * dy] == 2) {
            cc++;
            dfs2 (px[k] + 2 * dx, py[k] + 2 * dy, oi + (px[k] - i) / 2 + dx, oj + (py[k] - j) / 2 + dy);
          };
        };
  };
}

unsigned char fl[256];

int px[8], py[8], pc;

void buildlist (int i, int j, int c) {
  if (C[i][j] == 0) return;
  //printf ("%d %d %d\n", i, j, c);
  C[i][j] = 0;
  assert (pc < 8);
  px[pc] = i;
  py[pc++] = j;
  for (int dx = -1; dx <= 1; dx++)
    for (int dy = -1; dy <= 1; dy++)
      if (abs (dx) + abs (dy) == 1) {
        fl[(int)C[i + dx][j + dy]] = 1;
        if (C[i + dx][j + dy] == c)
          buildlist (i + dx, j + dy, c);
      };
}


void format (int x, int y, unsigned char c) {
  memset (fl, 0, sizeof (fl));
  pc = 0;
  fl[(int)c] = 1;
  buildlist (x, y, c);

  int z;
  for (z = 'A'; fl[z]; z++);

  //printf ("%d\n", z);

  for (int k = 0; k < pc; k++)
    C[px[k]][py[k]] = z;
};

int main (int argc, char *argv[1]) {
  int h = open (argv[1], O_RDONLY | O_BINARY);
  int s = read (h, header, BOFFS);
  assert (s == BOFFS);


  hsize = *(int *)(header + 18);
  vsize = *(int *)(header + 22);

  s = read (h, data, hsize * vsize * 4);
  assert (s == hsize * vsize * 4);

  //printf ("%d x %d\n", hsize, vsize);

  assert (read (h, data, 1) == 0);

  char *tmp;

  csize = strtol (argv[2], &tmp, 0);
  ccolor = strtol (argv[3], &tmp, 0);

  /*for (int i = 0; i < hsize; i++) {
    for (int j = 0; j < vsize; j++)
      printf ("%08x", getpixel (i, j));
    printf ("\n");
  };*/
      

  for (int i = 0; i < hsize; i++)
    for (int j = 0; j < vsize; j++)
      if (getpixel (i, j) == ccolor) {
        //printf ("Started at %d, %d (%d)\n", i, j, getpixel (i, j));
        dfs1 (i + 10, j + 10, i, j, 0, 0);
      };

  /*for (int i = 0; i <= 10 + hsize * 2; i++) {
    for (int j = 0; j <= 10 +  vsize * 2; j++)
      switch (F[i][j]) {
        case 0: putchar (' '); break;
        case 1: putchar ('.'); break;
        case 2: putchar ('*'); break;
      };
    putchar ('\n');
  };*/

  for (int i = 0; i <= hsize * 2 + 10; i++)
    for (int j = 0; j <= vsize * 2 + 10; j++)
      if (F[i][j] == 2) {
        cc = 65;
        memset (C, '.', sizeof (C));
        dfs2 (i, j, 100, 100);
        cc++;

        int mnx = 199, mny = 199, mxx = 0, mxy = 0;

        for (int i = 0; i < 200; i++)
          for (int j = 0; j < 200; j++)
            if (C[i][j] != '.') {
              mnx = min (mnx, i);
              mxx = max (mxx, i);
              mny = min (mny, j);
              mxy = max (mxy, j);
            }

        for (int i = 0; i < 200; i++)
          for (int j = 0; j < 200; j++)
            if (C[i][j] > 'Z') {
              format (i, j, C[i][j]);
            };

        for (int i = mnx; i <= mxx; i++) {
          for (int j = mny; j <= mxy; j++) 
            printf ("%c", C[i][j]);
          printf ("\n");
        };
        printf ("\n");
        //if (flag) return 0;
      }
      
  return 0;
};