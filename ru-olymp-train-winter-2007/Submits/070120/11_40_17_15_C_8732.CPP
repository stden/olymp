#include <stdio.h>
#include <string.h>

#define min(a,b) ((a)<(b)?(a):(b))
#define max(a,b) ((a)>(b)?(a):(b))

char str[4194304];
char rle[1048576];
int kmp[4194304];
int len;

void un_rle ()
{
  len = 0;
  for (int i = 0; rle[i]; i++)
  {
    int count = 1;
    if (rle[i] >= '0' && rle[i] <= '9')
    {
      count = 0;
      while (rle[i] >= '0' && rle[i] <= '9')
        count = count * 10 + (rle[i] - '0'), i++;
    }
    char c = rle[i];
    for (int j = 0; j < count; j++)
      str[len++] = c;
  }
}

int main ()
{
  freopen ("rle.in", "rt", stdin);
  freopen ("rle.out", "wt", stdout);

  scanf ("%s", rle);
  un_rle ();

  kmp[0] = 0;
  for (int i = 1; str[i]; i++)
  {
    int cur = kmp[i - 1];
    while (cur > 0 && str[cur] != str[i])
      cur = kmp[cur - 1];
    if (str[cur] == str[i])
      kmp[i] = cur + 1;
    else
      kmp[i] = 0;
  }

  int n;
  scanf ("%d", &n);
  for (int i = 0; i < n; i++)
  {
    int j;
    scanf ("%d", &j);
    printf ("%d\n", kmp[j - 1]);
  }

  return 0;
}
