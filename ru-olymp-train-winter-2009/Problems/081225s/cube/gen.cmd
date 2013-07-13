@echo off
dcc32 -cc gen1.dpr
dcc32 -cc gen2.dpr
echo. >>cube.in
gen1 5 0 >>cube.in
echo. >>cube.in
gen1 6 1 >>cube.in
echo. >>cube.in
gen1 7 2 >>cube.in
echo. >>cube.in
gen1 8 3 >>cube.in
echo. >>cube.in
gen1 9 999 >>cube.in
echo. >>cube.in
gen1 10 1000 >>cube.in
echo. >>cube.in
gen2 3 1 5 1231 >>cube.in
echo. >>cube.in
gen2 4 12 25 1232 >>cube.in
echo. >>cube.in
gen2 5 998 999 1233 >>cube.in
echo. >>cube.in
gen2 6 5 6 1234 >>cube.in
echo. >>cube.in
gen2 7 0 100 1235 >>cube.in
echo. >>cube.in
gen2 8 1 900 1236 >>cube.in
echo. >>cube.in
gen2 9 0 1 1237 >>cube.in
echo. >>cube.in
gen2 10 1 1000 1238 >>cube.in
echo. >>cube.in
gen2 10 500 999 1239 >>cube.in
