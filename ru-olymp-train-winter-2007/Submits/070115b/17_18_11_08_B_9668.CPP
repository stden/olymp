#include <cstdio>
#include <set>
#include <vector>

using namespace std;

#define PB push_back
#define MP make_pair
#define FI first
#define SE second

typedef vector <int> VI;
typedef pair <int, int> PII;


#define max 1000010

vector <PII> V[max];
int A[max], B[max], W[max], C[max], D[max], F[max], Pa[max], To[max], Q[max], X[max];

int main( void )
{
  freopen("cut.in", "rt", stdin);
  freopen("cut.out", "wt", stdout);

  int N, M;
  scanf("%d%d", &N, &M);
  for (int i = 0; i < N; i++)
  {
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c);
    V[a - 1].PB(MP(b - 1, i * 2));
    V[b - 1].PB(MP(a - 1, i * 2 + 1));
    A[i * 2] = a - 1;
    B[i * 2] = b - 1;
    A[i * 2 + 1] = b - 1;
    B[i * 2 + 1] = a - 1;
    W[i * 2] = W[i * 2 + 1] = c;
  }

  memset(F, 0, sizeof(F));
  int Ans2 = 0;
  while (1)
  {
    memset(D, 0, sizeof(D));
    memset(C, 0, sizeof(C));
    memset(Pa, -1, sizeof(Pa));
    C[0] = 1;
    int qs, qz;
    qs = qz = 0;
    Q[qs + qz++] = 0;
    while (qz && !D[N - 1])
    {
      int t = Q[qs++]; qz--;
      for (int i = 0; i < V[t].size(); i++)
        if (F[V[t][i].SE] < W[V[t][i].SE] && !C[V[t][i].FI])
        {
          C[V[t][i].FI] = 1;
          D[V[t][i].FI] = D[t] + 1;
          Q[qs + qz++] = V[t][i].FI;
          Pa[V[t][i].FI] = t;
          To[V[t][i].FI] = V[t][i].SE;
        }
    }
    if (!D[N - 1])
      break;
    int FF = 10000000;
    for (int pa = N - 1; Pa[pa] != -1; pa = Pa[pa])
      FF = min(FF, W[To[pa]] - F[To[pa]]);
    Ans2 += FF;
    for (int pa = N - 1; Pa[pa] != -1; pa = Pa[pa])
      W[To[pa]] -= FF, W[To[pa] ^ 1] += FF;
  }
  memset(X, 0, sizeof(X));
  int Ans1 = 0;
  for (int i = 0; i < 2 * M; i++)
    if (C[A[i]] != C[B[i]])
      X[i / 2] = 1, Ans1++;
  printf("%d %d\n", Ans1 / 2, Ans2);
  for (int i = 0; i < M; i++)
    if (X[i])
      printf("%d ", i + 1);

  return 0;
}
