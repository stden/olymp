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


typedef struct
{
  int p[3];
  int Turn, Who, C, Card2, Whos, M;
} State;

bool operator < ( State A, State B )
{
  for (int i = 0; i < 3; i++)
    if (A.p[i] != A.p[i])
      return A.p[i] < A.p[i];
  if (A.Turn != A.Turn)
    return A.Turn < A.Turn;
  if (A.Who != A.Who)
    return A.Who < A.Who;
  if (A.Whos != A.Whos)
    return A.Whos < A.Whos;
  if (A.C != A.C)
    return A.C < A.C;
  if (A.Card2 != A.Card2)
    return A.Card2 < A.Card2;
  if (A.M != A.M)
    return A.M < A.M;
  return 0;
}

map <State, int> Map;
char Hand[3][12][3];
int Card[3][12];

int dfs( State state )
{
  if (Map.count(state))
    return Map[state];
  int Res = 0;
  if (state.Card2 == -1)
    for (int i = 0; i < 12; i++)
      if (state.p[state.Turn] & (1 << i))
      {
        State NewState = state;
        NewState.p[state.Turn] -= (1 << i);
        NewState.Who = state.Turn;
        NewState.Card2 = Card[state.Turn][i];
        NewState.Whos = state.Turn;
        NewState.M = Card[state.Turn][i] & 3;
        NewState.Turn = (state.Turn + 1) % 3;
        int Temp = dfs(NewState);
        if (state.Turn != 0)
          Temp = 10 - Temp;
        Res = max(Res, Temp);
      }
  else if (state.Who == state.Turn)
  {
    State NewState = state;
    state.Who = state.Whos = state.Card2 = state.M = -1;
    if (state.Whos == 0)
      return Map[state] = dfs(NewState) + 1;
    else
      return Map[state] = dfs(NewState);
  }
  else
  {
    int f = 0;
    if (!f)
      for (int i = 0; i < 12; i++)
        if ((state.p[state.Turn] & (1 << i)) && (Card[state.Turn][i] & 3) == state.M)
        {
          f = 1;
          State NewState = state;
          NewState.p[state.Turn] -= (1 << i);
          if ((state.Card2  & 3) != state.C && state.Card2 < Card[state.Turn][i])
            NewState.Card2 = Card[state.Turn][i], NewState.Whos = state.Turn;
          NewState.Turn = (state.Turn + 1) % 3;
          int Temp = dfs(NewState);
          if (state.Turn != 0)
            Temp = 10 - Temp;
          Res = max(Res, Temp);
        }
    if (!f)
      for (int i = 0; i < 12; i++)
        if ((state.p[state.Turn] & (1 << i)) && (Card[state.Turn][i] & 3) == state.C)
        {
          f = 1;
          State NewState = state;
          NewState.p[state.Turn] -= (1 << i);
          if ((state.Card2  & 3) != state.C || state.Card2 < Card[state.Turn][i])
            NewState.Card2 = Card[state.Turn][i], NewState.Whos = state.Turn;
          NewState.Turn = (state.Turn + 1) % 3;
          int Temp = dfs(NewState);
          if (state.Turn != 0)
            Temp = 10 - Temp;
          Res = max(Res, Temp);
        }
    if (!f)
      for (int i = 0; i < 12; i++)
        if ((state.p[state.Turn] & (1 << i)))
        {
          State NewState = state;
          NewState.p[state.Turn] -= (1 << i);
          NewState.Turn = (state.Turn + 1) % 3;
          int Temp = dfs(NewState);
          if (state.Turn != 0)
            Temp = 10 - Temp;
          Res = max(Res, Temp);
        }
  }
  if (state.Turn != 0)
    Res = 10 - Res;
  return Map[state] = Res;
}

char Cos[6] = "SCDHN";

int Get1( char C )
{
  switch (C)
  {
    case '7': return 0;
    case '8': return 1;
    case '9': return 2;
    case 'T': return 3;
    case 'J': return 4;
    case 'Q': return 5;
    case 'K': return 6;
    case 'A': return 7;
  }
}

int Get2( char C )
{
  switch (C)
  {
    case 'S': return 0;
    case 'C': return 0;
    case 'D': return 0;
    case 'H': return 0;
  }
}

int main( void )
{
  freopen("preference.in", "rt", stdin);
  freopen("preference.out", "wt", stdout);

  int First;
  scanf("%d", &First);
  for (int k = 0; k < 3; k++)
    for (int i = 0; i < 10 + 2 * (k == 0); i++)
      scanf("%s", Hand[k][i]), Card[k][i] = Get1(Hand[k][i][0]) * 4 + Get2(Hand[k][i][1]);

  int Ans = 0;
  int Ansi = 0, Ansj = 1, Ansk = 0;
  for (int i = 0; i < 12; i++)
    for (int j = 0; j < i; j++)
      for (int k = 0; k < 5; k++)
      {
        State state;
        state.p[0] = (1 << 12) - 1 - (1 << i) - (1 << j);
        state.p[1] = state.p[2] = (1 << 10) - 1;
        state.Turn = First - 1;
        state.C = k;
        state.Who = state.Whos = state.Card2 = state.M = -1;
        int Temp = dfs(state);
        if (Temp > Ans)
          Ans = Temp, Ansi = i, Ansj = j, Ansk = k;
      }

  printf("%d\n", Ans);
  printf("%s %s\n", Hand[0][Ansi], Hand[0][Ansj]);
  printf("%c\n", Cos[Ansk]);

  return 0;
}
