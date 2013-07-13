@echo off

for %%i in (*.t) do (
  copy %%i %%~ni > nul
)

dcc32 -cc ..\check.dpr

call tall rs
call docheck rs

