@echo off
echo testing solution *%1*; input *%2*; output *%3*; extension *.%4*
if "%4"=="" goto fail
if exist %1.exe goto existsol
if exist %1.class goto existsol
if exist %1.java goto dojava
if exist %1.pas goto dopas 
if exist %1.c goto dowc
if exist %1.dpr goto dodelphi
if not exist %1.cpp goto nosol
wcl386 /k16777216 /fm /oxt /5r %1.cpp
goto testexe
:dojava
javac %1.java
goto testclass
:dowc
wcl386 /k16777216 /fm /oxt /5r %1.c
goto testexe
:dodelphi
call mydcc %1
goto testexe
:dopas
call mytpc %1
goto testexe
:testclass
if not exist %1.class goto nosol
goto existsol
:testexe
if not exist %1.exe goto nosol
:existsol
if not exist generate.bat goto skipgen
call generate.bat %5
:skipgen
if not exist tests goto notests
cd tests
call %ctstman%\generate %5
call %ctstman%\wipeout %4 %5
cd ..
goto conttest
:notests
call %ctstman%\generate %5
call %ctstman%\wipeout %4 %5
:conttest
if "%5"=="" goto nospec
echo testing only on test %5
if exist tests\%5 goto intests
if not exist %5 goto nonexistent
echo.|time
call %ctstman%\testsol %1 %2 %3 %5 %4
goto exit
:intests
echo.|time
call %ctstman%\testsol %1 %2 %3 tests\%5 %4
goto exit
:nonexistent
echo Tried to run on non-existent test %5
goto exit
:nospec
echo.|time
rem for %%a in (???) do call %ctstman%\testsol %1 %2 %3 %%a %4
call %ctstman%\foralltc %ctstman%\testtas_ %1 %2 %3 %4
goto exit
:nosol
echo *** ERROR: there is no solution to test
pause
goto exit
:fail
echo *** ERROR: 4 paramaters should be specified for TESTTASK
pause
:exit
