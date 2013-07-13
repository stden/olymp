@echo off
if exist %1 goto tryall
if exist tests\%1 goto tryall
if exist do%1.dpr goto isdelphi
if exist tests\do%1.dpr goto isdelphi
if exist do%1.pas goto ispascal
if not exist tests\do%1.pas goto exit
:ispascal
echo Creating test file %1
if not exist do%1.exe call %ctstman%\mytpc do%1
goto work
:isdelphi
echo Creating test file %1
if not exist do%1.exe call mydcc do%1
:work
do%1.exe>%1
goto exit
:tryall
rem if exists doall.cmd goto okall
rem if not exists tests\doall.cmd goto exit
:okall
rem call %ctstman%\generate
:exit
