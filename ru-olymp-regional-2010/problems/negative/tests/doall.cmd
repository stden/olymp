@echo off


dcc32 -cc gen.dpr

gen.exe 1 1 4378279 > 01
gen.exe 2 1 4378280 > 02
gen.exe 1 2 4378281 > 03
gen.exe 3 3 4378282 > 04
gen.exe 4 4 4378283 > 05
gen.exe 6 3 4378284 > 06
gen.exe 7 5 4378285 > 07
gen.exe 9 8 4378286 > 08
gen.exe 4 10 4378287 > 09
gen.exe 10 10 4378288 > 10

gen.exe 78 89 9317001 > 11
gen.exe 94 99 2411347 > 12
gen.exe 53 34 1174153 > 13
gen.exe 44 59 3103204 > 14
gen.exe 38 58 7546875 > 15
gen.exe 53 53 7403967 > 16
gen.exe 31 16 7910829 > 17
gen.exe 81 79 2750942 > 18
gen.exe 28 89 4670777 > 19
gen.exe 100 100 1476086 > 20

del gen.exe

call tall ft
call docheck ft