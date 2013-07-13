@echo off

for %%i in (*.t) do (
  copy %%i %%~ni > nul
)


call javac TestGen.java
call java TestGen
rmdir /S /Q tests
dcc32 -cc ..\check.dpr

call tall sm
rem call docheck sm
