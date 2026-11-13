#!/bin/bash
rm ??
rm ??.a
for t in palin_vv genrandom genrandompalin; do
 rm $t || rm $t.exe
done
rm *.o
rm *.in
rm *.out
