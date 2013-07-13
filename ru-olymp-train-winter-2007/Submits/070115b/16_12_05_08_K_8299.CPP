#include <algorithm>
#include <cstdio>
#include <vector>

using namespace std;

int main( void )
{
  freopen("segments.in", "rt", stdin);
  freopen("segments.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  vector <pair<int, int> > V;
  for (int i = 0; i < N; i++)
  {
    int A, B;
    scanf("%d%d", &A, &B);
    V.push_back(make_pair(A, -1));
    V.push_back(make_pair(B, +1));
  }
  sort(V.begin(), V.end());
  int Ans = 0, p = 0;
  int AnsX = 0;
  for (int i = 0; i < V.size(); i++)
  {
    p -= V[i].second;
    if (p > Ans)
      Ans = p, AnsX = V[i].first;
  }
  printf("%d %d\n", Ans, AnsX);

  return 0;
}
