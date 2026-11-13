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
typedef struct
{
  char X, Y, S, L;
} Car;

typedef vector <Car> TT;

Car ZZZ = {0, 0, 0, 0};

int MakeHash( int Res, Car car )
{
  Res = (Res * 239 + car.X) % hashsize;
  Res = (Res * 229 + car.Y) % hashsize;
  Res = (Res * 259 + car.S) % hashsize;
  Res = (Res * 249 + car.L) % hashsize;
  return Res;
}

int Hash( TT A )
{
  int Res = 17;
  for (int i = 0; i < A.size(); i++)
    Res = MakeHash(Res, A[i]);
  return Res;
}

int PartHash( TT A, int I )
{
  int Res = 17;
  for (int i = 0; i < A.size(); i++)
    if (i != I)
      Res = MakeHash(Res, A[i]);
    else
      Res = MakeHash(Res, ZZZ);
  return Res;
}

int DHash[100];

void Init1( void )
{
  DHash[0] = 1;
  for (int i = 1; i < 100; i++)
    DHash[i] = MakeHash(DHash[i - 1], ZZZ);
}

int AddHash( int PHash, Car T, int I, int N )
{
  int Res = 0;
  Res = MakeHash(Res, T);

  if (N - I - 1 < 0)
    fprintf(stderr, "Bonus!\n"), exit(0);
  Res = ((Long)Res * DHash[N - I - 1]) % hashsize;

  return (PHash + Res) % hashsize;
}

int C[hashsize], D[hashsize], qs, qz, F[6][6];
TT Q[maxq];

int main( void )
{
  freopen("cars.in", "rt", stdin);
  freopen("cars.out", "wt", stdout);

  int N;
  Init1();
  scanf("%d", &N);
  TT A;
  for (int i = 0; i < N; i++)
  {
    Car Temp;
    char a, d;
    int b, c;
    scanf(" %c%d%d %c", &a, &b, &c, &d);
    Temp.X = c - 1, Temp.Y = b - 1;
    Temp.S = a == 'v';
    Temp.L = 2 + (d == 't');
    A.PB(Temp);
/*
    char a, d;
    int b, c;
    scanf(" %c%d%d %c", &a, &b, &c, &d);
    A.PB(MP(MP(c - 1, b - 1), MP(a == 'v', 2 + (d == 't'))));
*/
  }

  memset(C, 0, sizeof(C));
  memset(D, 0, sizeof(D));
  C[Hash(A)] = 1;
  D[Hash(A)] = 0;
  Q[qs + qz++] = A;
  int Ans = -1;
  while (qz /* && !TL && !ML*/)
  {
/*
    if (qs + qz > 10000)
    {
      fprintf(stderr, "Too much states\n");
      break;
    }
*/

    TT State = Q[qs];
    qz--, Q[qs++].resize(0);

    memset(F, 0, sizeof(F));
    for (int i = 0; i < N; i++)
      for (int j = 0; j < State[i].L; j++)
        F[State[i].X + j * (!State[i].S)][State[i].Y + j * State[i].S] = i + 1;

    int d = D[Hash(State)];
    if (State[0].X == 4)
    {
      Ans = D[Hash(State)];
      break;
    }
    for (int i = 0; i < N; i++)
    {
      int t;
      Car OldCar = State[i];
      int PHash = PartHash(State, i);
      if (OldCar.S)
      {
        int x = OldCar.X;
        int y = OldCar.Y + OldCar.L;
        for (int k = 1; y < 6 && !F[x][y] ; k++, y++)
        {
          State[i].Y = OldCar.Y + k;
          if (!C[t = AddHash(PHash, State[i], i, N)])
          {
            C[t] = 1, D[t] = 1 + d;
            Q[qs + qz++] = State;
          }
        }
        y = OldCar.Y - 1;
        for (int k = 1; y >= 0 && !F[x][y]; k++, y--)
        {
          State[i].Y = OldCar.Y - k;
          if (!C[t = AddHash(PHash, State[i], i, N)])
          {
            C[t] = 1, D[t] = 1 + d;
            Q[qs + qz++] = State;
          }
        }
      }
      else
      {
        int x = OldCar.X + OldCar.L;
        int y = OldCar.Y;
        for (int k = 1; x < 6 && !F[x][y]; k++, x++)
        {
          State[i].X = OldCar.X + k;
          if (!C[t = AddHash(PHash, State[i], i, N)])
          {
            C[t] = 1, D[t] = 1 + d;
            Q[qs + qz++] = State;
          }
        }
        x = OldCar.X - 1;
        for (int k = 1; x >= 0 && !F[x][y]; k++, x--)
        {
          State[i].X = OldCar.X - k;
          if (!C[t = AddHash(PHash, State[i], i, N)])
          {
            C[t] = 1, D[t] = 1 + d;
            Q[qs + qz++] = State;
          }
        }
      }
      State[i] = OldCar;
    }
  }
///*
  fprintf(stderr, "States: ~%d\n", qs + qz);
  fprintf(stderr, "Ans = %d\n", Ans);
//*/
  printf("%d\n", Ans);

  return 0;
}
