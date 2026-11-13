@echo off
call include.cmd
if exist %SOL%.cpp (
 g++ -O2 -Wall -Wl,--stack=67108864 %SOL%.cpp -o %SOL%.exe
) else if exist %SOL%.dpr (
 dcc32 -cc %SOL%.dpr
)
if exist check.cpp (
 g++ -O2 -Wall -Wl,--stack=67108864 check.cpp -o check.exe
) else if exist check.dpr (
 dcc32 -cc check.dpr -e. -I%TESTLIB% -U%TESTLIB%
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
if exist %SOL%.exe (
 %SOL%
) else if exist %SOL%.py (
 %SOL%.py
)
echo Splitting tests...
splittests.py
echo Done!
