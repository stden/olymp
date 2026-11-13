#include <stdio.h>
#include <stdlib.h>
#include <io.h>


int main (int argc, char *argv[]) {
  int i;
  if (argc!=4) {printf ("\nFATAL: 3 arguments required\7\n");return 1;};
  char *tmp, buf [256], buf2[256], buf3[256], buf4[256];
  int f=strtoul (argv [1], &tmp, 10);
  if (*tmp) {printf ("\nFATAL: numeric value required\7\n");return 2;};
  int t=strtoul (argv [2], &tmp, 10);
  if (*tmp) {printf ("\nFATAL: numeric value required\7\n");return 2;};
  int b=strtoul (argv [3], &tmp, 10);
  if (*tmp) {printf ("\nFATAL: numeric value required\7\n");return 2;};
  int e=b+t-f;
  if (f<0||f>250||t<0||t>250||b<0||b>250||e<0||e>250||f>t)
    {printf ("\ninvalid parameter values\7\n");return 2;};
  for (i=b; i<=e; i++) {
    sprintf (buf, "%.2i", i);
    sprintf (buf2, "do%.2i.pas", i);
    sprintf (buf3, "do%.2i.dpr", i);
    sprintf (buf4, "%.2i.a", i);
    if ((i<f||i>t)&&(!access (buf, 0)||!access (buf2, 0)||!access (buf3, 0)||!access (buf4, 0)))
      {printf ("\nFATAL: test %.2i already exists\7\n", i);return 3;};
  };
  for (i=(b<f)?f:t;(b<f)?i<=t:i>=f;i+=(b<f)?1:-1) {
    int cnt=0;
    sprintf (buf, "%.2i", i);
    sprintf (buf2, "%.2i", i-f+b);
    if (!access (buf, 0))
      if (rename (buf, buf2)) 
        {printf ("\nFATAL: unable to rename %i to %i\7\n", i, i-f+b);return 4;}
      else ++cnt;
    sprintf (buf, "%.2i.a", i);
    sprintf (buf2, "%.2i.a", i-f+b);
    if (!access (buf, 0))
      if (rename (buf, buf2)) 
        {printf ("\nFATAL: unable to rename %i.a to %i.a\7\n", i, i-f+b);return 4;}
      else ++cnt;
    sprintf (buf, "do%.2i.pas", i);
    sprintf (buf2, "do%.2i.pas", i-f+b);
    if (!access (buf, 0))
      if (rename (buf, buf2))
        {printf ("\nFATAL: unable to rename do%i.pas to do%i.pas\7\n", i, i-f+b);return 4;}
      else ++cnt;
    sprintf (buf, "do%.2i.dpr", i);
    sprintf (buf2, "do%.2i.dpr", i-f+b);
    if (!access (buf, 0))
      if (rename (buf, buf2))
        {printf ("\nFATAL: unable to rename do%i.dpr to do%i.dpr\7\n", i, i-f+b);return 4;}
      else ++cnt;
    if (cnt) printf ("%.2i renamed to %.2i\n", i, i-f+b);
        else printf ("WARNING: unable to find %.2i\n", i);
  };
  return 0;
};