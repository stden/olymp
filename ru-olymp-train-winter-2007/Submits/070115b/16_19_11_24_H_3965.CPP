#include <cstdio>
#include <algorithm>
#include <vector>

using namespace std;

vector <int> v;
int main( void )
{ 
  freopen("nextperm.in", "rt", stdin);
  freopen("nextperm.out", "wt", stdout);
  int N;
  scanf("%d", &N);
  for (int t, i = 0; i < N; i++)
    scanf("%d", &t), v.push_back(t);
  int i;
  for (i = 0; i < N - 1; i++)
    if (v[i] < v[i + 1])
      break;
  if (i == N - 1)
  {
    printf("IMPOSSIBLE\n");
    return 0;
  }
  next_permutation(v.begin(), v.end());
  for (i = 0; i < N; i++)
    printf("%d%c", v[i], i < N - 1 ? ' ' : '\n');
  return 0;
}