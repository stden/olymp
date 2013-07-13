for %%f in (*.dpr) do (
  dcc32 -cc %%f
)

for /L %%i in (1 1 9) do (
  if exist do0%%i.exe do0%%i.exe >0%%i
)
for /L %%i in (10 1 99) do (
  if exist do%%i.exe do%%i.exe >%%i
)

call ansall
