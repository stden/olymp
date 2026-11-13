#!/bin/bash

for t in sum_petr sum_check_test genrand; do
 rm $t || rm $t.exe
done

rm ??
rm ??.a
