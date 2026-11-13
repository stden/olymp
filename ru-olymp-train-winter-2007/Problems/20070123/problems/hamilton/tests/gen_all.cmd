@echo off

call clear.cmd
call compile_all.cmd

echo Inputs...

echo 01-03

call do.cmd type 01.hand > 01
call do.cmd type 02.hand > 02
call do.cmd type 03.hand > 03

echo 04-07

call do.cmd gen_rand.exe 1000001    20 100   > 04
call do.cmd gen_rand.exe 1000003   100 100   > 05
call do.cmd gen_rand.exe 1000009   600 100   > 06
call do.cmd gen_rand.exe 1000010  4000   5   > 07

echo 08-12

call do.cmd gen_hard.exe 1000011    21 100   > 08
call do.cmd gen_hard.exe 1000012   501 100   > 09
call do.cmd gen_hard.exe 1000013  2001 10    > 10
call do.cmd gen_hard.exe 1000014  3001 8     > 11
call do.cmd gen_hard.exe 1000015  4001 5     > 12

echo 13-13

call do.cmd gen_hard_old.exe 1000016  4001 5     > 13

echo 14-18

call do.cmd gen1.exe     1000017    21 100   > 14
call do.cmd gen1.exe     1000018   201 100   > 15
call do.cmd gen1.exe     1000019   501 100   > 16
call do.cmd gen1.exe     1000020  2001 10    > 17
call do.cmd gen1.exe     1000021  4001 5     > 18

echo 19-20

call do.cmd gen2.exe     1000022    50 100   > 19
call do.cmd gen2.exe     1000023  4000 5     > 20

echo 21-26

call do.cmd gen3.exe     1000024    20 100   > 21
call do.cmd gen3.exe     1000025   100 100   > 22
call do.cmd gen3.exe     1000026  1000 100   > 23
call do.cmd gen3.exe     1000027  2000 10    > 24
call do.cmd gen3.exe     1000028  4000 5     > 25
call do.cmd gen3.exe     1183758  4000 4     > 26

echo Answers...

for %%i in (*.) do (
  copy %%i hamilton.in
  hamilton_sk.exe
  check.exe hamilton.in hamilton.out
  copy hamilton.out %%i.a
)

del *.exe
del hamilton.in
del hamilton.out
del tmp.tmp
