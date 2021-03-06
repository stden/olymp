#!bin/sh
fpc gen_line.pas
fpc gen_rand.pas
fpc gen_tree.pas
fpc gen_mags.pas
fpc gen_mags_zero.pas

cp 01.hand 01
cp 02.hand 02
cp 03.hand 03
cp 21.hand 21

./gen_mags 111111 5 5 2 1 3 500 > 04
./gen_line 211111 5 5 2 500 >> 04

./gen_mags 121111 10 9 2 2 2 1000 > 05
./gen_tree 112111 10 9 2 1000 >> 05

./gen_mags 111211 15 35 2 1 1 10000 > 06
./gen_rand 111121 15 35 2 10000 >> 06


./gen_mags 111112 30 40 4 3 2 2000 > 07
./gen_line 311111 30 40 4 2000 >> 07

./gen_mags 131111 30 40 3 2 4 4000 > 08
./gen_tree 113111 30 40 3 4000 >> 08

./gen_mags 111311 30 40 2 2 1 100 > 09
./gen_rand 111131 30 40 2 100 >> 09


./gen_mags 111113 42 200 5 1 1 10000 > 10
./gen_line 411111 42 200 5 10000 >> 10

./gen_mags 141111 43 200 6 1 1 1000000 > 11
./gen_tree 114111 43 200 6 1000000 >> 11

./gen_mags 111411 45 300 5 1 2 1000000 > 12
./gen_rand 111141 45 300 5 1000000 >> 12

./gen_mags 111114 50 500 7 1 2 10000 > 13
./gen_line 511111 50 500 7 10000 >> 13

./gen_mags 151111 50 500 7 2 2 1000 > 14
./gen_tree 115111 50 500 7 1000 >> 14

./gen_mags 111511 50 500 7 3 2 1000000 > 15
./gen_rand 111151 50 500 7 1000000 >> 15


./gen_mags 111115 50 500 7 3 3 1000000 > 16
./gen_line 611111 50 500 7 1000000 >> 16

./gen_mags 161111 50 500 7 2 2 1000000 > 17
./gen_tree 116111 50 500 7 1000000 >> 17

./gen_mags 111611 50 500 7 2 2 1000000 > 18
./gen_rand 111161 50 500 7 1000000 >> 18

./gen_mags_zero 122221 50 500 7 3 1 1 1000000 > 19
./gen_rand 233332 50 500 7 1000000 >> 19

./gen_mags_zero 344443 20 50 3 2 1 1 10000 > 20
./gen_rand 455554 20 50 3 10000 >> 20
