@echo off
if exist do%1.pas call %ctstman%\sildel %1
if exist do%1.dpr call %ctstman%\sildel %1
