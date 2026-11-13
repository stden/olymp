@echo off
if "%1"=="" goto ct
if exist check.exe goto work
call %ctstman%\mycmp check
if not exist check.exe goto fail
:work
echo checking answers *.%1 with *.%2
call %ctstman%\foralltc %ctstman%\check_it %1 %2
rem for %%f in (???.) do call %ctstman%\check_it %%f %1 %2
goto exit
:ct
%ctstman%\check b a
goto exit
:fail
echo *** FATAL: Unable to find checker
pause
:exit
