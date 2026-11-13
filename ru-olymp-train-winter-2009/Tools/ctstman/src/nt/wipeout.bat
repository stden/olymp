@echo off
if "%2"=="" goto all
del %2.%1 2>nul
goto exit
:all
del ???.%1 2>nul
:exit
