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
  for (int i = 0; i < M; i++)
  {
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c);
    V[a - 1].PB(MP(b - 1, i * 2));
    V[b - 1].PB(MP(a - 1, i * 2 + 1));
    A[i * 2] = a - 1, A[i * 2 + 1] = b - 1;
    B[i * 2] = b - 1, B[i * 2 + 1] = a - 1;
    W[i * 2] = W[i * 2 + 1] = c;
  }

  memset(F, 0, sizeof(int) * M);
  int Ans2 = 0;
  for (int SC = (1 << 30); SC > 0; SC >>= 1)
    while (1)
    {
      memset(D, 0, sizeof(int) * N);
      memset(C, 0, sizeof(int) * N);
      memset(Pa, -1, sizeof(int) * N);
      C[0] = 1;
      int qs, qz;
      qs = qz = 0;
      Q[qs + qz++] = 0;
      while (qz && !D[N - 1])
      {
        int t = Q[qs++]; qz--;
        for (int i = 0; i < V[t].size(); i++)
          if (W[V[t][i].SE] - F[V[t][i].SE] >= SC && !C[V[t][i].FI])
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
      Ans2 += SC;
      for (int pa = N - 1; Pa[pa] != -1; pa = Pa[pa])
        W[To[pa]] -= SC, W[To[pa] ^ 1] += SC;
    }
  memset(D, 0, sizeof(int) * N);
  memset(C, 0, sizeof(int) * N);
  memset(Pa, -1, sizeof(int) * N);
  C[0] = 1;
  int qs, qz;
  qs = qz = 0;
  Q[qs + qz++] = 0;
  while (qz && !D[N - 1])
  {
    int t = Q[qs++]; qz--;
    for (int i = 0; i < V[t].size(); i++)
      if (W[V[t][i].SE] - F[V[t][i].SE] > 0 && !C[V[t][i].FI])
      {
        C[V[t][i].FI] = 1;
        D[V[t][i].FI] = D[t] + 1;
        Q[qs + qz++] = V[t][i].FI;
        Pa[V[t][i].FI] = t;
        To[V[t][i].FI] = V[t][i].SE;
      }
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
