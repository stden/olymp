@echo off
if exist do%1.dpr goto isdelphi
if not exist do%1.pas goto exit
echo Creating test file %1
call mytpc do%1
goto work
:isdelphi
echo Creating test file %1
call mydcc do%1
:work
do%1.exe>%1
:exit
