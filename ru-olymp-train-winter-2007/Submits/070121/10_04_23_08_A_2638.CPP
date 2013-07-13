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



#define maxx 10//0010

int H[maxx];

int main( void )
{
  freopen("geology.in", "rt", stdin);
  freopen("geology.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  memset(H, 0, sizeof(H));
  for (int i = 0; i < N; i++)
  {
    char Temp[50];
    int a, b;
    scanf("%s%d%d", Temp, &a, &b);
    if (strcmp(Temp, "QUERY") == 0)
    {
      double Ans = 0;
      for (int i = min(a, b); i < max(a, b); i++)
        Ans += 0.5 * (H[i] + H[i + 1]);
      printf("%.3lf\n", Ans);
    }
    else
      for (int x = max(0, a - b); x <= min(maxx - 1, a + b); x++)
        H[x] += max(0, b - abs(x - a));
  }

  return 0;
}
