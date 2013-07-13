@echo off

for %%i in (..) do set problem_name=%%~ni

echo problem_name

copy ..\%problem_name%_%1.* .\*
if EXIST %problem_name%_%1.dpr dcc32 -cc %problem_name%_%1.dpr
if EXIST %problem_name%_%1.cpp cl %problem_name%_%1.cpp
if EXIST %problem_name%_%1.java javac %problem_name%_%1.java

for %%i in (??) do (
    echo %%i
    copy %%i %problem_name%.in > nul
    if EXIST %problem_name%_%1.exe %problem_name%_%1.exe
    if EXIST %problem_name%_%1.class java %problem_name%_%1
    copy %problem_name%.out %%i.a > nul
)
