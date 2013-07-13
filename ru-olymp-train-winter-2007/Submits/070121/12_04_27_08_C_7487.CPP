#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>
#include <set>
#include <string>
#include <utility>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

typedef vector <int> VI;
typedef pair <int, int> PII;



#define maxn 270010

int X[maxn], Y[maxn];

int main( void )
{
  freopen("tri.in", "rt", stdin);
  freopen("tri.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
    scanf("%d%d", &X[i], &Y[i]);

  int k = -1;
  for (int i = 0; i < N; i++)
    if (k == -1 || X[k] > X[i])
      k = i;

  vector <PII> V1(0), V2(0);

  for (int i = (k + 1) % N; X[(i + N - 1) % N] <= X[i]; i = (i + 1) % N)
    V1.PB(MP(X[i], i));
  for (int i = (k + N - 1) % N; V1.size() + V2.size() <= N - 1; i = (i + N - 1) % N)
    V2.PB(MP(X[i], i));

  int i1 = 0, i2 = 0, k1 = -1, k2 = -1;
  for (int i = 0; i < N - 2; i++)
    if (k1 == -1)
    {
      printf("%d %d %d\n", k + 1, V1[i1].SE + 1, V2[i2].SE + 1);
      k1 = V1[i1++].SE;
      k2 = V2[i2++].SE;
    }
    else
      if (V1[i1].FI < V2[i2].FI)
      {
        printf("%d %d %d\n", k1 + 1, k2 + 1, V1[i1].SE + 1);
        k1 = V1[i1++].SE;
      }
      else
      {
        printf("%d %d %d\n", k1 + 1, k2 + 1, V2[i2].SE + 1);
        k2 = V2[i2++].SE;
      }

  return 0;
}
