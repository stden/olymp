@echo off
if "%3"=="" goto error
echo %1, %2:
check%1 %2 %2.%3 %2.%4 | %ctstman%\colorchk.exe
goto exit
:error
echo *** Internal error: Invalid usage of command (check_it)
pause
:exit
