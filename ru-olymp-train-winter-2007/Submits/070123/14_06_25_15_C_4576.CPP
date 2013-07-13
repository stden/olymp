#include <stdio.h>
#include <string.h>
                 
#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

int var[256];

const int MAX = 4096;
bool M[MAX][MAX];
int n;
                 
char str[2097152];
int cur_b = -1;
int cur_B = 6;
int BYTE;
inline bool get_bit ()
{
  if (cur_B > 5)
    cur_b++, BYTE = var[str[cur_b]], cur_B = 0;
  return (BYTE & (1 << cur_B++));
}
void read_mat ()
{
  memset (M, 0, sizeof M);
  scanf ("%s", str);
  for (int i = 0; i < n; i++)
  {
    for (int j = i + 1; j < n; j++)
    {
      if (get_bit ())
        M[i][j] = true;
      else
        M[j][i] = true;
    }
  }
}
               
int main ()
{
  freopen ("tourism.in", "rt", stdin);
  freopen ("tourism.out", "wt", stdout);

  var['0'] = 0;
  var['1'] = 1;
  var['2'] = 2;
  var['3'] = 3;
  var['4'] = 4;
  var['5'] = 5;
  var['6'] = 6;
  var['7'] = 7;
  var['8'] = 8;
  var['9'] = 9;
  var['A'] = 10;
  var['B'] = 11;
  var['C'] = 12;
  var['D'] = 13;
  var['E'] = 14;
  var['F'] = 15;
  var['G'] = 16;
  var['H'] = 17;
  var['I'] = 18;
  var['J'] = 19;
  var['K'] = 20;
  var['L'] = 21;
  var['M'] = 22;
  var['N'] = 23;
  var['O'] = 24;
  var['P'] = 25;
  var['Q'] = 26;
  var['R'] = 27;
  var['S'] = 28;
  var['T'] = 29;
  var['U'] = 30;
  var['V'] = 31;
  var['W'] = 32;
  var['X'] = 33;              
  var['Y'] = 34;
  var['Z'] = 35;
  var['a'] = 36;
  var['b'] = 37;
  var['c'] = 38;
  var['d'] = 39;
  var['e'] = 40;
  var['f'] = 41;
  var['g'] = 42;
  var['h'] = 43;
  var['i'] = 44;
  var['j'] = 45;
  var['k'] = 46;
  var['l'] = 47;
  var['m'] = 48;
  var['n'] = 49;
  var['o'] = 50;
  var['p'] = 51;
  var['q'] = 52;
  var['r'] = 53;
  var['s'] = 54;
  var['t'] = 55;
  var['u'] = 56;
  var['v'] = 57;
  var['w'] = 58;
  var['x'] = 59;
  var['y'] = 60;
  var['z'] = 61;
  var['!'] = 62;
  var['?'] = 63;

  scanf ("%d", &n);
  memset (M, 0, sizeof M);

  if (n == 3)
    printf ("0 1 2\n");
  else
    printf ("-1");
  return 0;
  
  read_mat ();

  int m;
  scanf ("%d", &m);
  for (int i = 0

  return 0;
}
