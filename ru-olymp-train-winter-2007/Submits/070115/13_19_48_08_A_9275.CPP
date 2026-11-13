#include <algorithm>
#include <cstdio>
#include <cstddef>
#include <cstdlib>
#include <ctime>
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

typedef struct
{
  Car C[10];
} TT;

//typedef vector <Car> TT;

Car ZZZ = {0, 0, 0, 0};

int MakeHash( int Res, Car car )
{
  Res = (Res * 239 + car.X) % hashsize;
  Res = (Res * 229 + car.Y) % hashsize;
  Res = (Res * 259 + car.S) % hashsize;
  Res = (Res * 249 + car.L) % hashsize;
  return Res;
}

int Hash( TT A, int N )
{
  int Res = 17;
  for (int i = 0; i < N; i++)
    Res = MakeHash(Res, A.C[i]);
  return Res;
}

int PartHash( TT A, int I, int N )
{
  int Res = 17;
  for (int i = 0; i < N; i++)
    if (i != I)
      Res = MakeHash(Res, A.C[i]);
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

char C[hashsize];
int D[hashsize], qs, qz, F[6][6];
TT Q[maxq];

int main( void )
{
  int start = clock();
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
    A.C[i] = Temp;
  }

  memset(C, 0, sizeof(C));
  memset(D, 0, sizeof(D));
  C[Hash(A, N)] = 1;
  D[Hash(A, N)] = 0;
  qs = qz = 0;
  Q[qs + qz++] = A;
  int Ans = -1;
  while (qz)
  {
    if (qs % 100 == 0)
      if (clock() - start > 1.9 * CLOCKS_PER_SEC)
      {
        fprintf(stderr, "Time limit o_O\n");
        break;
      }
    TT State = Q[qs++];
    qz--;

    memset(F, 0, sizeof(F));
    for (int i = 0; i < N; i++)
      for (int j = 0; j < State.C[i].L; j++)
        F[State.C[i].X + j * (!State.C[i].S)][State.C[i].Y + j * State.C[i].S] = i + 1;

    int d = D[Hash(State, N)];
    if (State.C[0].X == 4)
    {
      fprintf(stderr, "Answer found T__T\n");
      Ans = D[Hash(State, N)];
      break;
    }
    for (int i = 0; i < N; i++)
    {
      int t;
      Car OldCar = State.C[i];
      Car NewCar = State.C[i];
      int PHash = PartHash(State, i, N);
      if (OldCar.S)
      {
        int x = OldCar.X;
        int y = OldCar.Y + OldCar.L;
        for (int k = 1; y < 6 && !F[x][y] ; k++, y++)
        {
          NewCar.Y = OldCar.Y + k;
          if (!C[t = AddHash(PHash, NewCar, i, N)])
          {
            C[t] = 1, D[t] = 1 + d;
            Q[qs + qz] = State, Q[qs + qz++].C[i] = NewCar;
          }
        }
        y = OldCar.Y - 1;
        for (int k = 1; y >= 0 && !F[x][y]; k++, y--)
        {
          NewCar.Y = OldCar.Y - k;
          if (!C[t = AddHash(PHash, NewCar, i, N)])
          {
            C[t] = 1, D[t] = 1 + d;
            Q[qs + qz] = State, Q[qs + qz++].C[i] = NewCar;
          }
        }
      }
      else
      {
        int x = OldCar.X + OldCar.L;
        int y = OldCar.Y;
        for (int k = 1; x < 6 && !F[x][y]; k++, x++)
        {
          NewCar.X = OldCar.X + k;
          if (!C[t = AddHash(PHash, NewCar, i, N)])
          {
            C[t] = 1, D[t] = 1 + d;
            Q[qs + qz] = State, Q[qs + qz++].C[i] = NewCar;
          }
        }
        x = OldCar.X - 1;
        for (int k = 1; x >= 0 && !F[x][y]; k++, x--)
        {
          NewCar.X = OldCar.X - k;
          if (!C[t = AddHash(PHash, NewCar, i, N)])
          {
            C[t] = 1, D[t] = 1 + d;
            Q[qs + qz] = State, Q[qs + qz++].C[i] = NewCar;
          }
        }
      }
    }
  }
  fprintf(stderr, "States = ~%d\n", qs + qz);
  printf("%d\n", Ans);

  return 0;
}
