@echo off
if exist noswipe.flg goto fail
if "%1" == "" goto 1
if exist %1\*.* goto 3
if exist %1\testtask.bat goto 3
if exist %1\01 goto 3
if exist %1\%1.pas goto 3
if exist %1\%1.dpr goto 3
if exist %1\%1.in goto 3
if not exist %1 goto 2
:3
cd %1        
echo Cleaning: %1
goto 4
:fail
echo Wiping is disabled in this directory.
goto 2
:1
echo Cleaning current directory...
:4
for %%a in (b d e o p q r s t u v w x y z) do call %ctstman%\wipeout %%a
for %%a in (*.in *.out in.txt out.txt input.txt output.txt *.exe *.map *.bak) do call %ctstman%\sildel %%a
for %%a in (*.tpu bp.psm fc0ut crfile *.~* *.dsk *.dcu *.obj) do call %ctstman%\sildel %%a
if exist wipecur.bat call wipecur.bat
if "%1" == "" goto 2
cd ..
:2
