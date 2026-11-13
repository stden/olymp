@echo off
if exist %1.class goto ok
if not exist %1.exe goto noexe
:ok
rem tests solution %1 using input %2 and output %3 on test %4 idout %5
if "%5"=="" goto fail
echo running %1 on %4
if "%2"=="stdin" goto stdin
copy %4 %2 >nul
set curinputfile=nul
goto continput
:stdin
set curinputfile=%4
:continput
if "%3"=="stdout" goto stdout
if exist %3 del %3
set curoutputfile=con
goto contoutput
:stdout
set curoutputfile=%4.%5
:contoutput
if exist %1.class java %1 <%curinputfile% >%curoutputfile%
if not exist %1.class %1.exe <%curinputfile% >%curoutputfile%
if "%3"=="stdout" goto contoutput1
copy %3 %4.%5 >nul
:contoutput1
echo.|time
goto exit
:noexe
echo *** Executable not found, unable to test solution
pause
goto exit
:fail
echo *** ERROR: testsol should be invoked with at least 5 parameters
pause
:exit
