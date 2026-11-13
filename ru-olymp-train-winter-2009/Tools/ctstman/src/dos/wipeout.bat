@echo off
if "%2"=="" goto all
del %2.%1
goto exit
:all
del ?.%1
del ??.%1
del ???.%1
:exit