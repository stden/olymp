@echo off
if exist tests goto testsfound
if exist tests\01 goto testsfound
if exist tests\?1 goto testsfound
if exist tests\99 goto testsfound
if exist tests\do??.dpr goto testsfound
if exist tests\*.dpr goto testsfound
for /l %%a in (0,1,9) do call %1 0%%a
for /l %%a in (10,1,99) do call %1 %%a
goto exit
:testsfound
for /l %%a in (0,1,9) do call %1 tests\0%%a
for /l %%a in (10,1,99) do call %1 tests\%%a
:exit