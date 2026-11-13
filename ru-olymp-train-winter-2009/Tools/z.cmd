@echo off
if NOT exist dos2unix.exe goto Error
cd problems
for /d %%b in (*) do (
  echo Converting: %%b
  cd %%b
  call forallt ..\..\x
  cd ..
)
cd ..
goto End1
:Error
echo dos2unix.exe not found!
goto End1
:End1
