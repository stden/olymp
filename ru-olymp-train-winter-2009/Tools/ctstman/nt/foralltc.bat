@echo off
if exist tests goto testsfound
if exist tests\01 goto testsfound
if exist tests\?1 goto testsfound
if exist tests\99 goto testsfound
if exist tests\do??.dpr goto testsfound
if exist tests\*.dpr goto testsfound
for %%f in (???.) do call %1 %%f %2 %3 %4 %5 %6 %7 %8 %9
goto exit
:testsfound
for %%f in (tests\???.) do call %1 %%f %2 %3 %4 %5 %6 %7 %8 %9
:exit

