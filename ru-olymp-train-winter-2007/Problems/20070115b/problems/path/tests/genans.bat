@echo off
dcc32 -cc ..\sol.dpr
for %%1 in (??) do (
  echo %%1
  copy %%1 input.txt
  ..\sol.exe
  copy output.txt %%1.a
  del input.txt
  del output.txt
)
del ..\sol.exe