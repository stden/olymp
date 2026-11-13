#include <string.h>

#include "binsearch.h"

int T = 0, D[70];

int Query( int Value )
{
  if (T && D[Value] != -1)
    return D[Value];
  if (D[Value] != -1)
  {
    int Temp = query(Value);
    if (Temp != D[Value])
    {
      D[Value] = -1;
      T = 1;
    }
    return Temp;
  }
  return D[Value] = query(Value);
}

int main( void )
{
  int N = getN();

  memset(D, -1, sizeof(D));
  while (1)
  {
    int Min = 0, Max = N;
    while (Min < Max)
    {
      int Ave = (Min + Max) >> 1;
      if (Query(Ave + 1))
        Max = Ave;
      else
        Min = Ave + 1;
    }
    if (T || (Min == 0 || !Query(Min)) && (Min == N || Query(Min + 1)))
    {
      answer(Min + 1);
      break;
    }
  }

  return 0;
}
