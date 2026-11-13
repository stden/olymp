#include <cstdio>
#include <cstring>

#define m 200200

int _stklen = 10 << 20;
int sp, st[m], ma[m];
char s[m];

unsigned val( int i, int j )
{
  if (ma[i] == j)
    i++, j--;
  unsigned ans = 0;
  int sign = 1;
  while (i <= j)
  {
    unsigned c = 1;
    while (i <= j)
    {
      if (s[i] == '(')
        c *= val(i, ma[i]), i = ma[i] + 1;
      else
      {
        unsigned t;
        sscanf(s + i, "%u", &t);
        c *= t;
        while (i <= j && '0' <= s[i] && s[i] <= '9')
          i++;
      }
      if (i > j || s[i] != '*')
        break;
      i++;
    }
    ans += sign * c;
    if (s[i] == '+')
      sign = 1;
    else
      sign = -1;
    i++;
  }
  return ans;
}

int main( void )
{
  freopen("expr.in", "rt", stdin);
  freopen("expr.out", "wt", stdout);
  memset(ma, -1, sizeof(ma));
  gets(s);
  sp = -1;
  for (int i = 0; s[i]; i++)
    if (s[i] == '(')
      st[++sp] = i;
    else if (s[i] == ')')
      ma[st[sp]] = i, sp--;
  printf("%u", val(0, strlen(s) - 1));
  return 0;
}
