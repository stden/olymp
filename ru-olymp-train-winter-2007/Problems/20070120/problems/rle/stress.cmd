@echo off
:l
gen >rle.in
del rle.out
rle_pm_wrong1 >rle.log
move rle.out rle.ans
rle_pm_stupid
fc rle.out rle.ans
if errorlevel 1 goto e
type rle.log >> rle.logs
goto l
:e
pause
