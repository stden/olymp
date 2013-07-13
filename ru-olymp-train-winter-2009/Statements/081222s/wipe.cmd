@echo off
for %%t in (*.tex) do (
 for %%x in (aux dvi log ps pdf) do (
  if exist %%~nt.%%x erase %%~nt.%%x
 )
)
