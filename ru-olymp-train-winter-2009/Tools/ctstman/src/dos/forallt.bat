@echo off
if exist tests goto testsfound
if exist tests\01 goto testsfound
if exist tests\?1 goto testsfound
if exist tests\99 goto testsfound
if exist tests\do??.dpr goto testsfound
if exist tests\*.dpr goto testsfound
for %%a in (0 1 2 3 4 5 6 7 8 9) do call %ctstman%\foralltd %1 %%a
goto exit
:testsfound
for %%a in (0 1 2 3 4 5 6 7 8 9) do call %ctstman%\foralltd %1 tests\%%a
:exit
