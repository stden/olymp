@echo off
set TASK=maxsum
for /l %%i in (1,1,9) do if exist 0%%i call testone 0%%i
for /l %%i in (10,1,99) do if exist %%i call testone %%i
