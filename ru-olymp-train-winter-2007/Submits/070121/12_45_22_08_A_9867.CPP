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


#define maxn 100010

PII U[maxn];

int main( void )
{
  freopen("geology.in", "rt", stdin);
  freopen("geology.out", "wt", stdout);

  int N, T = 0;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
  {
    char Temp[50];
    int a, b;
    scanf("%s%d%d", Temp, &a, &b);
    if (strcmp(Temp, "ADD") == 0)
      U[T++] = MP(a, b);
    else
    {
      double Ans = 0;
      for (int i = 0; i < T; i++)
        if (a >= U[i].FI - U[i].SE || b <= U[i].FI + U[i].SE)
          Ans += 1.0 * U[i].SE * U[i].SE - 0.5 * (max(0, U[i].SE - abs(U[i].FI - a))) * (max(0, U[i].SE - abs(U[i].FI - a)))
                                         - 0.5 * (max(0, U[i].SE - abs(U[i].FI - b))) * (max(0, U[i].SE - abs(U[i].FI - b)));
      printf("%.3lf\n", Ans);
    }
  }

  return 0;
}
