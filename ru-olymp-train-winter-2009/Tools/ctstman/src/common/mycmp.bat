@echo off
if exist %1.pas goto pas
if exist %1.dpr goto dpr
goto exit
:pas
call mytpc %1.pas
goto exit
:dpr
call mydcc %1.dpr
goto exit
:exit
