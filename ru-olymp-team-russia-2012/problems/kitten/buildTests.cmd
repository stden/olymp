@echo off

set author=pkun
set fail_test=""

for %%i in (.) do set problem=kitten

mkdir tests

cd src
echo Generating tests...
python genTests.py || goto CompGenError
cd ..

echo Compiling validator
if EXIST Validate.java (javac Validate.java || goto continue)
:continue

echo Compiling author solution
if EXIST %problem%_%author%.cpp (g++ %problem%_%author%.cpp -o %problem%_%author%.exe || goto CompSourceError)
rem if EXIST %problem%_%author%.dpr (dcc32 -cc %problem%_%author%.dpr || goto CompSourceError)
if EXIST %problem%_%author%.java (javac %problem%_%author%.java -encoding utf8 || goto CompSourceError)

rem javac %problem%_%author%.java || goto CompSourcesError

if exist check.dpr dcc32 -U..\..\lib -cc check.dpr
rem if exist Check.java javac -classpath testlib4j.jar Check.java -encoding utf8 
if exist Check.java javac -classpath ../../lib/testlib4j.jar Check.java -encoding utf8 
if exist Check.class jar cf Check.jar *.class

echo Generating answers...
for %%i in (tests\??) do (
    echo Test %%i
    copy %%i %problem%.in > nul
    if exist Validate.class (
    	java Validate < %problem%.in
    	if errorlevel 1 (
    		echo Validator doesn't accept test %%i
    		goto End
    	)
    	echo Validator accepts test %%i
    )

    set fail_test = %%i

    if EXIST %problem%_%author%.exe (call %problem%_%author%.exe || goto SourceRunningError)
rem    if EXIST %problem%_%author%.class (call java %problem%_%author% || goto SourceRunningError)
    if EXIST %problem%_%author%.class (call java -Xmx256M -Xss64M -ea %problem%_%author% || goto SourceRunningError)
    if EXIST %problem%_%author%.py (call python %problem%_%author%.py || goto SourceRunningError)

    copy %problem%.out %%i.a > nul
    if exist check.exe check %%i %%i.a %%i.a
	if exist Check.class java -Xmx256M -Xss64M -cp ../../lib/testlib4j.jar;. ru.ifmo.testlib.CheckerFramework Check %%i %%i.a %%i.a
  
)

goto End

:CompGenError 
  echo Cannot compile generator
  goto End
:CompValError 
  echo Cannot compile validator
  goto End
:GenError 
  echo Cannot generate tests
  goto End
:CompSourcesError
  echo Cannot compile source
  goto End
:SourceRunningError
  echo Fail in generating answers on test %fail_test%

:End

rem call clean
