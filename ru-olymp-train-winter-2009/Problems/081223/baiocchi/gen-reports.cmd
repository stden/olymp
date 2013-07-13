@echo off
rem This script should be placed in testsys contest directory \problems
rem along with check.exe compiled with XMLWRITE enabled.
set TASK=baiocchi
for /l %%p in (1,1,9) do (
 if exist ioisols\0%%p.A.tgz (
  tar -xvzpf ioisols\0%%p.A.tgz
  check %TASK%.out %TASK%.out %TASK%.out 2>ioilogs\0%%p.A.xml
  if exist baiocchi.out erase baiocchi.out
 )
)
for /l %%p in (10,1,99) do (
 if exist ioisols\%%p.A.tgz (
  tar -xvzpf ioisols\%%p.A.tgz
  check %TASK%.out %TASK%.out %TASK%.out 2>ioilogs\%%p.A.xml
  if exist baiocchi.out erase baiocchi.out
 )
)
