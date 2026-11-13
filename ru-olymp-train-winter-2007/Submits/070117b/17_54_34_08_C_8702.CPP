#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <map>
#include <set>
#include <utility>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

typedef vector <int> VI;
typedef pair <int, int> PII;


#define maxn 10010

int D[maxn], A[maxn], B[maxn], C[maxn];

int main( void )
{
  freopen("linguae.in", "rt", stdin);
  freopen("linguae.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
    scanf("%d%d%d", &A[i], &B[i], &C[i]);

  memset(D, 0x7f, sizeof(D));
  int INF = 0x7f7f7f7f;
  D[0] = 0;
  for (int i = 0; i < N; i++)
    if (D[i] < INF)
      for (int j = max(0, i - 5); j <= i; j++)
      {
        D[min(N, max(i, j + 1))] = min(D[min(N, max(i, j + 1))], D[i] + A[j]);
        D[min(N, max(i, j + 2))] = min(D[min(N, max(i, j + 2))], D[i] + B[j]);
        D[min(N, max(i, j + 3))] = min(D[min(N, max(i, j + 3))], D[i] + C[j]);
      }

  printf("%d\n", D[N]);

  return 0;
}
