#!/bin/bash
fpc genrandom
fpc genrandompalin
echo GENERATING TESTS
cp 01.hand 01
echo TEST 01
cp 02.hand 02
echo TEST 02
cp 03.hand 03
echo TEST 03
./genrandom 100 0.1 > 04
echo TEST 04
./genrandom 200 0.9 > 05
echo TEST 05
./genrandom 399 0.6 > 06
echo TEST 06
./genrandom 499 0.2 > 07
echo TEST 07
./genrandompalin 699 0.4 > 08
echo TEST 08
./genrandompalin 1000 0.45 > 09
echo TEST 09
./genrandom 1501 0.4 > 10
echo TEST 10
./genrandom 3000 0.6 > 11
echo TEST 11
./genrandompalin 5001 0.7 > 12
echo TEST 12
./genrandom 6789 0.5 > 13
echo TEST 13
./genrandom 10000 0.3 > 14
echo TEST 14
./genrandom 1000000 0.5 > 15
echo TEST 15
./genrandom 2000000 0.6 > 16
echo TEST 16
./genrandom 2500001 0.1 > 17
echo TEST 17
./genrandom 2700002 0.9 > 18
echo TEST 18
./genrandom 2800001 0.8 > 19
echo TEST 19
./genrandom 2900004 0.1 > 20
echo TEST 20
./genrandompalin 3000000 0.5 > 21
echo TEST 21
echo DONE
echo GENERATING ANSWERS
fpc ../palin_vv.pas -FE.
for ((i=1;i<10;i++)); do 
        echo TEST 0$i
        cp 0$i palin.in
        ./palin_vv
        cp palin.out 0$i.a
done
for ((i=10;i<22;i++)); do 
        echo TEST $i
        cp $i palin.in
        ./palin_vv
        cp palin.out $i.a
done
rm *.o
rm *.in
rm *.out
