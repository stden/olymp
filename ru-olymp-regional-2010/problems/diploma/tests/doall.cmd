@echo off

for %%i in (*.t) do (
  copy %%i %%~ni > nul
)

call dcc32 -cc split.dpr
call dcc32 -cc genrand.dpr
call dcc32 -cc genrand2.dpr
call dcc32 -cc genrand3.dpr
call split.exe
del split.exe

call genrand 1000 1000 25435 > 09
call genrand 1000 1000 645645 > 10
call genrand 1000 1000 7446446 > 11
call genrand 1000 1000 64564577 > 12

call genrand3 1000000000 1000000000 654743 > 13
call genrand3 1000000000 1000000000 346343 > 14

call genrand2 1000000 10000000 743634 > 15
call genrand2 1000000 10000000 734633 > 16
call genrand2 1000000 10000000 663634 > 17
call genrand2 1000000 10000000 721955 > 18
call genrand2 1000000 10000000 732456 > 19
call genrand2 1000000 10000000 134257 > 20

del genrand.exe
del genrand2.exe
del genrand3.exe

rem call javac TestsGen.java
rem call java TestsGen
rem del TestsGen.class

dcc32 -cc ..\check.dpr

call tall sp
call docheck sp

