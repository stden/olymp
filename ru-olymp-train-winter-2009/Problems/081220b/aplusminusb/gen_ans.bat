@echo off
g++ %1

for %%i in (??) do (
  echo Test %%i
  copy %%i %2.in >nul
  a.exe
  copy %2.out %%i.a >nul
)

erase %1.class
erase %2.in
erase %2.out
erase a.exe
