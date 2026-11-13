@echo off
if "%1"=="" goto error
echo %1:
check %1 %1.%2 %1.%3 | %ctstman%\colorchk.exe
goto exit
:error
echo *** Internal error: Invalid usage of command (check_it)
pause
:exit
