@echo off
for %%f in (*.dpr) do dcc32 -cc %%f

copy 01.t 01 >nul
copy 02.t 02 >nul
genrand 10 10 >03
genrandexp 10 100 >04
genrand 100 100 >05
genrandexp 100 1000000 >06
genlinear 100 1000000 -9999 >07
genrandhole 100 1000000 >08
genrand 1000 1000000 >09
genrandhole 2000 974322 >10
genrandexp 2500 9324 >11
genrandexp 3000 1000000 >12
genlinear 3000 1 321 >13
genrand 30000 1000000 >14
genrandexp 40000 1000000 >15
genrandhole 50000 1000000 >16
genlinear 99999 999999 -10 >17
genrandexp 77329 9237 >18
genrandhole 100000 1000000 >19
genrand 100000 1000000 >20
genrandexp 100000 1000000 >21
genfunny2 100000 1000000 3 >22
genfunny 99999 1 0 999999 1000000 >23

dcc32 -E. ..\code_petr.dpr
dcc32 -E. ..\check.dpr

for %%f in (??) do (
  echo Test %%f
  copy %%f code.in >nul
  code_petr
  copy code.out %%f.a >nul
)
