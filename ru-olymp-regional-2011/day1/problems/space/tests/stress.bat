if "%2" == "" (
	echo Use: %0 suffix1 suffix2
	echo Ex: %0 aa ab
    exit       
)

for %%i in (..) do (
    set problem_name=%%~ni
)

javac ..\%problem_name%_%1.java
javac ..\%problem_name%_%2.java
dcc32 -cc ..\check.dpr

rem Compile generator
javac gen_spy.java

:loop

rem Launch generator
java gen_spy stress spy.in

java -cp .. %problem_name%_%1
copy %problem_name%.out %problem_name%.tmp
java -cp .. %problem_name%_%2

..\check.exe %problem_name%.in %problem_name%.out %problem_name%.tmp

if ERRORLEVEL 1 (
	copy %problem_name%.in 01
	copy %problem_name%.tmp 01.a
	goto exit
) else (
	goto loop
)

:exit