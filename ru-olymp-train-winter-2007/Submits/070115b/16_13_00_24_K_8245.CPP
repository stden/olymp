#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;

vector <pair<int, int> > v;

int main( void )
{
  freopen("segments.in", "rt", stdin);
  freopen("segments.out", "wt", stdout);
  int N;
  scanf("%d", &N);
  for (int a, b, i = 0; i < N; i++)
  {
    scanf("%d%d", &a, &b);
    v.push_back(make_pair(a, -1));
    v.push_back(make_pair(b, 1));
  }
  sort(v.begin(), v.end());
  int cnt = 0, pos, nc = 0;
  for (int i = 0; i < v.size(); i++)
  {
    nc -= v[i].second;
    if (nc > cnt)
      cnt = nc, pos = v[i].first;
  }
  printf("%d %d\n", cnt, pos);
  return 0;
}