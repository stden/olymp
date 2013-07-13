#!/bin/bash
fpc genrand.dpr
fpc sum_petr.pas
fpc sum_check_test.pas
cp 01.hand 01
./genrand 1 100 2 0.5 0.5 > 02
./genrand 100 100 5 0.7 0.7 > 03
./genrand 300 200 3 0.3 0.4 > 04
./genrand 1000 600 4 0.8 1.0 > 05
./genrand 5000 6000 2 0.7 0.9 > 06
./genrand 10000 10000 5 0.8 0.6 > 07
./genrand 30000 30000 4 0.9 0.3 > 08
./genrand 32000 28000 4 0.5 0.5 > 09
./genrand 34000 38000 3 0.9 0.1 > 10
./genrand 50000 50000 5 0.7 0.7 > 11
./genrand 60000 61000 2 0.8 0.6 > 12
./genrand 62000 63000 5 0.6 0.9 > 13
./genrand 65000 69000 3 0.1 0.2 > 14
./genrand 70000 71000 5 0.7 0.7 > 15
./genrand 75000 75000 5 0.8 0.5 > 16
./genrand 80000 79000 4 0.9 0.6 > 17
./genrand 86000 86000 3 0.2 0.5 > 18
./genrand 90000 91000 4 0.4 0.4 > 19
./genrand 95000 96000 5 0.5 0.7 > 20
./genrand 100000 100000 5 0.7 0.8 > 21

for ((i=1;i<10;i=i+1)); do
        echo Test 0$i
        cp 0$i sum.in
        ./sum_check_test
        ./sum_petr
        cp sum.out 0$i.a
done


for ((i=10;i<22;i=i+1)); do
        echo Test $i
        cp $i sum.in
        ./sum_check_test
        ./sum_petr
        cp sum.out $i.a
done

rm sum.in
rm sum.out
rm *.o
