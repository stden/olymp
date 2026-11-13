@echo off
copy ??.hand ?? >nul
g++ -O3 -Wall gen_line.cpp -o gen_line.exe
g++ -O3 -Wall gen_full.cpp -o gen_full.exe
g++ -O3 -Wall gen_random.cpp -o gen_random.exe
gcc -c -o treeunit.o treeunit.c
g++ -O3 -Wall -Wl,--stack=67108864 -B . tree_ir_half.cpp treeunit.o -o tree_ir_half.exe
gen_line 100 1000 >02
gen_full 101 1000 2 >03
gen_full 102 1000 3 >04
gen_full 103 1000 4 >05
gen_random 104 1000 3 >06
gen_random 105 1000 3 >07
gen_random 106 1000 4 >08
gen_random 107 1000 4 >09
gen_random 108 1000 5 >10
gen_random 109 1000 5 >11
gen_line 110 200000 >12
gen_full 111 200000 2 >13
gen_full 112 200000 3 >14
gen_full 113 200000 4 >15
gen_random 114 200000 3 >16
gen_random 115 200000 3 >17
gen_random 116 200000 4 >18
gen_random 117 200000 4 >19
gen_random 118 200000 5 >20
gen_random 119 200000 5 >21
for %%i in (??) do (
    echo Test %%i
    copy %%i 1371283.in >nul
    tree_ir_half.exe
    copy 1371283.out %%i.a >nul
)
