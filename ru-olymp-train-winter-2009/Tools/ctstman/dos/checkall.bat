@echo off
if "%1" == "" goto exit
if "%2" == "" goto ct
if exist check%1.exe goto work
call %ctstman%\mycmp check%1
if not exist check%1.exe goto fail
:work
echo checking answers *.%2 with *.%3
call %ctstman%\foralltc %ctstman%\checkal_ %1 %2 %3
rem for %%f in (???.) do call %ctstman%\checkit %1 %%f %2 %3
goto exit
:ct
%ctstman%\checkall %1 b a
goto exit
:error
echo *** Error: task identifier should be specified
goto exit
:fail
echo *** FATAL: Unable to find checker
pause
:exit
