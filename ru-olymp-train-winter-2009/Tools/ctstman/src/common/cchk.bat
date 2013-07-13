@echo off
if not exist check%1.exe call %ctstman%\mycmp check
if exist check%1.exe goto exit
echo *** FATAL: Unable to create checker
pause
:exit
