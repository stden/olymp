@echo off

for %%i in (*.t) do (
  copy %%i %%~ni > nul
)


dcc32 -cc ..\check.dpr

call tall sm
call docheck sm
