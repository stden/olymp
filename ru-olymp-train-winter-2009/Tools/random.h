#ifndef __random_h__
#define __random_h__

#include <cmath>
#include <cstdio>
#include <cstdlib>

const int MBIG = 1000000000, MSEED = 161803398;
const double FAC = 1.0 / MBIG;

int inext, inextp;
int ra [56];

int nextrand (void)
{
  int j;
  if (++inext == 56) inext = 1;
  if (++inextp == 56) inextp = 1;
  j = ra[inext] - ra[inextp];
  if (j < 0) j += MBIG;
  ra[inext] = j;
  return j;
}

bool initrand (int seed)
{
  int i, j, k, l;
  l = MSEED - seed;
  if (l < 0) l = -l;
  l %= MBIG;
  ra[55] = l;
  k = 1;
  for (i = 1, j = 0; i <= 54; i++)
  {
   j += 21;
   if (j > 55) j -= 55;
   ra[j] = k;
   k = l - k;
   if (k < 0) k += MBIG;
   l = ra[j];
  }
  for (k = 1; k <= 4; k++)
   for (i = 1, j = 31; i <= 55; i++, j >= 55 ? j = 1 : j++)
   {
    ra[i] -= ra[j];
    if (ra[i] < 0) ra[i] += MBIG;
   }
  inext = 0;
  inextp = 31;
  return true;
}

double rndvalue (void)
{
  return nextrand () * FAC;
}

int rndvalue (int k)
{
  return (int) floor (rndvalue () * k);
}

long long Time()
{
#ifdef __GNUC__
  asm("rdtsc");
#else
  _asm rdtsc
#endif
}

#define R(A, B) ((A) + rndvalue((B) - (A) + 1))

#endif // __random_h__
