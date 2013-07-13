@echo off
call include.cmd
if exist ..\%SOL%.cpp (
 g++ -O2 -Wall -Wl,--stack=67108864 ..\%SOL%.cpp -o %SOL%.exe
) else if exist ..\%SOL%.dpr (
 dcc32 -cc ..\%SOL%.dpr -e.
)
if exist ..\check.cpp (
 g++ -O2 -Wall -Wl,--stack=67108864 ..\check.cpp -o check.exe
) else if exist ..\check.dpr (
 dcc32 -cc ..\check.dpr -e. -I%TESTLIB% -U%TESTLIB%
) else (
 echo Can not compile checker!
)
echo Generating tests...
if exist %TASK%.in (
 erase %TASK%.in
)
if exist small.in (
 copy small.in %TASK%.in
)
if exist gen.cmd (
 call gen.cmd
) else if exist gen.py (
 gen.py >>%TASK%.in
)
echo Processing solution %SOL% on tests...
for /l %%i in (0,1,9) do (
 if exist 0%%i (
  echo Test 0%%i
  copy 0%%i %TASK%.in >nul
  if exist %SOL%.exe (
   %SOL%
  ) else if exist %SOL%.py (
   %SOL%.py
  )
  move %TASK%.out 0%%i.a >nul
 )
)
for /l %%i in (10,1,99) do (
 if exist %%i (
  echo Test %%i
  copy %%i %TASK%.in >nul
  if exist %SOL%.exe (
   %SOL%
  ) else if exist %SOL%.py (
   %SOL%.py
  )
  move %TASK%.out %%i.a >nul
 )
)
for /l %%i in (0,1,9) do (
 if exist 00%%i (
  echo Test 00%%i
  copy 00%%i %TASK%.in >nul
  if exist %SOL%.exe (
   %SOL%
  ) else if exist %SOL%.py (
   %SOL%.py
  )
  move %TASK%.out 00%%i.a >nul
 )
)
for /l %%i in (10,1,99) do (
 if exist 0%%i (
  echo Test 0%%i
  copy 0%%i %TASK%.in >nul
  if exist %SOL%.exe (
   %SOL%
  ) else if exist %SOL%.py (
   %SOL%.py
  )
  move %TASK%.out 0%%i.a >nul
 )
)
for /l %%i in (100,1,999) do (
 if exist %%i (
  echo Test %%i
  copy %%i %TASK%.in >nul
  if exist %SOL%.exe (
   %SOL%
  ) else if exist %SOL%.py (
   %SOL%.py
  )
  move %TASK%.out %%i.a >nul
 )
)
if exist %TASK%.in (
 erase %TASK%.in
)
echo Done!
