#include "binsearch.h"

int main( void )
{
  int N = getN();

  int T = 0;
  while (1)
  {
    int Min = 0, Max = N;
    while (Min < Max)
    {
      int Ave = (Min + Max) >> 1;
      if (query(Ave + 1))
        Max = Ave;
      else
        Min = Ave + 1;
    }
    if (T || (Min == 0 || !query(Min)) && (Min == N || query(Min + 1)))
    {
      answer(Min + 1);
      break;
    }
    T = 1;
  }

  return 0;
}
