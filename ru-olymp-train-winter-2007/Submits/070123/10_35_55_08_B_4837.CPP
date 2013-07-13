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

int Q1[maxn], Q2[maxn], Ans[maxn];
set <int> V1[maxn], V2[maxn];

int main( void )
{
  freopen("omax.in", "rt", stdin);
  freopen("omax.out", "wt", stdout);

  int N;
  scanf("%d", &N);
  for (int i = 0; i < N; i++)
  {
    int K, b;
    scanf("%d", &K);
    for (int j = 0; j < K; j++)
      scanf("%d", &b), V1[i].insert(b - 1), V2[b - 1].insert(i);
  }

  int qs1 = 0, qs2 = 0, qz1 = 0, qz2 = 0;
  for (int i = 0; i < N; i++)
  {
    if (V1[i].size() == 1)
      Q1[qs1 + qz1++] = i;
    if (V2[i].size() == 1)
      Q2[qs2 + qz2++] = i;
  }

  memset(Ans, -1, sizeof(Ans));
  while (qz1 || qz1)
  {
    int T1 = -1, T2 = -1;
    if (qz1 >= qz2)
      T1 = Q1[qs1++], qz1--;
    else
      T2 = Q2[qs2++], qz2--;
    if (T1 != -1)
    {
      if (V1[T1].size() == 0)
        continue;
      T2 = *(V1[T1].begin()), Ans[T1] = T2;
      for (set <int> :: iterator i = V2[T2].begin(); i != V2[T2].end(); i++)
        if (*i != T1)
        {
          V1[*i].erase(T2);
          if (V1[*i].size() == 1)
            Q1[qs1 + qz1++] = *i;
        }
    }
    else
    {
      if (V2[T2].size() == 0)
        continue;
      T1 = *(V2[T2].begin()), Ans[T1] = T2;
      for (set <int> :: iterator i = V1[T1].begin(); i != V1[T1].end(); i++)
        if (*i != T2)
        {
          V2[*i].erase(T1);
          if (V2[*i].size() == 1)
            Q2[qs2 + qz2++] = *i;
        }
    }
  }

  int f = 1;
  for (int i = 0; i < N; i++)
    if (Ans[i] == -1)
      f = 0;

  if (f)
  {
    printf("YES\n");
    for (int i = 0; i < N; i++)
      printf("%d%c", Ans[i] + 1, i < N - 1 ? ' ' : '\n');
  }
  else
    printf("NO\n");

  return 0;
}
