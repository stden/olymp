echo off
copy ??.hand ??
g++ -O3 -Wall gen_diff.cpp -o gen_diff.exe
g++ -O3 -Wall gen_random.cpp -o gen_random.exe
g++ -O3 -Wall ..\cuts_ir_fast.cpp -o cuts_ir_fast.exe
gen_diff.exe 101 5 3 0 1 > 02
gen_diff.exe 102 7 6 0 1 > 03
gen_diff.exe 103 8 6 0 1 > 04
gen_diff.exe 104 8 5 0 1 > 05
gen_diff.exe 105 8 3 0 1 > 06
gen_diff.exe 106 7 4 0 1 > 07

gen_diff.exe 101  5 3 0 10 > 08
gen_diff.exe 202  7 6 0 20 > 09
gen_diff.exe 303  8 6 0 30 > 10
gen_random.exe 1023 50 300 300 > 11
gen_random.exe 123 50 300 300 > 12
gen_random.exe 12023 50 300 300 > 13
gen_random.exe 231023 50 300 300 > 14
gen_random.exe 331023 50 300 300 > 15
gen_diff.exe 903  8 6 50 300 > 16
gen_diff.exe 1004 8 5 200 300 > 17
gen_diff.exe 1105 8 6 100 300 > 18
gen_diff.exe 1206 8 6 100 300 > 19
gen_diff.exe 1306 8 6 100 300 > 20
gen_diff.exe 1406 8 6 100 300 > 21

for %%i in (??) do (
    echo Test %%i
    copy %%i cuts.in >nul
    cuts_ir_fast.exe
    copy cuts.out %%i.a >nul
rem    check.exe cuts.in cuts.out cuts.out
)
