for %%i in (*.dpr) do (
  dcc32 -cc %%i
)
javac ../*java
copy *.t *.

gen_test.exe 5 5 20 62565 >02
gen_test.exe 4 6 10 5526 >03
gen_test.exe 7 11 40 8368 >04
gen_test.exe 7 11 30 11111 >05
gen_test.exe 50 30 100 234 >06
gen_test.exe 40 40 80 3145436 >07
gen_test.exe 100 100 250 3436 >08
gen_test.exe 149 151 500 769536 >09
gen_test.exe 200 205 501 7593415 >10
gen_test.exe 200 205 1000 86754455 >11
gen_test.exe 300 305 601 25143534 >12
gen_test.exe 333 333 777 21567456 >13
gen_test.exe 333 444 1000 7954634 >14
gen_test.exe 33 600 70 353453 >15
gen_test.exe 555 600 2000 3452563 >16
gen_test.exe 800 600 3000 562456 >17
gen_test.exe 777 777 4000 9866542 >18
gen_test.exe 1000 1000 5000 132545 >19
gen_test.exe 999 1000 10000 474571 >20
gen_test.exe 999 997 4444 7961561 >21
gen_test.exe 998 977 6666 71435943 >22
gen_test.exe 999 999 5555 8763485 >23
gen_test.exe 1000 1000 6000 54871523 >24
gen_test25.exe >25
gen_test.exe 1000 1000 10000 45314553 >26

for %%i in (??) do (
  copy %%i "../pairs.in"
  cd ..
  java pairs_as
  copy pairs.out "tests/%%i.a"
  del pairs.in
  del pairs.out
  cd tests
)