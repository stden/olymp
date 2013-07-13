@echo off
:l
gen >map.in
del map.out 2>nul
map_pm_slow
move map.out map.ans >nul
map_pm
fc map.out map.ans
if errorlevel 1 goto e
type map.out
goto l
:e
