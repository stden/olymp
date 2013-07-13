@echo off
dcc32 -cc gen.dpr
gen
del gen.exe
call genans.bat