#include <algorithm>
#include <cstdio>

using namespace std;

#define maxl 10010

char A[maxl], B[maxl];

int Test1( int L )
{
  memcpy(B, A, sizeof(A));
  int N = strlen(B);
  for (int i = 0; i < N; i++)
    B[i] -= '0';
  B[N] = 0;
  for (int i = 0; i < N / 2; i++)
    swap(B[i], B[N - 1 - i]);
  for (int i = 0; i < (N + 1) / 2; i++)
  {
    if (B[L - i] > 1)
      return 0;
    int A_B;
    if (B[L - i] == 1)
      A_B = B[i] + 10;
    else
      A_B = B[i];
    if (L - i - 1 == i)
      if (A_B % 2)
        return 0;
      else
        A_B /= 2;
    B[L - i] -= A_B / 10;
    B[L - i - 1] -= A_B % 10;
    if (B[L - i - 1] < 0)
      return 0;
    B[i] -= A_B % 10;
    B[i + 1] -= A_B / 10;
    if (B[i] < 0)
      B[i] += 10, B[i + 1]--;
    int j;
    for (j = i + 1; j < N; j++)
      if (B[j] < 0)
        B[j] += 10, B[j + 1]--;
      else
        break;
    if (j == N && B[j] < 0)
      return 0;
  }
  return 1;
}

int main( void )
{
  freopen("reverse.in", "rt", stdin);
  freopen("reverse.out", "wt", stdout);

  while (scanf("%s", A) == 1)
  {
    int f = 0;
    for (int i = 0; A[i] && !f; i++)
      if (A[i] != '0')
        f = 1;
    if (!f)
      break;

    if (Test1(strlen(A)))
      printf("YES\n");
    else if (strlen(A) > 1 && Test1(strlen(A) - 1))
      printf("YES\n");
    else
      printf("NO\n");
  }

  return 0;
}
