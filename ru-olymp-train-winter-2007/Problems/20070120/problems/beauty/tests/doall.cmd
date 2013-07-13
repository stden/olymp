cl /GX ..\beauty_dd.cpp
copy beauty_dd.exe solution.exe
cl /GX gen06.cpp
cl /GX gen7-8.cpp
cl /GX gen9-11.cpp
cl /GX gen23-26.cpp
cl /GX gen.cpp
gen06.exe
gen7-8.exe
gen9-11.exe
gen23-26.exe

call gen_sk.bat

copy 01 beauty.in
solution.exe
copy beauty.out 01.a
copy 02 beauty.in
solution.exe
copy beauty.out 02.a
copy 03 beauty.in
solution.exe
copy beauty.out 03.a
copy 04 beauty.in
solution.exe
copy beauty.out 04.a
copy 05 beauty.in
solution.exe
copy beauty.out 05.a
copy 06 beauty.in
solution.exe
copy beauty.out 06.a
copy 07 beauty.in
solution.exe
copy beauty.out 07.a
copy 08 beauty.in
solution.exe
copy beauty.out 08.a
copy 09 beauty.in
solution.exe
copy beauty.out 09.a
copy 10 beauty.in
solution.exe
copy beauty.out 10.a
copy 11 beauty.in
solution.exe
copy beauty.out 11.a
copy 12 beauty.in
solution.exe
copy beauty.out 12.a
copy 13 beauty.in
solution.exe
copy beauty.out 13.a
copy 14 beauty.in
solution.exe
copy beauty.out 14.a
copy 15 beauty.in
solution.exe
copy beauty.out 15.a
copy 16 beauty.in
solution.exe
copy beauty.out 16.a
copy 17 beauty.in
solution.exe
copy beauty.out 17.a
copy 18 beauty.in
solution.exe
copy beauty.out 18.a
copy 19 beauty.in
solution.exe
copy beauty.out 19.a
copy 20 beauty.in
solution.exe
copy beauty.out 20.a
copy 21 beauty.in
solution.exe
copy beauty.out 21.a
copy 22 beauty.in
solution.exe
copy beauty.out 22.a
copy 23 beauty.in
solution.exe
copy beauty.out 23.a
copy 24 beauty.in
solution.exe
copy beauty.out 24.a
copy 25 beauty.in
solution.exe
copy beauty.out 25.a
copy 26 beauty.in
solution.exe
copy beauty.out 26.a
