@echo off
call include.cmd
for %%t in (%HAND%) do (
 ren %%t %%t.tmp
)
for /l %%i in (0,1,9) do (
 if exist 0%%i (
  erase 0%%i
 )
 if exist 0%%i.a (
  erase 0%%i.a
 )
)
for /l %%i in (10,1,99) do (
 if exist %%i (
  erase %%i
 )
 if exist %%i.a (
  erase %%i.a
 )
)
for /l %%i in (0,1,9) do (
 if exist 00%%i (
  erase 00%%i
 )
 if exist 00%%i.a (
  erase 00%%i.a
 )
)
for /l %%i in (10,1,99) do (
 if exist 0%%i (
  erase 0%%i
 )
 if exist 0%%i.a (
  erase 0%%i.a
 )
)
for /l %%i in (100,1,999) do (
 if exist %%i (
  erase %%i
 )
 if exist %%i.a (
  erase %%i.a
 )
)
for %%t in (%HAND%) do (
 ren %%t.tmp %%t
)
if exist %SOL%.exe erase %SOL%.exe
if exist check.exe erase check.exe
if exist gen*.exe erase gen*.exe
