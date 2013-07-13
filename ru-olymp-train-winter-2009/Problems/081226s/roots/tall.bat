call dcc32 -cc solution.dpr
for /l %%i in (1,1,9) do call t 0%%i
for /l %%i in (10,1,99) do call t %%i
del solution.exe