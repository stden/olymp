@echo off
dcc32 -cc ..\psyche_pm
for /L %%i in (1 1 9) do call ansone 0%%i
for /L %%i in (10 1 25) do call ansone %%i
