@echo off
cd common
wmake
if errorlevel 1 goto fail
cd ..
cd dos
wmake
if errorlevel 1 goto fail
cd ..
cd nt
wmake
if errorlevel 1 goto fail
cd ..
if not exist ..\dos md ..\dos
if not exist ..\nt  md ..\nt
echo y|del /f ..\dos\*.*
echo y|del /f ..\nt\*.*
copy common\*.bat ..\dos\*.bat
copy common\*.bat ..\nt\*.bat
copy dos\*.bat ..\dos\*.bat
copy nt\*.bat ..\nt\*.bat
copy common\*.exe ..\dos\*.exe
copy common\*.exe ..\nt\*.exe
copy dos\*.exe ..\dos\*.exe
copy nt\*.exe ..\nt\*.exe
attrib ..\dos\*.* +r
attrib ..\nt\*.* +r
echo *** ContestMan successfully created ***
goto ok
:fail
echo *** Unable to create ContestMan ***
:ok
