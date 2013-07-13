#include <algorithm>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <set>
#include <utility>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

#define eps 1e-9

#define maxn 125010

int N, X1[maxn], Y1[maxn], X2[maxn], Y2[maxn];
pair <int, int> Time;

int Sign( long long X )
{
  return X > 0 ? 1 : X < 0 ? -1 : 0;
}

void Try( int i, int j )
{
  long long A1 = Y1[i] - Y2[i];
  long long B1 = X2[i] - X1[i];
  long long C1 = -(A1 * X1[i] + B1 * Y1[i]);
  long long A2 = Y1[j] - Y2[j];
  long long B2 = X2[j] - X1[j];
  long long C2 = -(A1 * X1[j] + B1 * Y1[j]);
  if (Sign(A1 * X1[j] + B1 * Y1[j] + C1) * Sign(A1 * X1[j] + B1 * Y2[j] + C1) <= 0 &&
      Sign(A2 * X1[i] + B2 * Y1[i] + C2) * Sign(A2 * X1[i] + B2 * Y2[i] + C2) <= 0)
  {
    printf("YES\n");
    printf("%d %d\n", min(i, j) + 1, max(i, j) + 1);
    exit(0);
  }
}

bool Func( int i, int j )
{
  double y1, y2;
  if (X1[i] != X2[i])
    y1 = X1[i] + 1.0 * (Time.FI - X1[i]) * (Y2[i] - Y1[i]) / (X2[i] - X1[i]);
  else
    y1 = Y1[i];
  if (X1[j] != X2[j])
    y2 = X1[j] + 1.0 * (Time.FI - X1[j]) * (Y2[j] - Y1[j]) / (X2[j] - X1[j]);
  else
    y2 = Y1[j];

  if (fabs(y1 - y2) > eps)
    return y1 > y2;
  else
    return i > j;
}

class CCL
{
  public:
    int i;
    CCL( int a )
    {
      i = a;
    }
};

bool operator < ( CCL i, CCL j )
{
  return Func(i.i, j.i);
}

int main( void )
{
  freopen("segments.in", "rt", stdin);
  freopen("segments.out", "wt", stdout);

  vector <pair<pair<int, int>, pair<int, int> > > Event;

  scanf("%d", &N);
  for (int i = 0; i < N; i++)
  {
    scanf("%d%d%d%d", &X1[i], &Y1[i], &X2[i], &Y2[i]);
    if (X1[i] > X2[i] || X1[i] == X2[i] && Y1[i] > Y2[i])
      swap(X1[i], X2[i]), swap(Y1[i], Y2[i]);
    Event.PB(MP(MP(X1[i], Y1[i]), MP(-1, i)));
    Event.PB(MP(MP(X2[i], Y2[i]), MP(+1, i)));
  }

  sort(Event.begin(), Event.end());

  set <CCL> Set;

  for (int i = 0; i < Event.size(); i++)
  {
    Time = Event[i].FI;
    if (Event[i].SE.FI == -1)
    {
      Set.insert(CCL(Event[i].SE.SE));
      set <CCL> :: iterator T = Set.find(CCL(Event[i].SE.SE)), T1 = T, T2 = T;
      if (T == Set.end())
        fprintf(stderr, "Bonus!!\n");
      int P1 = -1, P2 = -1;
      if (T1 != Set.begin())
        P1 = (--T1)->i;
      if (++T2 != Set.end())
        P2 = T2->i;
      if (P1 != -1)
        Try(P1, T->i);
      if (P2 != -1)
        Try(T->i, P2);
      if (P1 != -1 && P2 != -1)
        Try(P1, P2);
    }
    else
    {
      set <CCL> :: iterator T = Set.find(CCL(Event[i].SE.SE)), T1 = T, T2 = T;
      if (T == Set.end())
        fprintf(stderr, "Bonus!!\n");
      int P1 = -1, P2 = -1;
      if (T1 != Set.begin())
        P1 = (--T1)->i;
      if (++T2 != Set.end())
        P2 = T2->i;
      if (P1 != -1)
        Try(P1, T->i);
      if (P2 != -1)
        Try(T->i, P2);
      if (P1 != -1 && P2 != -1)
        Try(P1, P2);
      Set.erase(T);
    }
  }
  printf("NO\n");

  return 0;
}
