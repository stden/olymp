#include <algorithm>
#include <cstdio>
#include <utility>
#include <vector>

using namespace std;

typedef long long Long;

typedef pair <int, int> PII;
typedef vector <int> VI;

#define MP make_pair
#define PB push_back
#define FI first
#define SE second


#define hashsize 1000010
#define maxq 1000010
typedef vector <pair <PII, PII> > TT;

int Hash( TT A )
{
  int Res = 17;
  for (int i = 0; i < A.size(); i++)
    Res = (Res * 239 + A[i].FI.FI) % hashsize,
    Res = (Res * 229 + A[i].FI.SE) % hashsize,
    Res = (Res * 259 + A[i].SE.FI) % hashsize,
    Res = (Res * 249 + A[i].SE.SE) % hashsize;
  return Res;
}

int C[hashsize], D[hashsize], qs, qz, F[6][6];
TT Q[maxq];

int main( void )
{
  freopen("cars.in", "rt", stdin);
  freopen("cars.out", "wt", stdout);
//  freopen("cars.err", "wt", stderr);

  int N;
  scanf("%d", &N);
  TT A;
  for (int i = 0; i < N; i++)
  {
    char a, d;
    int b, c;
    scanf(" %c%d%d %c", &a, &b, &c, &d);
    A.PB(MP(MP(c - 1, b - 1), MP(a == 'v', 2 + (d == 't'))));
  }

  memset(C, 0, sizeof(C));
  memset(D, 0, sizeof(D));
  C[Hash(A)] = 1;
  D[Hash(A)] = 0;
  Q[qs + qz++] = A;
  int Ans = -1;
  while (qz /* && !TL && !ML*/)
  {
//    fprintf(stderr, "States = ~%d\n", qs + qz);
/*
    if (qs + qz > 10000)
    {
      fprintf(stderr, "Too much states\n");
      break;
    }
*/
//    fprintf(stderr, "1\n");

    TT State = Q[qs];
    qz--, Q[qs++].resize(0);

/*
    fprintf(stderr, "%d\n", (int)State.size());
    for (int i = 0; i < (int)State.size(); i++)
      fprintf(stderr, "%c %d %d %c\n", State[i].SE.FI ? 'v' : 'h', State[i].FI.SE + 1, State[i].FI.FI + 1, (State[i].SE.SE - 2) ? 't' : 'c');
    fprintf(stderr, "\n");
*/
      
    memset(F, 0, sizeof(F));
    for (int i = 0; i < N; i++)
      for (int j = 0; j < State[i].SE.SE; j++)
      {
/*
        fprintf(stderr, "State[i = %d].SE.FI = %d\n", i, State[i].SE.FI);
        fprintf(stderr, "(%d, %d)\n", State[i].FI.FI + j * (!State[i].SE.FI), State[i].FI.SE + j * State[i].SE.FI);
*/
        F[State[i].FI.FI + j * (!State[i].SE.FI)][State[i].FI.SE + j * State[i].SE.FI] = i + 1;
      }

/*
    for (int i = 0; i < 6; i++)
    {
      for (int j = 0; j < 6; j++)
        fprintf(stderr, "%d", F[j][i]);
      fprintf(stderr, "\n");
    }
    fprintf(stderr, "\n");

    return -1;
*/

    int d = D[Hash(State)];
    if (State[0].FI.FI == 4)
    {
      Ans = D[Hash(State)];
      break;
    }
    for (int i = 0; i < N; i++)
      for (int k = 1; ; k++)
      {
        int x = State[i].FI.FI + (k - 1 + State[i].SE.SE) * (!State[i].SE.FI);
        int y = State[i].FI.SE + (k - 1 + State[i].SE.SE) * State[i].SE.FI;
        if (x >= 6 || y >= 6 || F[x][y])
          break;
        TT R = State;
        R[i].FI.FI += k * (!State[i].SE.FI);
        R[i].FI.SE += k * (State[i].SE.FI);
        if (C[Hash(R)])
          continue;
        C[Hash(R)] = 1;
        D[Hash(R)] = 1 + d;
        Q[qs + qz++] = R;
      }
    for (int i = 0; i < N; i++)
      for (int k = 1; ; k++)
      {
        int x = State[i].FI.FI - k * (!State[i].SE.FI);
        int y = State[i].FI.SE - k * State[i].SE.FI;
        if (x < 0 || y < 0 || F[x][y])
          break;
        TT R = State;
        R[i].FI.FI -= k * (!State[i].SE.FI);
        R[i].FI.SE -= k * (State[i].SE.FI);
        if (C[Hash(R)])
          continue;
        C[Hash(R)] = 1;
        D[Hash(R)] = 1 + d;
        Q[qs + qz++] = R;
      }
  }
/*
  fprintf(stderr, "States: ~%d\n", qs + qz);
  fprintf(stderr, "Ans = %d\n", Ans);
*/
  printf("%d\n", Ans);

  return 0;
}
