#include <stdio.h>
#include <stdlib.h>
int main (int argc, char *argv[])
{
  char buf [2048];
  if (argc!=3) {printf ("error: 2 arguments required\7\n"); return 1;};
  FILE *in=fopen (argv[1], "rt");
  if (in==NULL) {printf ("error: unable to open input file\7\n"); return 1;};
  FILE *out=fopen (argv[2], "wt");
  if (out==NULL) {printf ("error: unable to open output file\7\n"); return 1;};
  while (!feof (in))
  {
    if (fgets (buf, sizeof (buf), in)==NULL) break;
    fprintf (out, "%s", buf);
  };
  return 0;
};