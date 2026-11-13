#include <algorithm>

using namespace std;

#define maxn 50010

int A[maxn];

int main( void )
{
  freopen("nextperm.in", "rt", stdin);
  freopen("nextperm.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
    scanf("%d", &A[i]);
  if (next_permutation(A, A + N))
    for (int i = 0; i < N; i++)
      printf("%d%c", A[i], (i < N - 1) ? ' ' : '\n');
  else
    printf("IMPOSSIBLE\n");

  return 0;
}
