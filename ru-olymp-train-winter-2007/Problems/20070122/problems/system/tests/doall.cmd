cl /GX gen.cpp
cl /GX gen_b.cpp
cl /GX gen_verynew.cpp
cl /GX gen25.cpp
cl /GX ..\system_dd.cpp
copy system_dd.exe solution.exe

gen.exe 5 20 0 100 1 20 2 1 1169448441 > 02
gen.exe 5 20 0 100 1 20 2 1 1169448447 > 03
gen.exe 5 20 0 100 1 20 2 1 1169448475 > 04
gen_b.exe 190 200 900 1000 50 200 100 5 -846616899 > 05
gen_b.exe 190 200 900 1000 50 200 100 5 1522380546 > 06
gen_b.exe 190 200 900 1000 50 200 100 5 -1223499250 > 07
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -762417240 > 08
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -2078785228 > 09
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -920654164 > 10
gen_verynew.exe 190 200 9900 10000 1 30 200 1 189788146 > 11
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -107419838 > 12
gen_verynew.exe 190 200 9900 10000 1 30 200 1 1140586562 > 13
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -276957672 > 14
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -2134199320 > 15
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -1077405180 > 16
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -1469749434 > 17
gen_verynew.exe 190 200 9900 10000 1 30 200 1 741060964 > 18
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -2350420 > 19
gen_verynew.exe 190 200 9900 10000 1 30 200 1 1198649036 > 20
gen_verynew.exe 190 200 9900 10000 1 30 200 1 -2099130586 > 21
gen.exe 190 200 9900 10000 1 100 100 2 1128679022 > 22
gen.exe 190 200 9900 10000 1 100 100 2 1706715472 > 23
gen.exe 190 200 9900 10000 1 100 100 2 1130824485 > 24
gen25.exe > 25

rem gen.exe 190 200 9900 10000 1 100 100 2 -436134143 > 25


rem gen.exe 190 200 9900 10000 1 100 100 2 -1014537538 > 26


rem gen_verynew.exe 190 200 9900 10000 1 30 200 1 -1120989572 > 22
rem gen_verynew.exe 190 200 9900 10000 1 30 200 1 430321652 > 23
rem gen_verynew.exe 190 200 9900 10000 1 30 200 1 -862941540 > 24
rem gen_verynew.exe 190 200 9900 10000 1 30 200 1 -164874970 > 25
rem gen_verynew.exe 190 200 9900 10000 1 30 200 1 -2010803708 > 26



copy 01 system.in
solution.exe
copy system.out 01.a
copy 02 system.in
solution.exe
copy system.out 02.a
copy 03 system.in
solution.exe
copy system.out 03.a
copy 04 system.in
solution.exe
copy system.out 04.a
copy 05 system.in
solution.exe
copy system.out 05.a
copy 06 system.in
solution.exe
copy system.out 06.a
copy 07 system.in
solution.exe
copy system.out 07.a
copy 08 system.in
solution.exe
copy system.out 08.a
copy 09 system.in
solution.exe
copy system.out 09.a
copy 10 system.in
solution.exe
copy system.out 10.a
copy 11 system.in
solution.exe
copy system.out 11.a
copy 12 system.in
solution.exe
copy system.out 12.a
copy 13 system.in
solution.exe
copy system.out 13.a
copy 14 system.in
solution.exe
copy system.out 14.a
copy 15 system.in
solution.exe
copy system.out 15.a
copy 16 system.in
solution.exe
copy system.out 16.a
copy 17 system.in
solution.exe
copy system.out 17.a
copy 18 system.in
solution.exe
copy system.out 18.a
copy 19 system.in
solution.exe
copy system.out 19.a
copy 20 system.in
solution.exe
copy system.out 20.a
copy 21 system.in
solution.exe
copy system.out 21.a
copy 22 system.in
solution.exe
copy system.out 22.a
copy 23 system.in
solution.exe
copy system.out 23.a
copy 24 system.in
solution.exe
copy system.out 24.a
copy 25 system.in
solution.exe
copy system.out 25.a
copy 26 system.in
solution.exe
copy system.out 26.a
