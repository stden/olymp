#include "binsearch.h"

int main( void )
{
  int N = getN();
  int Min = 0, Max = N;

  while (Min < Max)
  {
    int Ave = (Min + Max) >> 1;
    if (query(Ave + 1))
      Max = Ave;
    else
      Min = Ave + 1;
  }
  answer(Min + 1);

  return 0;
}
