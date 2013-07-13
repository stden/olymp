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



#define maxn 240010

int A[maxn], D[maxn], P[maxn];

int main( void )
{
  freopen("subseq.in", "rt", stdin);
  freopen("subseq.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
    scanf("%d", &A[i]);

  memset(D, -1, sizeof(D));
  for (int i = 0; i < N; i++)
  {
    int Min = 0;
    int Max = N;
    while (Min < Max)
    {
      int Ave= (Min + Max + 1) / 2;
      if (D[Ave] != -1 && A[D[Ave]] >= A[i])
        Min = Ave;
      else
        Max = Ave - 1;
    }
    D[Min + 1] = i, P[i] = D[Min];
  }

  VI Ans;
  int X;
  for (X = N; X >= 0 && D[X] == -1; X--)
    ;
  int i, T;
  for (i = 0, T = D[X]; i < X; i++, T = P[T])
    Ans.PB(T + 1);

  sort(Ans.begin(), Ans.end());
  printf("%d\n", X);
  for (i = 1; i <= X; i++)
    printf("%d\n", Ans[i - 1]);

  return 0;
}
