echo off
cls
copy ??.hand ??
g++ -Wall -O3 gen_last.cpp -o gen_last.exe
g++ -Wall -O3 gen_prev.cpp -o gen_prev.exe
g++ -Wall -O3 gen_random.cpp -o gen_random.exe
g++ -Wall -O3 gen_triple.cpp -o gen_triple.exe
g++ -Wall -O3 ..\next_ir.cpp -o next_ir.exe
gen_last.exe 100 >02
gen_last.exe 1000 >03
gen_last.exe 10000 >04
gen_prev.exe 100 >05
gen_prev.exe 1000 >06
gen_prev.exe 10000 >07
gen_random.exe 123 100 >08
gen_random.exe 789 1000 >09
gen_random.exe 101112 1000 >10
gen_triple.exe 456 100 >11
gen_triple.exe 101112 1000 >12
gen_triple.exe 192021 10000 >13
gen_triple.exe 456123 100 >14
gen_triple.exe 10132 1000 >15
gen_triple.exe 19231 10000 >16
for %%i in (??) do (
    copy %%i next.in >nul
    next_ir.exe
    copy next.out %%i.a >nul
)
