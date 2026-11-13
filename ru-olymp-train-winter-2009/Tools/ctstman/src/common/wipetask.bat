@echo off
if exist noswipe.flg goto fail
if exist nowipe.flg goto fail
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
if "%1" == "tests" goto skipoutput
echo Cleaning: %1
:skipoutput
goto 4
:fail
echo Wiping is disabled in this directory.
goto 2
:1
echo Cleaning current directory...
:4
call %ctstman%\wipecata
for %%a in (a b d e f o p q r s t u v w x y z) do call %ctstman%\wipeout %%a
for %%a in (*.in *.out in.txt out.txt input.txt output.txt *.exe *.obj *.err) do call %ctstman%\sildel %%a
for %%a in (*.map *.bak *.tpu bp.psm fc0ut crfile *.dvi *.~* *.dsk *.dcu *.tds) do call %ctstman%\sildel %%a
if exist wipecur.bat call wipecur.bat
if exist wipe.cmd call wipe.cmd
if exist tests\??.1 goto testsfound
if exist tests\01 goto testsfound
if exist tests\doall.cmd goto testsfound
if exist tests\*.a goto testsfound
if exist tests\wipecur.bat goto testsfound
if not exist tests\do??.dpr goto notests
:testsfound
if "%1" == "" goto emptydisp
echo Cleaning: %1\tests
goto contafterdisp
:emptydisp
echo Cleaning: tests
:contafterdisp
call %ctstman%\wipetask tests
:notests
if "%1" == "" goto 2
cd ..
:2
