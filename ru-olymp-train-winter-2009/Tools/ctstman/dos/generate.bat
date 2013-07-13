@echo off
if "%1"=="" goto all
call %ctstman%\generath %1
goto exit
:all
if exist doall.cmd call doall.cmd
if exist tests\doall.cmd call tests\doall.cmd
call %ctstman%\forallt %ctstman%\generath.bat
:exit
