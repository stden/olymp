@echo off
if "%1" == "" (
    exit       
)

for %%i in (..) do (
    set problem_name=%%~ni
)

if NOT EXIST check.exe (      
    dcc32 -cc ..\check.dpr
    copy ..\check.exe check.exe
)

if NOT "%2" == "" (
    if EXIST %problem_name%_%1.exe   goto compiled
    if EXIST %problem_name%_%1.class goto compiled
)

copy ..\%problem_name%_%1.* .\*
if EXIST %problem_name%_%1.dpr dcc32 -cc %problem_name%_%1.dpr
rem if EXIST %problem_name%_%1.cpp cl %problem_name%_%1.cpp
if EXIST %problem_name%_%1.cpp g++ -O2 %problem_name%_%1.cpp -o %problem_name%_%1.exe
if EXIST %problem_name%_%1.java javac %problem_name%_%1.java

:compiled


if "%2" == "" (    
    for %%i in (??) do (        
        call docheck %1 %%i
    )
) else (
    echo Running on test: %2
    copy %2 %problem_name%.in > nul
    if EXIST %problem_name%_%1.exe run -t 2 %problem_name%_%1.exe
    if EXIST %problem_name%_%1.class run -Xifce -t 2 java -Xss64M -Xmx256M %problem_name%_%1
    check %problem_name%.in %problem_name%.out %2.a
)