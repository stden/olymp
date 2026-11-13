@echo off
if exist pics (
 pushd pics
 for %%t in (*.mp) do (
  for %%x in (log 1 2 3 4 5 6 7 8 9) do (
   if exist %%~nt.%%x erase %%~nt.%%x
  )
 )
 popd
)
for %%t in (*.tex) do (
 for %%x in (aux dvi log ps pdf) do (
  if exist %%~nt.%%x erase %%~nt.%%x
 )
)
