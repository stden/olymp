@echo off
if "%1"=="" goto all
call %ctstman%\recreath %1
goto exit
:all
call %ctstman%\forallt %ctstman%\recreath.bat
:exit
