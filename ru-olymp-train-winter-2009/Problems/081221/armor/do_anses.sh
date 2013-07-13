#!bin/sh
fpc armor_ak_3k.pas
fpc armor_ak_4k.pas
g++ -O2 -Wall armor_ik_chk.cpp -o armor_ik_chk

for i in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21; do 
    echo Test $i
    cp $i armor.in
    ./armor_ak_3k
    cp armor.out $i.a
    ./armor_ak_4k
    if ! diff $i.a armor.out; then echo wrong output on test $i!!!; fi
    ./armor_ik_chk
    if ! diff $i.a armor.out; then echo wrong output on test $i!!!; fi
done
