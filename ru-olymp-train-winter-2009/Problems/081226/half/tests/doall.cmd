copy ??.hand ??
g++ -O3 -Wall ..\half_ir_opt1.cpp -o solver.exe
g++ -O3 -Wall gen.cpp -o gen.exe
gen.exe 1231 10 0.4 > 02
gen.exe 1131 10 0.5 > 03
gen.exe 1331 10 0.6 > 04
gen.exe 11231 20 0.4 > 05
gen.exe 11141 20 0.5 > 06
gen.exe 11351 20 0.6 > 07
gen.exe 21261 26 0.4 > 08
gen.exe 21171 26 0.5 > 09
gen.exe 21381 26 0.6 > 10
gen.exe 21291 30 0.4 > 11
gen.exe 21102 30 0.5 > 12
gen.exe 213123 30 0.6 > 13
gen.exe 212314 30 0.4 > 14
gen.exe 211135 30 0.5 > 15
gen.exe 213236 30 0.6 > 16
for %%i in (??) do (
    copy %%i half.in
    solver.exe
    copy half.out %%i.a
)
