@echo off
set TASK=maxsum
if "%1"=="" exit
echo %1
copy %1 %TASK%.in >nul
..\%TASK%_ik
copy %TASK%.out %1.a >nul
..\%TASK%_al
copy %TASK%.out %1.b >nul
..\%TASK%_ik_wa
copy %TASK%.out %1.c >nul
check %1 %1.b %1.a
check %1 %1.c %1.a
