@echo off

rem for %%i in (*.t) do (
rem   copy %%i %%~ni > nul
rem )

call javac TestGen.java
call java TestGen

call dcc32 -cc ..\check.dpr

call tall mn
